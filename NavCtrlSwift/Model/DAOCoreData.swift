import UIKit
import CoreData


class DAOCoreData: NSObject, DAO {
    
    static let share = DAOCoreData()
    
    var managedContext : NSManagedObjectContext?
    
    private override init() {
        super.init()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate  {
            managedContext = appDelegate.persistentContainer.viewContext
         }
        
    }
    
    func getCompanies()->[CompanyMO] {
        
        // Retrieve all data from Core Data
        guard let context = managedContext else {
            return [CompanyMO]()
        }
        
        do {
            return  try context.fetch( CompanyMO.fetchRequest() )
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return [CompanyMO]()
        }
        
    }
    
  
    
    
    func addCompany(name: String, ticker: String, imageUrl: String) {
        
        // Retrieve all data from Core Data
        guard let context = managedContext else {
            return
        }

        
        
        let newCompany = CompanyMO(context: context)
        
        newCompany.name = name
        newCompany.ticker = ticker
        newCompany.logourl = imageUrl
        
    }
    
    func deleteCompany(company: CompanyMO) {
        guard let context = managedContext else {
            return
        }
        
        context.delete( company )
        
    }
    
    
    func editCompany(company: CompanyMO, name: String, ticker: String, imageUrl: String) {
        
    }
    
    func addProduct(name: String, imageUrl: String, productUrl: String) {
        
    }
    
    func editProduct(companyIndex: Int, productIndex: Int, name: String, imageUrl: String, productUrl: String) {
        
    }
    
    func deleteProduct(companyIndex: Int, productIndex: Int) {
        
    }
    
    func getProducts(companyIndex: Int)-> [ProductMO] {
        
        // Retrieve all data from Core Data
        guard let context = managedContext else {
            return [ProductMO]();
        }
        
        do {
            return try context.fetch( ProductMO.fetchRequest() )
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return [ProductMO]();
        }
    }
    
    
}
