//
//  SearchAddressViewController.swift
//  percy
//
//  Created by Антон Усов on 25.09.2021.
//
import UIKit
import MapKit


class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    var completion: ((CLLocationCoordinate2D) -> Void)?
    
    override func loadView() {
       self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        searching()
    }
    
    private func configure() {
        title = "Адрес доставки"
        view.backgroundColor = .black
        
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
        
        searchCompleter.delegate = self
        searchView.addressTextField.delegate = self
    }
    
    private func searching() {
        searchView.addressTextField.addTarget(self, action: #selector(addressTextfieldChange), for: .editingChanged)
    }
    
    @objc private func addressTextfieldChange() {
        guard let query = searchView.addressTextField.text, !query.isEmpty else {
            searchResults = []
            searchView.tableView.reloadData()
            return
        }
        searchCompleter.queryFragment = query
    }
    
    private func searchCoordinate(query: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: query)
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { [weak self] (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            
            guard coordinate != nil else { return }
            self?.completion?(coordinate!)

            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchView.tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = searchResult.title
        cell.textLabel?.textColor = .white
        cell.textLabel?.backgroundColor = .black
        
        cell.detailTextLabel?.backgroundColor = .black
        cell.detailTextLabel?.textColor = .systemGray4
        cell.detailTextLabel?.text = searchResult.subtitle
        
        cell.contentView.backgroundColor = .black
        cell.backgroundColor = .black
        
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = searchResults[indexPath.row]
        searchCoordinate(query: completion)
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let completion = searchResults.first else { return false }
        searchCoordinate(query: completion)
        return true
    }
    
}


