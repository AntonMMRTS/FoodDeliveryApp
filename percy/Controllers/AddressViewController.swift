//
//  AddressViewController.swift
//  percy
//
//  Created by Антон Усов on 22.09.2021.
//

import UIKit
import MapKit

class AddressViewController: UIViewController {
    
    var previousLocation: CLLocation?
    
    private var addressLabel: UILabel = {
       let label = UILabel()
        
        label.textAlignment = .center
        label.text = "Krasnoyarsk"
        label.backgroundColor = .white
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "map")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(mapView)
        mapView.addSubview(imageView)
        view.addSubview(addressLabel)
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.clipsToBounds = true
        
        
        addressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addressLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
//        mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
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
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
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
            mapView.setRegion(region, animated: true)
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
            let subCity = placemark.subLocality
            let ourRegion = placemark.administrativeArea
            let subRegion = placemark.subAdministrativeArea
            
            DispatchQueue.main.async {
                
                if streetName != nil && buildNumber != nil {
                    print(city, subCity, ourRegion, subRegion)
                    self.addressLabel.text = "\(streetName!) \(buildNumber!)"
                } else if streetName != nil {
                    self.addressLabel.text = "\(streetName!)"
                } else {
                    self.addressLabel.text = ""
                }
            }
        }
    }
}