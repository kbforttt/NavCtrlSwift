//
//  CompanyAddViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 6/24/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import UIKit

class CompanyAddEditViewController: UIViewController {

    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtTicker: UITextField!
    @IBOutlet weak var txtImageUrl: UITextField!
    
    var companyIndex = -1
    let dao = DAOCoreData.share as DAO
    
    override func viewDidLoad() {
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData ) )
        self.navigationItem.rightBarButtonItem = saveButton
        
        if(companyIndex<0){
            title = "Add Company"
        } else {
            title = "Edit Company"
            let company = dao.getCompanies()[companyIndex]
            
            txtCompanyName.text = company.name
            txtTicker.text = company.ticker
            txtImageUrl.text = company.logourl
        }
        
    }
    
    @objc func saveData() {
        
        guard
        let name = txtCompanyName.text,
        let ticker = txtTicker.text,
        let imageUrl = txtImageUrl.text
        else {
            
            return
        }
        let dao = DAOCoreData.share as DAO
        if(companyIndex<0){
            dao.addCompany(name: name, ticker: ticker, imageUrl: imageUrl)
         } else {
            dao.editCompany(index: companyIndex, name: name, ticker: ticker, imageUrl: imageUrl)
        }
        
        self.navigationController?.popViewController(animated: true)
     }

}
