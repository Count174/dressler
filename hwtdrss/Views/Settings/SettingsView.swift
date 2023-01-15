//
//  SettingsView.swift
//  hwtdrss
//
//  Created by Кирилл Кочетков on 17.09.2022.
//

import SwiftUI

struct SettingsView: View {
    
    private var cityArray = ["Челябинск", "Екатеринбург", "Москва", "Казань", "Краснодар", "Миасс", "Омск", "Ереван", "Тбилиси", "Санкт-Петербург", "Алматы", ]
    private var genderArray = ["Мужской", "Женский", "Предпочитаю не уточнять"]
    @State private var selectedCityIndex = 0
    @State private var selectedGenderIndex = 0
    @State private var currentDate = Date()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker(selection: $selectedCityIndex, label: Text("Ваш город")) {
                            ForEach(0 ..< cityArray.count) {
                                Text(self.cityArray[$0])
                            }
                        }
                    }
                    Section {
                        Picker(selection: $selectedGenderIndex, label: Text("Ваш пол")) {
                            ForEach(0 ..< genderArray.count) {
                                Text(self.genderArray[$0])
                            }
                        }
                    }
                    Section {
                        DatePicker("Время уведомления", selection: $currentDate, displayedComponents: .hourAndMinute)
                    }
                }
            }
            .padding(10)
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color(hex: "#4d4aed") ?? Color.indigo)
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
