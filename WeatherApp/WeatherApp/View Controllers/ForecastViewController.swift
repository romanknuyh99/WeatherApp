//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Roman Kniukh on 5.02.21.
//

import UIKit

class ForecastViewController: UIViewController {
    var forecast: Forecast!
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd HH:mm"
        return dateFormatter
    }()
    
    private let temperatureLabel = UILabel()
    private let feelsLikeLabel = UILabel()
    private let conditionsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feelsLikeLabel)
        NSLayoutConstraint.activate([
            feelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelsLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20)
        ])
        
        conditionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conditionsLabel)
        NSLayoutConstraint.activate([
            conditionsLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 20),
            conditionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        title = dateFormatter.string(from: forecast.date)
        temperatureLabel.text = String(Int(forecast.temperature)) + "°C"
        temperatureLabel.font = .systemFont(ofSize: 32, weight: .bold)
        feelsLikeLabel.text = "Feels like: \(Int(forecast.feelsLike))°C"
        feelsLikeLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        conditionsLabel.text = forecast.condition
        conditionsLabel.font = .systemFont(ofSize: 24, weight: .semibold)
    }
}
