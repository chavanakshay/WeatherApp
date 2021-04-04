//
//  WeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Akshay  Chavan on 01/04/21.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    @IBOutlet weak var dateView: UILabel!
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempratureDiscriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var rainChancesLabel: UILabel!
    
    var fiveDayViewModel:CityViewModel!{
        didSet{
            imageDescriptionLabel.text = fiveDayViewModel.imageDescription
            dateView.text = fiveDayViewModel.dateText
            customImageView.image = fiveDayViewModel.weatherInfoImage
            temperatureLabel.text = fiveDayViewModel.temprature
            tempratureDiscriptionLabel.text = fiveDayViewModel.tempratureDescription
            windLabel.text = fiveDayViewModel.wind
            humidityLabel.text = fiveDayViewModel.humidity
            rainChancesLabel.text = fiveDayViewModel.raintChances
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
