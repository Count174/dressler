//
//  ProfileView.swift
//  hwtdrss
//
//  Created by Кирилл Кочетков on 11.09.2022.
//

import Foundation
import SwiftUI

// У тебя были объявлены глобальные переменные
// Так не надо делать никогда))
// Даже на тестовом проекте

// Все комплиментарыне модули надо группировать по папкам
// смотри примерное разделение, что я тебе создал
// Рекомендую так же поставить в настройках macOS хоткеи для XCode под
//
// Sort by Name
// Sort by Type
//
// Это позволит сортировать фалы и папки в общей структуре
// А - аккуратность

struct ProfileView: View {
    // MARK: - Dependencies
    
    // Если класс имеет вмешнюю зависимость (обращается к другому классу за данныеми)
    // То лучше собрать все зависимости под одной маркой MARK: - Dependencies ☝️
    // Даже если это лишь одна зависимость
    // Скорее всего скоро появятся еще))
    
    let weatherService = WeatherService()
    
    // MARK: - Properties
    
    // Все вычисляемые и передаваемые свойства удобно хранить под своей маркой
    // Вообще для марок супер удобно сделать сниппеты
    
    let serverURL = URL(string: "https://api.weatherapi.com/v1/current.json?key=c5cc45f41cc743758af110518212507&q=chelyabinsk&days=1&aqi=yes&alerts=yes&lang=ru")!
    @State private var adviceText = String()

    // Основная ошибка была тут - @State свойство сообщает, что при изменении этого свойства надо перерисовать View
    @State private var weather: WeatherModel? = nil
    @State private var advice: AdviceModel? = nil

    var body: some View {
        NavigationView {
            VStack {
                
                // Лучше создать отдельную переменную, а не получать данные одновременно с интерполяцией
                Text("Сегодня на улице \(weather?.tempInCelciusString ?? "0")°C, ощущается как \(weather?.feelLikeTempString ?? "0")°C, ветер \(weather?.windSpeedString ?? "0") м/с")
                    .font(.system(size: 24))
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .padding(50)
                
                Text(adviceText)
                    .font(.system(size: 16))
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding(20)
            }
            .navigationTitle("Что по погоде?")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "#4d4aed") ?? Color.indigo)
        }
        .onAppear {
            // Кажется ничего страшного, если обработать замыкание так
            // нет смысла создавать отдельный метод, если обработчик займет 10 строк
            weatherService.obtainWeather(
                for: serverURL
            ) { result in
                switch result {
                case let .success(response):
                    weather = response
                    var temp = weather?.tempInCelciusDouble
                    
                    if (temp == 0.00) {
                        print("Zero degrees adivce")
                    } else if (temp == 99.97) {
                        print("99 degrees advice")
                    } else if (temp! > -15.0 || temp! < 0.0) {
//                        adviceText = advice?.mainTextString ?? "Undefined"
                        adviceText = (advice?.mainTextString ?? "чет сломалось определенно")
                        print(advice?.mainTextString)
                    } else {
                        adviceText = "Простите, но кажется что-то сломалось. Скорее всего, разработчик уже в курсе и скоро исправит ситуацию"
                        print("Нихуя не работает")
                    }
                    
                    print(weather?.tempInCelciusDouble ?? "Error")

                case let .failure(error):
                    // Тут я просто приравнял к nil что бы показать, что обычно надо
                    // обрабатывать состояние ответа в UI
                    // Скорее всего ты и так знаешь, но напомню.
                    weather = nil
                    print("Ошибка в получении погоды: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
