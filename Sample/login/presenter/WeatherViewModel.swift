//
//  WeatherViewModel.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//
 
class WeatherViewModel {
    private var weatherUpdateHandler: ((WeatherViewData) -> Void)?
    private var errorHandler: ((String) -> Void)?
    
    struct WeatherViewData {
        let cityName: String
        let temperature: String
        let description: String
        let humidity: String
    }
    
    func bind(weatherUpdate: @escaping (WeatherViewData) -> Void,
              error: @escaping (String) -> Void) {
        self.weatherUpdateHandler = weatherUpdate
        self.errorHandler = error
    }
    
    func fetchWeather(for city: String) {
        
        let request = WeatherAPIRequest.getCurrentWeather(city: city)
        
        NetworkManager.shared.request(request, type: WeatherResponse.self) { [weak self] result in
            switch result {
            case .success(let weatherResponse):
                let viewData = WeatherViewData(
                    cityName: weatherResponse.name,
                    temperature: "\(Int(weatherResponse.main.temp))°C",
                    description: weatherResponse.weather.first?.description.capitalized ?? "No description",
                    humidity: "Humidity: \(weatherResponse.main.humidity)%"
                )
                self?.weatherUpdateHandler?(viewData)
                
            case .failure(let error):
                self?.errorHandler?(error.localizedDescription)
            }
        }
    }
     
}
