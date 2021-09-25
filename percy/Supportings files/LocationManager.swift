//
//  LocationManager.swift
//  percy
//
//  Created by Антон Усов on 25.09.2021.
//

import Foundation
import CoreLocation


struct Location {
    var title: String
    var coordinates: CLLocationCoordinate2D?
}

class LocationManager: NSObject {
    static var shared = LocationManager()
    
    public func fundLocations(with query: String, completion: @escaping (([Location]) -> Void)) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(query) { (places, error) in
            guard let places = places, error == nil else {
                completion([])
                return
            }
           
            let models: [Location] = places.compactMap { place in
                
                var name = ""
                if let locationName = place.name {
                    name += locationName
                }
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                }
                if let locality = place.locality {
                    name += ", \(locality)"
                }
                if let country = place.country {
                    name += ", \(country)"
                }
                print("\n\(place)\n\n")
                let result = Location(title: name, coordinates: place.location?.coordinate)
                return result
            }
            completion(models)
        }
    }
}
