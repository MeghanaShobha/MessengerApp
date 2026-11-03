//
//  CallManager.swift
//  WebRTCCallApp1
//
//  Created by Meghana IOS on 26/10/26.
//
import Foundation
import AVFoundation
import FirebaseFirestore
import WebRTC
import Combine


final class CallManager: NSObject, ObservableObject {
    @Published var localVideoTrack: RTCVideoTrack?
    @Published var remoteVideoTrack: RTCVideoTrack?
    @Published var status = "Ready to connect"
    @Published var isMuted = false
    @Published var isCameraOff = false

    private let factory: RTCPeerConnectionFactory
    private let db = Firestore.firestore()

    private var peerConnection: RTCPeerConnection?
    private var cameraCapturer: RTCCameraVideoCapturer?
    private var localAudioTrack: RTCAudioTrack?
    private var roomRef: DocumentReference?

    private var roomListener: ListenerRegistration?
    private var candidateListener: ListenerRegistration?

    private var isCaller = false
    private var hasRemoteDescription = false
    private var handledAnswer = false
    private var pendingCandidates: [RTCIceCandidate] = []

    override init() {
        RTCInitializeSSL()
        factory = RTCPeerConnectionFactory()
        super.init()
    }


    private func prepareMedia(
        completion: @escaping (Bool) -> Void
    ) {
        AVCaptureDevice.requestAccess(for: .video) { videoGranted in
            guard videoGranted else {
                DispatchQueue.main.async {
                    self.status = "Camera permission denied"
                    completion(false)
                }
                return
            }

            AVCaptureDevice.requestAccess(for: .audio) { audioGranted in
                DispatchQueue.main.async {
                    guard audioGranted else {
                        self.status = "Microphone permission denied"
                        completion(false)
                        return
                    }

                    do {
                        try self.setupLocalMedia()
                        completion(true)
                    } catch {
                        self.status = error.localizedDescription
                        completion(false)
                    }
                }
            }
        }
    }

    private func setupLocalMedia() throws {
        let audioSession = AVAudioSession.sharedInstance()

        try audioSession.setCategory(
            .playAndRecord,
            mode: .videoChat,
            options: [.defaultToSpeaker, .allowBluetooth]
        )
        try audioSession.setActive(true)

        let videoSource = factory.videoSource()

        let capturer = RTCCameraVideoCapturer(
            delegate: videoSource
        )
        cameraCapturer = capturer

        let audioSource = factory.audioSource(
            with: RTCMediaConstraints(
                mandatoryConstraints: nil,
                optionalConstraints: nil
            )
        )

        let videoTrack = factory.videoTrack(
            with: videoSource,
            trackId: "video0"
        )

        let audioTrack = factory.audioTrack(
            with: audioSource,
            trackId: "audio0"
        )

        localVideoTrack = videoTrack
        localAudioTrack = audioTrack

        isMuted = false
        isCameraOff = false

        guard let camera = RTCCameraVideoCapturer.captureDevices()
            .first(where: { $0.position == .front })
            ?? RTCCameraVideoCapturer.captureDevices().first
        else {
            throw NSError(
                domain: "WebRTCCallApp",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey: "No camera found"
                ]
            )
        }

