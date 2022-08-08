//
//  WeatherData.swift
//  TownWeather
//
//  Created by Артур Фомин on 08.08.2022.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
