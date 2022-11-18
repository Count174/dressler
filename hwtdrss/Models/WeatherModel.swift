//
//  WeatherModel.swift
//  hwtdrss
//
//  Created by Johnnie Walker on 18.11.2022.
//

import Foundation

// Почти всегда - модель, сервис или вью - это отдельный файл в XCode проекте

struct WeatherModel: Codable {
    // Почти всегда параметры модели - опциональные значения
    // Если только твой бэекэндер не сказал обратного - это важная часть контракта
    let current: CurrentWeather?
}

struct CurrentWeather: Codable {
    let windSpeed: Double
    let tempInCelsius: Double
    let feelsLike: Double

    // Называй переменные через camelCase
    // для соответсвия ключам с сервера есть CodingKey
    // Советую взять объяснения из книги
    // https://flight.school/books/codable/
    
    enum CodingKeys: String, CodingKey {
        case windSpeed = "wind_kph"
        case tempInCelsius = "temp_c"
        case feelsLike = "feelslike_c"
    }
}

// MARK: - Heplers

extension WeatherModel {
    var feelLikeTempString: String {
        guard let feelsLike = current?.feelsLike else { return "Undefined" }
        return String(feelsLike)
    }
}
