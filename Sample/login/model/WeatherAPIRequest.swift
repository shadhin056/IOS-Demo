//
//  Untitled.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//
 
import Alamofire

enum WeatherAPIRequest: NetworkRequest {
    case getCurrentWeather(city: String)
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return APIConfig.Endpoints.weather
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentWeather:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCurrentWeather(let city):
            return [
                "q": city,
                "appid": APIConfig.apiKey,
                "units": "metric"
            ]
        }
    }
    
    var headers: HTTPHeaders? {
        return HTTPHeaderFields.applicationJson.headers
    }
}
