//
//  ContentView.swift
//  hwtdrss
//
//  Created by Кирилл Кочетков on 04.09.2022.
//

import SwiftUI
import Foundation

struct ContentView: View {
    init() {
        UITabBar.appearance()
//            .backgroundColor = UIColor(red: 77, green: 74, blue: 237, alpha: 0)
    }
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Погода и лук", systemImage: "cloud.sun.rain") // "beach.umbrella" can also be useful there
                    Text("Погода и лук")
                }
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                    Text("Настройки")
                }
        }
        .accentColor(.white)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
