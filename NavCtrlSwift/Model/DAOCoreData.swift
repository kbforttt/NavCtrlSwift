//
//  ViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 6/20/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import UIKit
import CoreData


class DAOCoreData: NSObject, DAO {
    
    
    static let share = DAOCoreData()
    
    var companies = [CompanyMO]()
  
    var managedContext : NSManagedObjectContext?
    
    private override init() {
        super.init()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate  {
            managedContext = appDelegate.persistentContainer.viewContext
            readCompanies()
        }
        
    }
    
    // MARK: - Company Methods
    
    func getCompanies()->[CompanyMO] {
        return companies;
    }
    
    
    func readCompanies() {
        
        // Retrieve all data from Core Data
        guard let context = managedContext else {
            return
        }
        
        do {
            let fetchRequest : NSFetchRequest<CompanyMO> = CompanyMO.fetchRequest()
            fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
            companies = try context.fetch( fetchRequest )
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func addCompany(name: String, ticker: String, imageUrl: String) {
        
        guard let context = managedContext else {
            return
        }
        
        let newCompany = CompanyMO(context: context)
        
        newCompany.name = name
        newCompany.ticker = ticker
        newCompany.logourl = imageUrl
        newCompany.order = Int16( companies.count )
        
        readCompanies()
        
    }
    
    func editCompany(index: Int, name: String, ticker: String, imageUrl: String) {
        
        let company = companies[index]
        company.name = name
        company.ticker = ticker
        company.logourl = imageUrl
        company.price = 0
        readCompanies()
    }
    
    func deleteCompany(index: Int) {
        guard let context = managedContext else {
            return
        }
        
        context.delete( companies[index] )
        
        readCompanies()
    }
    
    
    // MARK: - Product Methods
    
    func addProduct(companyIndex: Int, name: String, ticker: String, imageUrl: String) {
        
    }
    
    func editProduct(companyIndex: Int, index: Int, name: String, ticker: String, imageUrl: String) {
        
    }
    
    func deleteProduct(companyIndex: Int, index: Int) {
        
    }
    
    func getProducts(companyIndex: Int) -> [ProductMO] {
        return (companies[companyIndex].products as! Set<ProductMO>).sorted(by:  { $0.order < $1.order })
    }

    
    
}
