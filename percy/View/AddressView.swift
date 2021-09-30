//
//  AddressView.swift
//  percy
//
//  Created by Антон Усов on 30.09.2021.
//

import UIKit
import MapKit

class AddressView: UIView {
    
    let myMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "marker")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(myMapView)
        myMapView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            myMapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myMapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            myMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            myMapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: myMapView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: myMapView.centerYAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        imageView.clipsToBounds = true
    }
}
