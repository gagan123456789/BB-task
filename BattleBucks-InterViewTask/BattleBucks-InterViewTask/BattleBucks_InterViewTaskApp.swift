//
//  BattleBucks_InterViewTaskApp.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import SwiftUI

@main
struct BattleBucks_TaskApp: App {
    var body: some Scene {
        WindowGroup {
            ImageListView(viewModel: .init())
        }
    }
}

