//
//  AlertTableViewCell.swift
//  Tourism app
//
//  Created by Rafi on 11/11/2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nightWeatherLabel: UILabel!
    @IBOutlet weak var nightImageView: UIImageView!
    @IBOutlet weak var tempDescLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var dayImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    static let cellIdentifier = "weather_cell_identifier"
    
    var dailyForecast: DailyForecasts? {
        didSet {
            dayImageView.image = UIImage(named: "\(dailyForecast?.day?.icon ?? 1)")
            tempDescLabel.text = dailyForecast?.day?.iconPhrase
            temperatureLabel.text = "\(dailyForecast?.temperature?.minimum?.value ?? 0) F"
            maxTempLabel.text = "Maximum Temperature will be \(dailyForecast?.temperature?.maximum?.value ?? 0) F"
            nightImageView.image = UIImage(named: "\(dailyForecast?.night?.icon ?? 1)")
            nightWeatherLabel.text = dailyForecast?.night?.iconPhrase
            
            let stringArray = dailyForecast?.date?.split(separator: "T")
            dateLabel.text = "\(stringArray?[0] ?? "")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
