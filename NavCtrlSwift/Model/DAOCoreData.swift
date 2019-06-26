import UIKit
import CoreData


class DAOCoreData: NSObject, DAO {
    
    static let share = DAOCoreData()
    
    var selectedCompany : CompanyMO?
    var companies = [CompanyMO]()
    var managedContext : NSManagedObjectContext?
    
    private override init() {
        super.init()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate  {
            managedContext = appDelegate.persistentContainer.viewContext
            readCompanies()
        }
        
    }
    
    func getCompanies()->[CompanyMO] {
        return companies;
    }
    
      
    func readCompanies() {
        
        // Retrieve all data from Core Data
        guard let context = managedContext else {
            return
        }
        
         do {
            companies = try context.fetch( CompanyMO.fetchRequest() )
            for company in companies {
                if let name = company.name, let ticker = company.ticker {
                     print("\(name) is \(ticker) years old")
                }
               
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
        
        readCompanies()
        
    }
    
    func deleteCompany(index: Int) {
        guard let context = managedContext else {
            return
        }
        
        context.delete( companies[index] )
        
        readCompanies()
    }
    
    
}
