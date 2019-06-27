//
//  ViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 6/20/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

protocol DAO {
    
    // company methods
    func addCompany(name: String, ticker: String, imageUrl: String)
    func editCompany(index: Int, name: String, ticker: String, imageUrl: String)
    func deleteCompany(index: Int)
    func getCompanies()-> [CompanyMO]
    
}
