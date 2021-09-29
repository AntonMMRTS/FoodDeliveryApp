//
//  LocationManager.swift
//  percy
//
//  Created by Антон Усов on 28.09.2021.
//

import UIKit
import MapKit


class MapManager {
    
    let locationManager = CLLocationManager()
    
    var previousLocation: CLLocation?
    
    private func showAlertLocation(title: String, message: String, url: URL?, vc: UIViewController) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let settings = UIAlertAction(title: "Настройки", style: .default) { alert in
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(settings)
        alert.addAction(cancelAction)
        
        vc.present(alert, animated: true)
    }
    
    private func startTrackingUserLocation(mapView: MKMapView) {
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func checkLocationEnabled(mapView: MKMapView, vc: UIViewController) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkAuthorization(mapView: mapView, vc: vc)
        } else {
            showAlertLocation(title: "У вас выключена служба геолокации",
                              message: "Включить геолокацию?",
                              url: URL(string: "App-Prefs:root=LOCATION_SERVICES"),
                              vc: vc)
        }
    }
    
    func checkAuthorization(mapView: MKMapView, vc: UIViewController) {
        switch locationManager.authorizationStatus {
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            showAlertLocation(title: "Пользователь запретил использование геолокации",
                              message: "Разрешить использование геолокации?",
                              url: URL(string: UIApplication.openSettingsURLString),
                              vc: vc)
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            startTrackingUserLocation(mapView: mapView)
        @unknown default:
            break
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
}
