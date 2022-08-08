//
//  WeatherModel.swift
//  TownWeather
//
//  Created by Артур Фомин on 08.08.2022.
//

import Foundation

struct WeatherModel {
    
    let cityName: String
    let id: Int
    let tempreture: Double
    var tempString: String {
        return String(format: "%.1f", tempreture)
    }
    
    var weatherName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...504:
            return "cloud.rain"
        case 511:
            return "cloud.snow"
        case 520...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "aqi.low"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        case 802:
            return "cloud"
        case 803...804:
            return "cloud.fill"
        default:
            return "location.slash"
        }
    }
    
}
