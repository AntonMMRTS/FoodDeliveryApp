//
//  AddressViewController.swift
//  percy
//
//  Created by Антон Усов on 22.09.2021.
//
import UIKit
import YandexMapsMobile


class AddressViewController: UIViewController, UISearchResultsUpdating, YMKUserLocationObjectListener {
    

    var suggestResults: [YMKSuggestItem] = []
    let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    var suggestSession: YMKSearchSuggestSession!

    let BOUNDING_BOX = YMKBoundingBox(
        southWest: YMKPoint(latitude: 55.55, longitude: 37.42),
        northEast: YMKPoint(latitude: 55.95, longitude: 37.82))
    let SUGGEST_OPTIONS = YMKSuggestOptions()

    let mapView = YMKMapView()

    let searchVC = UISearchController(searchResultsController: SuggestViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Адрес доставки"
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(mapView)
  
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        
        suggestSession = searchManager.createSuggestSession()

        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.move(with:
            YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 14, azimuth: 0, tilt: 0))
    }

    func onObjectAdded(with view: YMKUserLocationView) {
//        view.arrow.setIconWith(UIImage())
//
//        let pinPlacemark = view.pin.useCompositeIcon()
//
//        pinPlacemark.setIconWithName("icon",
//            image: UIImage(),
//            style:YMKIconStyle(
//                anchor: CGPoint(x: 0, y: 0) as NSValue,
//                rotationType:YMKRotationType.rotate.rawValue as NSNumber,
//                zIndex: 0,
//                flat: true,
//                visible: true,
//                scale: 1.5,
//                tappableArea: nil))
//
//        pinPlacemark.setIconWithName(
//            "pin",
//            image: UIImage(),
//            style:YMKIconStyle(
//                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
//                rotationType:YMKRotationType.rotate.rawValue as NSNumber,
//                zIndex: 1,
//                flat: true,
//                visible: true,
//                scale: 1,
//                tappableArea: nil))
//
//        view.accuracyCircle.fillColor = UIColor.blue
    }

    func onObjectRemoved(with view: YMKUserLocationView) {}

    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
                               width: view.frame.size.width,
                               height: view.frame.size.height - view.safeAreaInsets.top)
        
        let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)

        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        userLocationLayer.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        userLocationLayer.setObjectListenerWith(self)
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
        let resultVC = searchController.searchResultsController as? SuggestViewController
              else {
            print("hello")
            return }

        let suggestHandler = {(response: [YMKSuggestItem]?, error: Error?) -> Void in
            if let items = response {
                self.onSuggestResponse(items)
            } else {
                self.onSuggestError(error!)
            }
        }

        suggestSession.suggest(
            withText: query,
            window: BOUNDING_BOX,
            suggestOptions: SUGGEST_OPTIONS,
            responseHandler: suggestHandler)

        print(suggestResults.first?.displayText)
        DispatchQueue.main.async {
            resultVC.update(places: self.suggestResults)
        }
    }


    func onSuggestResponse(_ items: [YMKSuggestItem]) {
        suggestResults = items
    }

    func onSuggestError(_ error: Error) {
        let suggestError = (error as NSError).userInfo[YRTUnderlyingErrorKey] as! YRTError
        var errorMessage = "Unknown error"
        if suggestError.isKind(of: YRTNetworkError.self) {
            errorMessage = "Network error"
        } else if suggestError.isKind(of: YRTRemoteError.self) {
            errorMessage = "Remote server error"
        }

        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }

}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    @IBAction func queryChanged(_ sender: UITextField) {
//        let suggestHandler = {(response: [YMKSuggestItem]?, error: Error?) -> Void in
//            if let items = response {
//                self.onSuggestResponse(items)
//            } else {
//                self.onSuggestError(error!)
//            }
//        }
//
//        suggestSession.suggest(
//            withText: sender.text!,
//            window: BOUNDING_BOX,
//            suggestOptions: SUGGEST_OPTIONS,
//            responseHandler: suggestHandler)
//    }


//}


//class AddressViewController: UIViewController {
//
//    var previousLocation: CLLocation?
//
//    private var addressLabel: UILabel = {
//       let label = UILabel()
//
//        label.textAlignment = .center
//        label.text = "Krasnoyarsk"
//        label.backgroundColor = .white
//        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let mapView: MKMapView = {
//        let mapView = MKMapView()
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        return mapView
//    }()
//
//    private let imageView: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "map")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
//
//    let locationManager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = false
//        view.addSubview(mapView)
//        mapView.addSubview(imageView)
//        view.addSubview(addressLabel)
//        locationManager.delegate = self
//        mapView.delegate = self
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
//        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//
//        imageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -20).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        imageView.clipsToBounds = true
//
//
//        addressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//        addressLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
//        addressLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        addressLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
//
////        mapView.showsUserLocation = true
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        checkLocationEnabled()
//    }
//
//    func checkLocationEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//            setupManager()
//            checkAuthorization()
//        } else {
//            showAlertLocation(title: "У вас выключена служба геолокации", message: "Включить геолокацию?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
//        }
//    }
//
//    func showAlertLocation(title: String, message: String, url: URL?) {
//
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//        let settings = UIAlertAction(title: "Настройки", style: .default) { (alert) in
//            if let url = url {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
//        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//
//        alert.addAction(settings)
//        alert.addAction(cancelAction)
//
//        present(alert, animated: true)
//    }
//
//    func setupManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//    func checkAuthorization() {
//        switch locationManager.authorizationStatus {
//
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            break
//        case .denied:
//            showAlertLocation(title: "Пользователь запретил использование геолокации",
//                              message: "Разрешить использование геолокации?",
//                              url: URL(string: UIApplication.openSettingsURLString))
//        case .authorizedAlways:
//            break
//        case .authorizedWhenInUse:
//            startTrackingUserLocation()
//        @unknown default:
//            break
//        }
//    }
//
//    func startTrackingUserLocation() {
//        mapView.showsUserLocation = true
//        locationManager.startUpdatingLocation()
//        previousLocation = getCenterLocation(for: mapView)
//    }
//
//    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
//
//        let latitude = mapView.centerCoordinate.latitude
//        let longitude = mapView.centerCoordinate.longitude
//
//        return CLLocation(latitude: latitude, longitude: longitude)
//    }
//
//
//}
//
//extension AddressViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last?.coordinate {
//            let region = MKCoordinateRegion(center: location,
//                                            latitudinalMeters: 3000,
//                                            longitudinalMeters: 3000)
//            mapView.setRegion(region, animated: true)
//        }
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkAuthorization()
//    }
//
//}
//
//extension AddressViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let center = getCenterLocation(for: mapView)
//        let geocoder = CLGeocoder()
//
//        guard previousLocation != nil else { return }
//        guard center.distance(from: previousLocation!) > 50 else { return }
//        previousLocation = center
//
//        geocoder.reverseGeocodeLocation(center) { (placemarks, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            guard let placemark = placemarks?.first else {return}
//
//            let streetName = placemark.thoroughfare
//            let buildNumber = placemark.subThoroughfare
//            let city = placemark.locality
//            let subCity = placemark.subLocality
//            let ourRegion = placemark.administrativeArea
//            let subRegion = placemark.subAdministrativeArea
//
//            DispatchQueue.main.async {
//
//                if streetName != nil && buildNumber != nil {
//                    print(city, subCity, ourRegion, subRegion)
//                    self.addressLabel.text = "\(streetName!) \(buildNumber!)"
//                } else if streetName != nil {
//                    self.addressLabel.text = "\(streetName!)"
//                } else {
//                    self.addressLabel.text = ""
//                }
//            }
//        }
//    }
//}
