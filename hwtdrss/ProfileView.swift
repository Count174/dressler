//
//  ProfileView.swift
//  hwtdrss
//
//  Created by Кирилл Кочетков on 11.09.2022.
//

import SwiftUI
import Foundation


var final: WeatherResult?
var final2: ViewContent?

let hwtdrssColor = Color(0x4D4AED)
let tempInfo = final2?.weatherString

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Сегодня на улице" + "\(String(describing: getWeatherInfo()))")
//                Text("\(String(describing: tempInfo))")
                    .font(.system(size: 24))
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .padding(50)
                Text("Советую надеть пальто или тренч, а под него стоит надеть теплый свитер 🧥")
                    .font(.system(size: 16))
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding(20)
            }
            .navigationTitle("Что надеть?")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(hwtdrssColor)
        }
        .onAppear {
            getWeatherInfo()
        }
    }
}

struct Response: Codable {
    let current: WeatherResult
}

struct WeatherResult: Codable {
    let wind_kph: Float
    let temp_c: Float
    let feelslike_c: Float
}

struct ViewContent: Codable {
    let weatherString: String
}


// Запрашиваем данные с сервера
// Результат отдаем через `result`
func loadWeatherInfo(result: @escaping (Result<WeatherResult, Error>) -> Void) {
    let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=c5cc45f41cc743758af110518212507&q=chelyabinsk&days=1&aqi=yes&alerts=yes&lang=ru")!
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard
            let data = data,
            let json = try? JSONDecoder().decode(Response.self, from: data)
        else {
            result(.failure(error ?? URLError(.unknown)))
            return
        }
        
        result(.success(json.current))
    }
    
    task.resume()
}

// Этот метод использует полученные данные
func getWeatherInfo() {
    loadWeatherInfo() { finalResult in
        switch finalResult {
        case let .success(weather):
            print("Погодные условия сейчас такие: \(weather.temp_c)")
            
        case let .failure(error):
            print("Ошибка в получении погоды: \(error.localizedDescription)")
        }
    }
}


    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
    
    extension Color {
        init(_ hex: UInt, alpha: Double = 1) {
            self.init(
                .sRGB,
                red: Double((hex >> 16) & 0xFF) / 255,
                green: Double((hex >> 8) & 0xFF) / 255,
                blue: Double(hex & 0xFF) / 255,
                opacity: alpha
            )
        }
    }

