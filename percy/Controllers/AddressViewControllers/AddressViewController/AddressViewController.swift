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

class AddressViewController: UIViewController, FloatingPanelControllerDelegate {
  
    var completion: ((String) -> Void)?
    
    var activeTextField: UITextField!
    
    private let mapManager = MapManager()
    
    private var panel: FloatingPanelController!
    
    private let addressView = AddressView()
    
    private let panelVC = MapPanelViewController()
    
    override func loadView() {
        self.view = addressView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panelVC.completionAddress = { [weak self] address in
            self?.completion?(address)
        }
        
        panelVC.completion = {
            self.showSearchMenu()
        }
        
        panelVC.completionTextfield = { textfield in
            self.activeTextField = textfield
        }
        
        initializeHideKeyboard()
        configure()
        floatingPanelSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardSubscription()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapManager.checkLocationEnabled(mapView: addressView.myMapView, vc: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancelKeyboardSubscription()
    }
    
    private func configure() {
        view.backgroundColor = .black
        title = "Адрес доставки"
        
        mapManager.locationManager.delegate = self
        addressView.myMapView.delegate = self
        addressView.myMapView.isRotateEnabled = false
    }
    
    private func floatingPanelSetup() {
        panel = FloatingPanelController()
        panel.set(contentViewController: panelVC)
        panel.addPanel(toParent: self)
        panel.layout = MyFloatingPanelLayout()
        panel.move(to: .tip, animated: false)
    }
    
    private func showSearchMenu() {
        let vc = SearchViewController()
        vc.completion = { [weak self] coordinates in
            
            self?.addressView.myMapView.removeAnnotations(self?.addressView.myMapView.annotations ?? [])
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            self?.addressView.myMapView.addAnnotation(pin)
            
            self?.addressView.myMapView.setRegion(MKCoordinateRegion(
                                                    center: coordinates,
                                                    span: MKCoordinateSpan(latitudeDelta: 0.025,
                                                                           longitudeDelta: 0.025)),
                                                  animated: true)
            self?.panel.move(to: .full, animated: false)
        }
        navigationController?.pushViewController(vc, animated: true)
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
        mapManager.checkAuthorization(mapView: addressView.myMapView, vc: self)
    }
    
}

extension AddressViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapManager.getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        
        guard mapManager.previousLocation != nil else { return }
        
        guard center.distance(from: mapManager.previousLocation!) > 50 else { return }
        mapManager.previousLocation = center
        
        geocoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
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
                    self?.panelVC.mapPanelView.addressButton.setTitle("\(city!), \(streetName!), \(buildNumber!)",
                                                                      for: .normal)
                }
            }
        }
    }
}

extension AddressViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
}

extension AddressViewController {
    
    private func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
}
