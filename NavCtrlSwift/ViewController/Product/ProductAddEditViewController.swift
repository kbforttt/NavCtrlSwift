//
//  ProductAddEditViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 7/24/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import UIKit

class ProductAddEditViewController: UIViewController {
    
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtImageUrl: UITextField!
    @IBOutlet weak var txtProductUrl: UITextField!

    var companyIndex = -1
    var productIndex = -1
    
    let dao = DAOCoreData.share as DAO
    
    override func viewDidLoad() {
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData ) )
        self.navigationItem.rightBarButtonItem = saveButton
        
        if(productIndex<0){
            title = "Add Product"
        } else {
            title = "Edit Product"
            let product = dao.getProducts(companyIndex: companyIndex)[productIndex]
            
            txtProductName.text = product.name
            txtImageUrl.text = product.imageUrl
            txtProductUrl.text = product.productUrl
        }
        
    }
    
    @objc func saveData() {
        
        guard
            let name = txtProductName.text, name.count > 0,
            let imageUrl = txtImageUrl.text, imageUrl.count > 0,
            let productUrl = txtProductUrl.text, productUrl.count > 0
            else {
                let alert = UIAlertController(title: "Alert", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        let dao = DAOCoreData.share as DAO
        if(productIndex<0){
            dao.addProduct(companyIndex: companyIndex, name: name, imageUrl: imageUrl, productUrl: productUrl)
        } else {
            dao.editProduct(companyIndex: companyIndex, index: productIndex, name: name, imageUrl: imageUrl, productUrl: productUrl)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
