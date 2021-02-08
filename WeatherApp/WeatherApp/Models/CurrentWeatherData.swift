//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Roman Kniukh on 3.02.21.
//

import Foundation

struct CurrentWeatherData: Codable {
    let city: City
    let list: [List]
}

struct City: Codable {
    let name: String
    
}

struct List: Codable {
    let dtTxt: String
    let main: MainClass
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case main, weather
        case dtTxt = "dt_txt"
    }
}

struct MainClass: Codable {
    let temp, feelsLike: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        
    }
}

struct Weather: Codable {
    let id: Int
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case condition = "description"
    }
}
