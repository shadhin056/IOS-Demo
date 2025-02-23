//
//  WeatherResponse.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//
 
import Foundation

struct WeatherResponse: Codable {
    let name: String  
    let main: MainWeather
    let weather: [Weather]
}

struct MainWeather: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
}