        guard let format = RTCCameraVideoCapturer
            .supportedFormats(for: camera)
            .first
        else {
            throw NSError(
                domain: "WebRTCCallApp",
                code: 2,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "No supported camera format found"
                ]
            )
        }

        let maxFPS = format.videoSupportedFrameRateRanges
            .map { $0.maxFrameRate }
            .max() ?? 30

        capturer.startCapture(
            with: camera,
            format: format,
            fps: Int(min(30, maxFPS))
        )

        status = "Camera ready"
    }


    private func createPeerConnection() -> Bool {
        let configuration = RTCConfiguration()

        configuration.iceServers = [
            RTCIceServer(
                urlStrings: [
                    "stun:stun.l.google.com:19302"
                ]
            )
        ]

        let constraints = RTCMediaConstraints(
            mandatoryConstraints: nil,
            optionalConstraints: nil
        )

        guard let connection = factory.peerConnection(
            with: configuration,
            constraints: constraints,
            delegate: self
        ) else {
            status = "Could not create peer connection"
            return false
        }

        peerConnection = connection

        if let localVideoTrack {
            connection.add(localVideoTrack, streamIds: ["stream0"])
        }

        if let localAudioTrack {
            connection.add(localAudioTrack, streamIds: ["stream0"])
        }

        return true
    }


    func createCall(roomID: String) {
        let id = roomID.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !id.isEmpty else {
            status = "Enter a room ID"
            return
        }

        status = "Preparing camera and microphone"

        prepareMedia { [weak self] success in
            guard let self, success else { return }

            self.isCaller = true
            self.hasRemoteDescription = false
            self.handledAnswer = false
            self.pendingCandidates.removeAll()

            self.roomRef = self.db.collection("rooms").document(id)

            guard self.createPeerConnection(),
                  let roomRef = self.roomRef,
                  let connection = self.peerConnection else {
                return
            }

            self.status = "Creating call room"

            roomRef.setData([
                "createdAt": FieldValue.serverTimestamp(),
                "ended": false
            ]) { error in
                if let error {
                    self.status = error.localizedDescription
                    return
                }

                self.listenForRoomUpdates()
                self.listenForCandidates(
                    collection: "calleeCandidates"
                )

                let constraints = RTCMediaConstraints(
                    mandatoryConstraints: [
                        "OfferToReceiveAudio": "true",
                        "OfferToReceiveVideo": "true"
                    ],
                    optionalConstraints: nil
                )

                connection.offer(for: constraints) {
                    offer, error in

                    if let error {
                        self.status = error.localizedDescription
                        return
                    }

                    guard let offer else {
                        self.status = "Could not create offer"
                        return
                    }

                    connection.setLocalDescription(offer) {
                        error in

                        if let error {
                            self.status = error.localizedDescription
                            return
                        }

                        roomRef.updateData([
                            "offer": [
                                "type": "offer",
                                "sdp": offer.sdp
                            ]
                        ]) { error in
                            DispatchQueue.main.async {
                                if let error {
                                    self.status = error.localizedDescription
                                } else {
                                    self.status = "Waiting for receiver"
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func joinCall(roomID: String) {
        let id = roomID.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !id.isEmpty else {
            status = "Enter a room ID"
            return
        }

        status = "Preparing camera and microphone"

        prepareMedia { [weak self] success in
            guard let self, success else { return }

            self.isCaller = false
            self.hasRemoteDescription = false
            self.handledAnswer = false
            self.pendingCandidates.removeAll()

            self.roomRef = self.db.collection("rooms").document(id)

            guard self.createPeerConnection(),
                  let roomRef = self.roomRef,
                  let connection = self.peerConnection else {
                return
            }

            self.status = "Finding call"

            roomRef.getDocument { snapshot, error in
                if let error {
                    self.status = error.localizedDescription
                    return
                }

                guard let data = snapshot?.data(),
                      let offerData = data["offer"] as? [String: Any],
                      let sdp = offerData["sdp"] as? String
                else {
                    self.status = "Call not found or offer not ready"
                    return
                }

                let offer = RTCSessionDescription(
                    type: .offer,
                    sdp: sdp
                )

                self.listenForRoomUpdates()
                self.listenForCandidates(
                    collection: "callerCandidates"
                )

                connection.setRemoteDescription(offer) { error in
                    if let error {
                        self.status = error.localizedDescription
                        return
                    }

                    self.hasRemoteDescription = true
                    self.addPendingCandidates()

                    let constraints = RTCMediaConstraints(
                        mandatoryConstraints: [
                            "OfferToReceiveAudio": "true",
                            "OfferToReceiveVideo": "true"
                        ],
                        optionalConstraints: nil
                    )

                    connection.answer(for: constraints) {
                        answer, error in

                        if let error {
                            self.status = error.localizedDescription
                            return
                        }

                        guard let answer else {
                            self.status = "Could not create answer"
                            return
                        }

                        connection.setLocalDescription(answer) {
                            error in

                            if let error {
                                self.status = error.localizedDescription
                                return
                            }

                            roomRef.updateData([
                                "answer": [
                                    "type": "answer",
                                    "sdp": answer.sdp
                                ]
                            ]) { error in
                                DispatchQueue.main.async {
                                    if let error {
                                        self.status = error.localizedDescription
                                    } else {
                                        self.status = "Connecting..."
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    private func listenForRoomUpdates() {
        guard let roomRef else { return }

        roomListener = roomRef.addSnapshotListener {
            [weak self] snapshot, error in

            guard let self else { return }

            if let error {
                DispatchQueue.main.async {
                    self.status = error.localizedDescription
                }
                return
            }

            guard let data = snapshot?.data() else { return }

            if data["ended"] as? Bool == true {
                DispatchQueue.main.async {
                    self.cleanupLocal(status: "Call ended")
                }
                return
            }

            guard self.isCaller,
                  !self.handledAnswer,
                  let answerData = data["answer"] as? [String: Any],
                  let sdp = answerData["sdp"] as? String,
                  let connection = self.peerConnection
            else {
                return
            }

            self.handledAnswer = true

            let answer = RTCSessionDescription(
                type: .answer,
                sdp: sdp
            )

            connection.setRemoteDescription(answer) {
                error in

                if let error {
                    DispatchQueue.main.async {
                        self.status = error.localizedDescription
                    }
                    return
                }

                self.hasRemoteDescription = true
                self.addPendingCandidates()

                DispatchQueue.main.async {
                    self.status = "Answer received. Connecting..."
                }
            }
        }
    }

    private func listenForCandidates(collection: String) {
        guard let roomRef else { return }

        candidateListener = roomRef.collection(collection)
            .addSnapshotListener { [weak self] snapshot, error in

                guard let self else { return }

                if let error {
                    DispatchQueue.main.async {
                        self.status = error.localizedDescription
                    }
                    return
                }

                for change in snapshot?.documentChanges ?? []
                where change.type == .added {
                    let data = change.document.data()

                    guard let candidateText =
                            data["candidate"] as? String,
                          let sdpMid =
                            data["sdpMid"] as? String,
                          let lineIndex =
                            data["sdpMLineIndex"] as? Int32
                                ?? (data["sdpMLineIndex"] as? NSNumber)?
                                    .int32Value
                    else {
                        continue
                    }

                    let candidate = RTCIceCandidate(
                        sdp: candidateText,
                        sdpMLineIndex: lineIndex,
                        sdpMid: sdpMid
                    )

                    if self.hasRemoteDescription {
                        self.peerConnection?.add(candidate)
                    } else {
                        self.pendingCandidates.append(candidate)
                    }
                }
            }
    }

    private func addPendingCandidates() {
        guard hasRemoteDescription else { return }

        let candidates = pendingCandidates
        pendingCandidates.removeAll()

        for candidate in candidates {
            peerConnection?.add(candidate)
        }
    }

    func toggleMicrophone() {
        isMuted.toggle()
        localAudioTrack?.isEnabled = !isMuted
    }

    func toggleCamera() {
        isCameraOff.toggle()
        localVideoTrack?.isEnabled = !isCameraOff
    }

    func hangUp() {
        let oldRoom = roomRef

        oldRoom?.updateData(["ended": true]) { _ in }

        cleanupLocal(status: "Call ended")
    }

    private func cleanupLocal(status newStatus: String) {
        roomListener?.remove()
        candidateListener?.remove()

        roomListener = nil
        candidateListener = nil

        cameraCapturer?.stopCapture()
        cameraCapturer = nil

        peerConnection?.close()
        peerConnection = nil

        roomRef = nil
        localVideoTrack = nil
        remoteVideoTrack = nil
        localAudioTrack = nil

        hasRemoteDescription = false
        handledAnswer = false
        pendingCandidates.removeAll()

        isMuted = false
        isCameraOff = false

        try? AVAudioSession.sharedInstance().setActive(
            false,
            options: .notifyOthersOnDeactivation
        )

        status = newStatus
    }
}


extension CallManager: RTCPeerConnectionDelegate {
    func peerConnection(
        _ peerConnection: RTCPeerConnection,
        didGenerate candidate: RTCIceCandidate
    ) {
        guard let roomRef else { return }

        let collection = isCaller
            ? "callerCandidates"
            : "calleeCandidates"

        roomRef.collection(collection).addDocument(data: [
            "candidate": candidate.sdp,
            "sdpMid": candidate.sdpMid ?? "",
            "sdpMLineIndex": Int(candidate.sdpMLineIndex)
        ]) { error in
            if let error {
                DispatchQueue.main.async {
                    self.status = error.localizedDescription
                }
            }
        }
    }

    func peerConnection(
        _ peerConnection: RTCPeerConnection,
        didAdd stream: RTCMediaStream
    ) {
        guard let track = stream.videoTracks.first else { return }

        DispatchQueue.main.async {
            self.remoteVideoTrack = track
            self.status = "Remote video received"
        }
    }

    func peerConnection(
        _ peerConnection: RTCPeerConnection,
        didChange stateChanged: RTCSignalingState
    ) {}

    func peerConnection(
        _ peerConnection: RTCPeerConnection,
        didRemove stream: RTCMediaStream
    ) {}

    func peerConnectionShouldNegotiate(
        _ peerConnection: RTCPeerConnection
    ) {}

    func peerConnection(
        _ peerConnection: RTCPeerConnection,
        didChange newState: RTCIceConnectionState
    ) {
        DispatchQueue.main.async {
            switch newState {
            case .connected, .completed:
                self.status = "Connected"
            case .checking:
                self.status = "Connecting..."
            case .disconnected:
                self.status = "Connection interrupted"
            case .failed:
                self.status = "Connection failed. Check network/TURN."
            case .closed:
                self.status = "Call closed"
            default:
                break
            }
        }
    }

    func peerConnection(
        _ peerConnection: RTCPeerConnection,
        didChange newState: RTCIceGatheringState
    ) {}

    func peerConnection(
        _ peerConnection: RTCPeerConnection,
        didRemove candidates: [RTCIceCandidate]
    ) {}

    func peerConnection(
        _ peerConnection: RTCPeerConnection,
        didOpen dataChannel: RTCDataChannel
    ) {}
}
