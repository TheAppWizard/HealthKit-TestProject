//
//  MainView.swift
//  stepOmeterSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 06/01/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            LoadStepsView()
                .tabItem {
                    Label("Steps", systemImage: "list.dash")
                }

            SettingsView()
                .tabItem {
                    Label("Step Count", systemImage: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
