import UIKit
import FirebaseAuth

class BasketViewController: UIViewController {
    
    private var basketView = BasketView()
    
    private var databaseManager: DatabaseManagerProtocol = RealmManager()
    
    private var badgeValueForBasket = 0 {
        didSet {
            badgeValueForBasket = databaseManager.obtainProducts().count
            if badgeValueForBasket == 0 {
                tabBarController?.tabBar.items?.last?.badgeValue = nil
            } else {
            tabBarController?.tabBar.items?.last?.badgeValue = "\(badgeValueForBasket)"
            }
        }
    }
    
    private var total = 0 {
        didSet {
            basketView.sumLabel.text = "\(total)" + " ₽"
        }
    }
    
    override func loadView() {
       self.view = basketView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketView.tableView.dataSource = self
        basketView.tableView.delegate = self
        
        basketView.setupView()
        
        navigationControllerSetup()
        
        goAuth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        basketView.products = databaseManager.obtainProducts()
        totalMoney()
        basketView.tableView.reloadData()
    }
    
    private func navigationControllerSetup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationController?.navigationBar.barStyle = .black
    }
    
    private func totalMoney()  {
        total = 0
        for i in  basketView.products {
            total += i.price * i.quantity
        }
    }
    
    private func goAuth() {
        basketView.orderButton.addTarget(self, action: #selector(authtorization), for: .touchUpInside)
    }
    
    @objc private func authtorization() {
//        do {
//            try Auth.auth().signOut()
//        } catch {
//        }
        if Auth.auth().currentUser?.uid == nil {
            let vc = AuthViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketView.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier,
                                                 for: indexPath) as! BasketCell
        
        let product = basketView.products[indexPath.row]
        cell.product = product
        
        cell.closure = { [weak self] in
            self?.totalMoney()
            self?.basketView.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete && indexPath.row < basketView.products.count {
            let product = basketView.products[indexPath.row]
            databaseManager.deleteProduct(product: product)

            basketView.products.remove(at: indexPath.row)
            basketView.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            totalMoney()
            
            tabBarController?.tabBar.items?.last?.badgeValue = "\(basketView.products.count)"
            if basketView.products.count == 0 {
                tabBarController?.tabBar.items?.last?.badgeValue = nil
            }
        }
    }
 
}

