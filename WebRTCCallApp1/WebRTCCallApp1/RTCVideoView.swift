//
//  RTCVideoView.swift
//  WebRTCCallApp1
//
//  Created by Meghana IOS on 26/10/26.
//
import SwiftUI
import WebRTC

struct RTCVideoView: UIViewRepresentable {
    let track: RTCVideoTrack?

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> RTCMTLVideoView {
        let videoView = RTCMTLVideoView()
        videoView.videoContentMode = .scaleAspectFill
        return videoView
    }

    func updateUIView(
        _ uiView: RTCMTLVideoView,
        context: Context
    ) {
        if context.coordinator.currentTrack !== track {
            context.coordinator.currentTrack?.remove(uiView)

            if let track {
                track.add(uiView)
            }

            context.coordinator.currentTrack = track
        }
    }

    static func dismantleUIView(
        _ uiView: RTCMTLVideoView,
        coordinator: Coordinator
    ) {
        coordinator.currentTrack?.remove(uiView)
        coordinator.currentTrack = nil
    }

    class Coordinator {
        var currentTrack: RTCVideoTrack?
    }
}
