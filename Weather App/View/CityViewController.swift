//
//  CityViewController.swift
//  Weather App
//
//  Created by Akshay  Chavan on 30/03/21.
//

import UIKit

class CityViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todayForcastView: UIView!
    var city:CityViewModel?
    var cityFiveDayForecast:[[CityViewModel]?]?
    
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempratureDiscriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var rainChancesLabel: UILabel!
    @IBOutlet weak var trangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.city?.name
        let nib = UINib(nibName: "TempDetailsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Temprature")
        // Do any additional setup after loading the view.
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(bookMarkTapped))
        self.navigationItem.rightBarButtonItem = rightBarButton
        setData()
        tableView.reloadData()
    }
    
    @objc private func bookMarkTapped(){
        guard let city = self.city else {
            return
        }
        CityFiveDayForecastService().bookMark(city:city) {[weak self] (message) in
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setData(){
        imageView.image = city?.weatherInfoImage
        imageDescriptionLabel.text = city?.imageDescription
        temperatureLabel.text = city?.temprature
        tempratureDiscriptionLabel.text = city?.tempratureDescription
        humidityLabel.text = city?.humidity
        windLabel.text = city?.wind
        rainChancesLabel.text = city?.raintChances
    }
    
    @IBAction func trangleTapped(_ sender: Any) {
        if todayForcastView.isHidden == true{
            UIView.animate(withDuration: 2.0) {
                self.todayForcastView.isHidden = false
                self.trangleButton.setBackgroundImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
            }
        }else{
            UIView.animate(withDuration: 2.0) {
                self.todayForcastView.isHidden = true
                self.trangleButton.setBackgroundImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
            }
            
        }
    }
    
}

extension CityViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityFiveDayForecast?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TempDetailsCell = tableView.dequeueReusableCell(withIdentifier: "Temprature")! as! TempDetailsCell
        let listObjArray = cityFiveDayForecast?[indexPath.row]
        cell.dataArray = listObjArray
        cell.reloadCollectionView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 288
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            todayForcastView.isHidden = true
        } else {
            todayForcastView.isHidden = false
        }
        
    }
}
