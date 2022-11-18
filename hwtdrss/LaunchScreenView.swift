//
//  LaunchScreenView.swift
//  hwtdrss
//
//  Created by Кирилл Кочетков on 08.09.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
    //                Image(systemName: "hwtdrss_appstore_01.png")
                    Image(uiImage: #imageLiteral(resourceName: "hwtdrss_appstore_01.png"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 436, height: 896, alignment: .topLeading)
                        .clipped()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.isActive = true
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
