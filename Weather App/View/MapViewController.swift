//
//  MapViewController.swift
//  Weather App
//
//  Created by Akshay  Chavan on 02/04/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var annotation:MKPointAnnotation?
    var mapDelegate:MapDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        
        if let coordinate2d = annotation?.coordinate {
            let geocoder = CLGeocoder()
            let coordinate = CLLocation(latitude: coordinate2d.latitude, longitude: coordinate2d.longitude)
            geocoder.reverseGeocodeLocation(coordinate) {[weak self] (placemarks, error) in
                if let places = placemarks {
                    for place in places {
                        if let city = place.locality{
                            self?.mapDelegate?.locationSelected(for: city)
                            self?.dismiss(animated: true, completion: nil)
                            break
                        }else{
                            self?.showMessage(message: "Can't fetch the location. Please select proper location.")
                        }
                    }
                }else{
                    self?.showMessage(message: "Cannot get the location. Please check your internet.")
                }
            }
        }else{
            showMessage(message: "Please select location on map.")
        }
        
    }
    
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        // Add annotation:
        if annotation != nil {
            mapView.removeAnnotation(annotation!)
        }
        annotation = MKPointAnnotation()
        annotation?.coordinate = coordinate
        if let mkAnnotation = annotation{
            mapView.addAnnotation(mkAnnotation)
        }
    }
    
    func showMessage(message:String)  {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
