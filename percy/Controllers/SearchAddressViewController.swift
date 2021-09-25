//
//  SearchAddressViewController.swift
//  percy
//
//  Created by Антон Усов on 25.09.2021.
//

import UIKit
import YandexMapsMobile

class SearchAddressViewController: UIViewController, UITableViewDataSource {
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UITextField!
    
    let addressTetxField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите адрес"
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Helvetica Neue", size: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return tableView
    }()
    
    var suggestResults: [YMKSuggestItem] = []
    let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    var suggestSession: YMKSearchSuggestSession!

    let BOUNDING_BOX = YMKBoundingBox(
        southWest: YMKPoint(latitude: 55.55, longitude: 37.42),
        northEast: YMKPoint(latitude: 55.95, longitude: 37.82))
    let SUGGEST_OPTIONS = YMKSuggestOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(addressTetxField)
//        tableView.frame = view.bounds
        suggestSession = searchManager.createSuggestSession()
        tableView.dataSource = self
        searchSuggest(addressTetxField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addressTetxField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        addressTetxField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        addressTetxField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        addressTetxField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: addressTetxField.bottomAnchor, constant: 5).isActive = true
    }
    
    func update(places:[YMKSuggestItem]) {
        self.suggestResults = places
        print(places)
        tableView.reloadData()
    }
    
    func onSuggestResponse(_ items: [YMKSuggestItem]) {
        suggestResults = items
        tableView.reloadData()
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

   func searchSuggest(_ sender: UITextField) {
        let suggestHandler = {(response: [YMKSuggestItem]?, error: Error?) -> Void in
            if let items = response {
                self.onSuggestResponse(items)
            } else {
                self.onSuggestError(error!)
            }
        }

        suggestSession.suggest(
            withText: sender.text!,
            window: BOUNDING_BOX,
            suggestOptions: SUGGEST_OPTIONS,
            responseHandler: suggestHandler)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt path: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: path) as! SearchCell
//        cell.suggestLabel.text = suggestResults[path.row].displayText
        cell.backgroundColor = .orange
        cell.textLabel!.text = suggestResults[path.row].displayText
        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestResults.count
    }
}
