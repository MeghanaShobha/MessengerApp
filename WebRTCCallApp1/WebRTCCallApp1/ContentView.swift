//
//  ContentView.swift
//  WebRTCCallApp1
//
//  Created by Meghana IOS on 26/10/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var call = CallManager()
    @State private var roomID = "demo-room-123"

    var body: some View {
        VStack(spacing: 16) {
            Text("WebRTC Video Call")
                .font(.largeTitle)
                .bold()

            TextField("Enter the same room ID on both devices", text: $roomID)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            HStack(spacing: 12) {
                Button("Create Call") {
                    call.createCall(roomID: roomID)
                }
                .buttonStyle(.borderedProminent)

                Button("Join Call") {
                    call.joinCall(roomID: roomID)
                }
                .buttonStyle(.bordered)
            }

            ZStack(alignment: .topTrailing) {
                RTCVideoView(track: call.remoteVideoTrack)
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                if call.remoteVideoTrack == nil {
                    VStack(spacing: 12) {
                        Image(systemName: "video.fill")
                            .font(.system(size: 45))

                        Text("Remote Video")
                            .font(.title2)

                        Text("Waiting for the other device")
                            .font(.caption)
                    }
                    .foregroundStyle(.white)
                }

                RTCVideoView(track: call.localVideoTrack)
                    .frame(width: 110, height: 155)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(12)
            }

            HStack(spacing: 30) {
                Button {
                    call.toggleMicrophone()
                } label: {
                    Image(
                        systemName: call.isMuted
                            ? "mic.slash.fill"
                            : "mic.fill"
                    )
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 58, height: 58)
                    .background(call.isMuted ? Color.orange : Color.gray)
                    .clipShape(Circle())
                }
                .accessibilityLabel(
                    call.isMuted ? "Unmute microphone" : "Mute microphone"
                )

                Button {
                    call.hangUp()
                } label: {
                    Image(systemName: "phone.down.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 68, height: 68)
                        .background(Color.red)
                        .clipShape(Circle())
                }
                .accessibilityLabel("Hang up")

                Button {
                    call.toggleCamera()
                } label: {
                    Image(
                        systemName: call.isCameraOff
                            ? "video.slash.fill"
                            : "video.fill"
                    )
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 58, height: 58)
                    .background(
                        call.isCameraOff ? Color.orange : Color.gray
                    )
                    .clipShape(Circle())
                }
                .accessibilityLabel(
                    call.isCameraOff ? "Turn camera on" : "Turn camera off"
                )
            }

            Text(call.status)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Spacer(minLength: 0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
