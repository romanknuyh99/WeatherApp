//
//  ViewController.swift
//  WeatherApp
//
//  Created by Roman Kniukh on 3.02.21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var table: UITableView!
    
    // MARK: - Variables
    var networkWeatherManager = NetworkWeatherManager()
    private var currentWeather: CurrentWeather?
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    // MARK: - Actions
    @IBAction func searchPressed(_ sender: Any) {
        self.presentSearchAlertController(withTitle: "Enter your city", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
            
        }
    }
    
    // MARK: - Lice Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table?.dataSource = self
        table?.delegate = self
        networkWeatherManager.onComplition = { [weak self] currentWeather in
            DispatchQueue.main.async {
                self?.title = currentWeather.cityName
                self?.currentWeather = currentWeather
                self?.table?.reloadData()
            }
        }
        
        networkWeatherManager.fetchCurrentWeather(forCity: "Minsk")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let item = currentWeather?.forecasts[table.indexPathForSelectedRow?.row ?? 0] else {
            return
        }
        let destination = segue.destination as? ForecastViewController
        destination?.forecast = item
    }
}

// MARK: - UITableViewDataSource implementation

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWeather?.forecasts.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") ?? UITableViewCell()
        guard let item = currentWeather?.forecasts[indexPath.row] else {
            return cell
        }
        let title = dateFormatter.string(from: item.date)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = String(Int(item.temperature)) + " °C"
        return cell
    }
}

// MARK: - UITableViewDelegate implementation

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = currentWeather?.forecasts[table.indexPathForSelectedRow?.row ?? 0] else {
            return
        }
        let forecastController = ForecastViewController()
        forecastController.forecast = item
        navigationController?.pushViewController(forecastController, animated: true)
    }
}

