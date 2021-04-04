//
//  CityTableViewCell.swift
//  Weather App
//
//  Created by Akshay  Chavan on 31/03/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    var cityViewModel:CityViewModel!{
        didSet{
            location.text = cityViewModel.name
            temprature.text = cityViewModel.temprature
            customImageView.image = cityViewModel.weatherInfoImage
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
    
//    func setData(location:String?,temparature:Double?,description:String?)  {
//        self.location.text = location ?? ""
//        self.temprature.text = "\(temparature ?? 0.00)°"
//        
//        switch description ?? "" {
//            case "Clear":
//                customImageView.image = UIImage(systemName: "sun.max")
//            default:
//                customImageView.image = UIImage(systemName: "cloud")
//        }
//    }
    
}
