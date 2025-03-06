//
//  SettingsView.swift
//  DeleteMe
//
//  Created by Damian Jardim on 3/4/25.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var userData:UserData
    
    var body: some View {
        Text("userData.name: \(userData.name)")
        TextField("UserData.Name", text:$userData.name)
    }
}

#Preview {
    SettingsView()
}
