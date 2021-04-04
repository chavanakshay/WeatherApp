//
//  SettingsViewController.swift
//  Weather App
//
//  Created by Akshay  Chavan on 02/04/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var standard: UIButton!
    @IBOutlet weak var imperial: UIButton!
    @IBOutlet weak var metric: UIButton!
    var completionHandler:(()->Void)? = nil
    
    var selectedUOM = ""
    var uom:String{
        get{
            if selectedUOM != "" {
                return selectedUOM
            }
            guard let val = UserDefaults.standard.value(forKey: "UOM") as? String else {
                return "metric"
            }
            return val
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUOMSelection()
        // Do any additional setup after loading the view.
    }
    
    private func handleUOMSelection(){
        
        switch uom {
            case "metric":
                self.metric.backgroundColor = UIColor.gray
                self.standard.backgroundColor = UIColor.black
                self.imperial.backgroundColor = UIColor.black
            case "standard":
                self.standard.backgroundColor = UIColor.gray
                self.imperial.backgroundColor = UIColor.black
                self.metric.backgroundColor = UIColor.black
            case "imperial":
                self.imperial.backgroundColor = UIColor.gray
                self.metric.backgroundColor = UIColor.black
                self.standard.backgroundColor = UIColor.black
            default:
                print("")
        }
    }
    
    @IBAction func standardTapped(_ sender: Any) {
        selectedUOM = "standard"
        handleUOMSelection()
    }
    
    @IBAction func imperialTapped(_ sender: Any) {
        selectedUOM = "imperial"
        handleUOMSelection()
    }
    
    @IBAction func metricTapped(_ sender: Any) {
        selectedUOM = "metric"
        handleUOMSelection()
    }
    
    @IBAction func applySettingsTaped(_ sender: Any) {
        UserDefaults.standard.setValue(uom, forKey: "UOM")
        self.dismiss(animated: true) { [weak self] in
            self?.completionHandler?()
        }
    }
}
