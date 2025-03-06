//
//  DeleteMeApp.swift
//  DeleteMe
//
//  Created by Damian Jardim on 3/4/25.
//

import SwiftUI

@main
struct DeleteMeApp: App {
    @StateObject var userData = UserData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
