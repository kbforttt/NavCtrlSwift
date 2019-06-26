//
//  ViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 6/20/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import UIKit

class CompanyListViewController: UIViewController {
    
    let reuseIdentifier = "CustomViewCell"

    @IBOutlet weak var tableView: UITableView!
    let dao = DAOCoreData.share as DAO
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Watch List"
        
        self.navigationItem.leftBarButtonItem = editButtonItem
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
        let companyAddViewController = CompanyAddViewController()
        self.navigationController?.pushViewController(companyAddViewController, animated: true)
    }
    
   
    
}



extension CompanyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.getCompanies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CustomViewCell
     
        let company = dao.getCompanies()[indexPath.row]
        
        cell.lblHeading.text = company.name
        cell.lblDetail.text = company.ticker
        cell.imgViewLogo.load(urlString: company.logourl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
     
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dao.deleteCompany(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("aaaa")
    }
    
    
}

