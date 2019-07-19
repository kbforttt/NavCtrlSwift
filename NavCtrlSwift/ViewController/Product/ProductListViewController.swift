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

    @objc func openAdd() {
    }

}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if let count = company?.products?.count, count > 0  {
            emptyView.removeFromSuperview()
            return count
        }
        else {
            emptyView.frame = tableView.frame
            self.view.addSubview(emptyView)
            return 0
        }
        
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CustomViewCell
        
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
    
    
}


