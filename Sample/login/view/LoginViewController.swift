//
//  LoginViewController.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 21/2/25.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtDemo: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    private let viewModel = WeatherViewModel()
    
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            showLoading(true)
            bindViewModel()
            viewModel.fetchWeather(for: "Dhaka")
        }
        
        private func showLoading(_ show: Bool) {
            if show {
                LoadingUtil.shared.showLoading(on: self.view)
                txtDemo.isHidden = true
            } else {
                LoadingUtil.shared.hideLoading()
                txtDemo.isHidden = false
            }
        }
        
        private func bindViewModel() {
            viewModel.bind(
                weatherUpdate: { [weak self] weatherData in
                    DispatchQueue.main.async {
                        self?.showLoading(false)
                        self?.txtDemo.text = """
                        City: \(weatherData.cityName)
                        Temperature: \(weatherData.temperature)
                        Description: \(weatherData.description)
                        \(weatherData.humidity)
                        """
                    }
                },
                error: { [weak self] error in
                    DispatchQueue.main.async {
                        self?.showLoading(false)
                        AlertUtil.showAlert(on: self!,
                                            title: "Error",
                                            message: error)
                    }
                }
            )
        }
    }
