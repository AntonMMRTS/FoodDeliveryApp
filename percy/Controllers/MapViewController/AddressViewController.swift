//
//  AddressViewController.swift
//  percy
//
//  Created by Антон Усов on 22.09.2021.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation
//import YandexMapsMobile

class AddressViewController: UIViewController, FloatingPanelControllerDelegate {
    
    var previousLocation: CLLocation?
    
    var panel: FloatingPanelController!
    
    let addressView = AddressView()
    
    let locationManager = CLLocationManager()
    let searchVC = MapPanelViewController()
    
    override func loadView() {
       self.view = addressView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        title = "Адрес доставки"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        locationManager.delegate = self
        addressView.myMapView.delegate = self
        
        addressView.myMapView.isRotateEnabled = false

        searchVC.completion = {
            self.showSearchMenu()
        }
       
        panel = FloatingPanelController()
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
        panel.layout = MyFloatingPanelLayout()
        panel.move(to: .tip, animated: false)
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    func showSearchMenu() {
        let vc = SearchViewController()
        vc.completion = { [weak self] coordinates in
            
            self?.addressView.myMapView.removeAnnotations(self?.addressView.myMapView.annotations ?? [])
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            self?.addressView.myMapView.addAnnotation(pin)
            
            self?.addressView.myMapView.setRegion(MKCoordinateRegion(center: coordinates,
                                                 span: MKCoordinateSpan(latitudeDelta: 0.025,
                                                                        longitudeDelta: 0.025)),
                              animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkAuthorization()
        } else {
            showAlertLocation(title: "У вас выключена служба геолокации", message: "Включить геолокацию?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
    }
    
    func showAlertLocation(title: String, message: String, url: URL?) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let settings = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(settings)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization() {
        switch locationManager.authorizationStatus {
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            showAlertLocation(title: "Пользователь запретил использование геолокации",
                              message: "Разрешить использование геолокации?",
                              url: URL(string: UIApplication.openSettingsURLString))
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        @unknown default:
            break
        }
    }
    
    func startTrackingUserLocation() {
        addressView.myMapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: addressView.myMapView)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
   

}

extension AddressViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: 3000,
                                            longitudinalMeters: 3000)
            addressView.myMapView.setRegion(region, animated: true)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
}

extension AddressViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        
        guard previousLocation != nil else { return }
        guard center.distance(from: previousLocation!) > 50 else { return }
        previousLocation = center
        
        geocoder.reverseGeocodeLocation(center) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            guard let placemark = placemarks?.first else {return}
            
            let streetName = placemark.thoroughfare
            let buildNumber = placemark.subThoroughfare
            let city = placemark.locality
            
            DispatchQueue.main.async {
                if streetName != nil && buildNumber != nil {
                    self.searchVC.addressButton.setTitle("\(streetName!) \(buildNumber!) \(city!)", for: .normal)
                }
            }
        }
    }
}


