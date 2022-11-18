//
//  WeatherService.swift
//  hwtdrss
//
//  Created by Johnnie Walker on 18.11.2022.
//

import Foundation

// Для часто используемых запросов можно создать отдельный класс-сервис
// (еще называют Manager (WeatherManager))
// или Provider (WeatherProvider)

// лучше использовать названия `request` / `response` / `result` вместо `url` / `data` / `json`
// эти же определения используются в документациях сетевых запросов и что бы не возникало путаницы...

// скорее всего `request` будет отдельным классом. Но это потом, пока можно и URL передать

final class WeatherService {
    // Если нажать комбинацию Option + Comand + /
    // появится удобная форма документирования метода - такой комментарий будет доступен из
    // любой части проекта по Option + [клик мышкой на метод]
    // Удобно

    // любой метод получения данных из сети лучше начинать с `obtain` (obtainModels)
    // любой метод который берет данные из локального репозитория с `get` (obtainDetails)
    // люббой метод, который создает какой-то объект c `create` (createItemCells)

    /// Получить данные о погоде
    /// - Parameters:
    ///   - request: данные для запроса `/v1/current`
    ///   - result: Модель данных о погоде или тип ошибки
    func obtainWeather(for request: URL, result: @escaping (Result<WeatherModel, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { response, _, error in

            // Делать сетевые запросы без обработчика ошибок - плохо
            // акцентируй внимание на теме
            // do { try } catch { }
            
            do {
                guard let response = response else {
                    result(.failure(error ?? URLError(.unknown)))
                    return
                }
                // Не надо декодировать и сразу получать лишь что-то из сабмодели
                // модификацию данных можно выполнить в computed proterty в модели
                //
                // Идея простая - метод всегда возвращает то, что возвращает сервер
                let model = try JSONDecoder().decode(WeatherModel.self, from: response)
                result(.success(model))
            } catch {
                // тут должна быть обработка ошибок
                result(.failure(error ?? URLError(.unknown)))
            }
        }

        task.resume()
    }
}
