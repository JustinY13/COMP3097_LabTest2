// Justin Yeh
// 101400171

import UIKit
import CoreData

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productProvider: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var products: [Product] = []
    var productsBySearch: [Product] = []
    var mainIndex = 0
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        getProducts()
        showProduct()
    }
    
    func getProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let getRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            products = try context.fetch(getRequest)
            productsBySearch = products
        } catch {
            print("Fetching products failed: \(error)")
        }
    }
    
    func showProduct() {
        guard products.count > 0 else {
            productName.text = "Failed to Fetch Product"
            productDescription.text = ""
            productPrice.text = ""
            productProvider.text = ""
            previousButton.isEnabled = false
            nextButton.isEnabled = false
            return
        }
        let product = products[mainIndex]
        productName.text = product.productName
        productDescription.text = product.productDescription
        productPrice.text = String(product.productPrice)
        productProvider.text = product.productProvider
        
        previousButton.isEnabled = mainIndex > 0
        nextButton.isEnabled = mainIndex < products.count - 1
    }
    
    @IBAction func nextProduct(_ sender: UIButton) {
        if mainIndex < products.count - 1 {
            mainIndex = mainIndex + 1
            showProduct()
        }
    }
    
    @IBAction func previousProduct(_ sender: UIButton) {
        if mainIndex > 0 {
            mainIndex = mainIndex - 1
            showProduct()
        }
    }
    
}

