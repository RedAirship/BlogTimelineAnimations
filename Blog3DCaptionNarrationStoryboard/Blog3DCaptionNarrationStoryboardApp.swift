//
//  Blog3DCaptionNarrationStoryboardApp.swift
//  Blog3DCaptionNarrationStoryboard
//
//  Created by Paul on 3/1/25.
//

import SwiftUI

@main
struct Blog3DCaptionNarrationStoryboardApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
     }
}
