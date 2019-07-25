//
//  ProductListViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 6/27/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet var emptyListView: UIView!

    @IBOutlet weak var companyNameText: UILabel!
    @IBOutlet weak var companyImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var emptyView: UIView!
    
    let reuseIdentifier = "CustomViewCell"
    let dao = DAOCoreData.share as DAO
    var companyIndex = -1
    var company: CompanyMO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        company = dao.getCompanies()[companyIndex]
        
        companyImageView.load(urlString: company?.logourl)
        companyNameText.text = company?.name
        self.title = company?.name
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAdd )  )
        self.navigationItem.rightBarButtonItem = addButton
        
        let nib = UINib.init(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc func openAdd() {
        let productAddEditViewController = ProductAddEditViewController()
        productAddEditViewController.companyIndex = companyIndex
        self.navigationController?.pushViewController(productAddEditViewController, animated: true)
    }
    
    @IBAction func addClicked(_ sender: Any) {
        openAdd()
    }

}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = dao.getProducts(companyIndex: companyIndex).count
        if count > 0  {
            emptyView.removeFromSuperview()
        }
        else {
            emptyView.frame = tableView.frame
            self.view.addSubview(emptyView)
        }
        return count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CustomViewCell
        
        let product = dao.getProducts(companyIndex: companyIndex)[indexPath.row]
    
        cell.lblHeading.text = product.name
        cell.imgViewLogo.load(urlString: product.imageUrl)
        cell.lblDetail.text = product.productUrl
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = dao.getProducts(companyIndex: companyIndex)[indexPath.row]
        
        let productWebViewController = ProductWebViewController()
        productWebViewController.productUrlString = product.productUrl
        self.navigationController?.pushViewController(productWebViewController, animated: true)

    }
    
    
    
    
    
}


