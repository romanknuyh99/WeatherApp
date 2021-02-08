//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Roman Kniukh on 3.02.21.
//

import Foundation

struct Forecast {
    let temperature: Double
    let feelsLike: Double
    let date: Date
    let condition: String
}

struct CurrentWeather {
    let cityName: String
    let forecasts: [Forecast]
//    let temperature: Double
//    let theData: String
//    var temperatureString: String {
//        return "\(temperature.rounded())"
//    }
//
//    let feelsLike: Double
//    var FeelsLikeTemperatureString: String {
//        return "\(feelsLike.rounded())"
//    }
//
//    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.city.name
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        forecasts = currentWeatherData.list.map {
            return Forecast(
                temperature: $0.main.temp,
                feelsLike: $0.main.feelsLike,
                date: dateformatter.date(from: $0.dtTxt) ?? Date(),
                condition: $0.weather.first?.condition ?? ""
            )
        }
    }
}
