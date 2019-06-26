//
//  CompanyAddViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 6/24/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import UIKit

class CompanyAddViewController: UIViewController {

    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtTicker: UITextField!
    @IBOutlet weak var txtImageUrl: UITextField!
    
    override func viewDidLoad() {
        
        self.title = "Add Company"
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData ) )
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    @objc func saveData() {
        
        guard
        let company = txtCompanyName.text,
        let ticker = txtTicker.text,
        let imageUrl = txtImageUrl.text
        else {
            
            return
        }
        let dao = DAOCoreData.share as DAO
        dao.addCompany(name: company, ticker: ticker, imageUrl: imageUrl)
        self.navigationController?.popViewController(animated: true)
     }

}
