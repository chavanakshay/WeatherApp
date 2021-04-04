//
//  HomeViewController.swift
//  Weather App
//
//  Created by Akshay  Chavan on 30/03/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var progressView:UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let homeViewModel = HomeViewModel(cityService: CityService())
    var cities = [CityViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CITY")
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        let action = UIAction { [weak self](action) in
            self?.helpButtonTapped()
        }
        let settingAction = UIAction { [weak self](action) in
            self?.settingsButtonTapped()
        }
        let image = UIImage(named: "settings")
        let leftBarButtonItem = UIBarButtonItem(title: "Help", image: nil, primaryAction: action, menu: nil)
        let rightBarButtonItem = UIBarButtonItem(title: "", image: image, primaryAction: settingAction, menu: nil)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        progressView.center = self.view.center
        progressView.color = UIColor.green
        self.view.addSubview(progressView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadBookMarks()
    }
    
    private func reloadBookMarks(){
        progressView.startAnimating()
        homeViewModel.reloadBookMarks {[weak self] (cities) in
            self?.cities = cities
            self?.tableView.isHidden = cities.count <= 0
            self?.tableView.reloadData()
            self?.progressView.stopAnimating()
        } errorHandler: {[weak self] (error) in
            self?.tableView.isHidden = true
            self?.progressView.stopAnimating()
            self?.showMessage(error: error.getMessage)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapViewController"
        {
            if let destinationVC = segue.destination as? MapViewController {
                destinationVC.mapDelegate = self
            }
        }
    }
    
    @objc func helpButtonTapped(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "HelpViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func settingsButtonTapped(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController:SettingsViewController = storyBoard.instantiateViewController(identifier: "SettingsViewController")
        viewController.completionHandler = {[weak self] in
            self?.reloadBookMarks()
        }
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func searchCityDetails(for city:String){
        self.progressView.startAnimating()
        homeViewModel.searchCityDetails(for: city) {[weak self] (city, fiveDayDetails) in
            self?.progressView.stopAnimating()
            self?.showCityDetails(city: city, cityFiveDayForecast: fiveDayDetails)
        } errorHandler: {[weak self] (error) in
            self?.progressView.stopAnimating()
            self?.showMessage(error: error.getMessage)
        }
    }
    
    private func showCityDetails(city:CityViewModel?,cityFiveDayForecast:[CityViewModel]?){
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController:CityViewController = storyBoard.instantiateViewController(identifier: "CityViewController")
            viewController.city = city
            viewController.cityFiveDayForecast = CityFiveDayForecastService().formatFiveDayForecastObjects(objects: cityFiveDayForecast!)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func showMessage(error:String){
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell:CityTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "CITY") as? CityTableViewCell
        tableViewCell?.cityViewModel = cities[indexPath.row]
        return tableViewCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchCityDetails(for: cities[indexPath.row].name)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let objToDel = cities.remove(at: indexPath.row)
            CityService().deleteObject(for: objToDel.name) {_ in 
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension HomeViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if let text = searchBar.text {
            self.searchCityDetails(for: text)
        }
    }
}

extension HomeViewController:MapDelegate{
    func locationSelected(for city: String) {
        self.searchCityDetails(for: city)
    }
}
