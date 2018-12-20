//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by David D on 12/18/18.
//  Copyright © 2018 David D. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherApiClient = WeatherAPIClient()
        let weatherEndpoint = WeatherEndpoint.tenDayForecast(city: "Los Angeles", state: "CA")
        weatherApiClient.weather(with: weatherEndpoint) { (result) in
            switch result {
            case .value(let forecastText):
                print(forecastText)
            case .error(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)

        // Configure the cell...

        return cell
    }
}
