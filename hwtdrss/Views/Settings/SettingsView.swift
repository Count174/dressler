//
//  SettingsView.swift
//  hwtdrss
//
//  Created by Кирилл Кочетков on 17.09.2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Хто я?")
                    .font(.system(size: 24))
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .padding(50)
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "#4d4aed") ?? Color.indigo)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
