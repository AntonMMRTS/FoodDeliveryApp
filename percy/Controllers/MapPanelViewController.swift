//
//  MapPanelViewController.swift
//  percy
//
//  Created by Антон Усов on 25.09.2021.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ vc: MapPanelViewController,
                              didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}

class MapPanelViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate?
  
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Адрес"
        
        return label
    }()
    
     let addressButton: UIButton = {
        let button = UIButton()
//        field.placeholder = "Введите адрес"
//        button.setTitle("Введите адрес", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 9
        button.backgroundColor = .tertiarySystemBackground
//        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
//        field.leftViewMode = .always
        return button
    }()
    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(label)
        view.addSubview(addressButton)
       
//        view.addSubview(tableView)
//        tableView.backgroundColor = .secondarySystemBackground
//        tableView.delegate = self
//        tableView.dataSource = self
//        textField.delegate = self
        showSearch()
    }
    
    var locations = [Location]()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 10, width: label.frame.size.width, height: label.frame.size.height)
        addressButton.frame = CGRect(x: 10, y: 20 + label.frame.size.height,
                                 width: view.frame.size.width - 20, height: 50)
        let tableY = addressButton.frame.origin.y + addressButton.frame.size.height + 5
//        tableView.frame = CGRect(x: 0, y: tableY,
//                                 width: view.frame.size.width,
//                                 height: view.frame.size.height - tableY)
        
    }
    
    @objc func showSearchController() {
//        let vc = SearchAddressViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "search") as SearchAddressViewController
        present(vc, animated: true)
    }
    
    func showSearch() {
        addressButton.addTarget(self, action: #selector(showSearchController), for: .touchUpInside)
    }
    
    
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.textField.resignFirstResponder()
//        if let text = self.textField.text, !text.isEmpty {
//            LocationManager.shared.fundLocations(with: text) { [weak self] (locations) in
//                DispatchQueue.main.async {
//                    self?.locations = locations
//                    self?.tableView.reloadData()
//                }
//            }
//        }
//        return true
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return locations.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = locations[indexPath.row].title
//        cell.textLabel?.numberOfLines = 0
//        cell.contentView.backgroundColor = .secondarySystemBackground
//        cell.backgroundColor = .secondarySystemBackground
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let coordinates = locations[indexPath.row].coordinates
//
//        delegate?.searchViewController(self, didSelectLocationWith: coordinates)
//    }
    

}


