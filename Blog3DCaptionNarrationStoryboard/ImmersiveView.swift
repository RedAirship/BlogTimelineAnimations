//
//  ImmersiveView.swift
//  Blog3DCaptionNarrationStoryboard
//
//  Created by Paul on 3/1/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

fileprivate extension String {
    static let endOfMasterTimelineNotificationAction = "EndOfMasterTimelineNotificationAction"
}

struct ImmersiveView: View {
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    private let notificationPublisher = NotificationCenter.default.publisher(for: .realityKitNotificationTrigger)
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            guard let storyboardEntity = try? await Entity(named: "3DCaptionAndNarration/3DCaptionAndNarration", in: realityKitContentBundle) else {
                print("\(#function) \(#line) missing entity")
                assertionFailure("missing entity")
                return
            }
            print("\(#function) \(#line) added 3DCaptionAndNarration scene")
            content.add(storyboardEntity)
        }
        .onReceive(notificationPublisher) { output in
            print("\(#function) \(#line) `onReceive(notificationPublisher)`")
            guard let notificationName = output.userInfo?["RealityKit.NotificationTrigger.Identifier"] as? String else {
                print("\(#function) \(#line) missing notificationName")
                assertionFailure("missing notificationName")
                return
            }

            switch notificationName {
            case .endOfMasterTimelineNotificationAction:
                print("\(#function) \(#line) endOfMasterTimelineNotificationAction received")
                endOfMasterTimelineNotificationAction()
            default:
                print("\(#function) \(#line) unhandled notificationName \(notificationName)")
                assertionFailure("unhandled notificationName \(notificationName)")
                return
            }
        }
    }
    
    func endOfMasterTimelineNotificationAction() {
        print("\(#function) \(#line)")
        Task {
            await dismissImmersiveSpace()
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
