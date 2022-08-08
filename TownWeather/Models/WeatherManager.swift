//
//  WeatherManager.swift
//  TownWeather
//
//  Created by Артур Фомин on 08.08.2022.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=1d9640cf8906649056fcdacfafd80277"
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // 1. Create URL
        guard let url  = URL(string: urlString) else {return}
        // 2. Create URLSession
        let session = URLSession(configuration: .default)
        // 3. Give the session a task
        let task = session.dataTask(with: url) {data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            guard let safeData = data else {return}
            
            guard let weather =  parseJSON(safeData) else {return}
            
            delegate?.didUpdateWeather(weatherManager: self, weather: weather)
            
        }
        // 4. Start the task
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            
            let weather = WeatherModel(cityName: cityName, id: id, tempreture: temp)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
