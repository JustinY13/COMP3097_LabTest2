
import UIKit
import CoreData

class AddProductViewController: UITableViewController {

    
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var providerField: UITextField!
    
    var products: [Product]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addProduct(_ sender: UIButton) {
        guard let productName = productNameField.text, !productName.isEmpty,
              let productDescription = descriptionField.text, !productDescription.isEmpty,
              let productPrice = priceField.text, let price = Double(productPrice),
              let productProvider = providerField.text, !productProvider.isEmpty else {
            showAlert(message: "Please fill out all fields")
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newProduct = Product(context: context)
        
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productPrice = price
        newProduct.productProvider = productProvider
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Saving Product Failed: \(error)")
            showAlert(message: "Saving Product Failed")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Success", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
