//
//  ViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 6/20/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import UIKit

class CompanyListViewController: UIViewController {
    
    
    @IBOutlet var emptyListView: UIView!
    
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
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshControl) , for: .valueChanged)
        
      }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        loadStocks(loadAll:false)
        
    }


    @objc func openAdd() {
        let companyAddEditViewController = CompanyAddEditViewController()
        self.navigationController?.pushViewController(companyAddEditViewController, animated: true)
    }
    
    @objc func refreshControl() {
        loadStocks(loadAll: true)
        tableView.refreshControl?.endRefreshing()
    }
    
   
    @IBAction func addClicked(_ sender: Any) {
        openAdd()
    }
    
    func loadStocks(loadAll: Bool) {
        
        var tickers = [String]()
        
        // request stocks only for which price was not updated
        for company in dao.getCompanies() {
            if loadAll || company.price == 0  {
                if let ticker = company.ticker {
                    tickers.append(ticker)
                }
            }
        }
        
        
        StockService.getStockPrices(tickers: tickers) {ticker,price in
            
            for (index, company) in self.dao.getCompanies().enumerated() {
                if company.ticker == ticker {
                    company.price = price
                    DispatchQueue.main.async {
                        
                       self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.fade)
                    }
                }
            }
        }
        
    }
   
    
    
}



extension CompanyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dao.getCompanies().count==0 {
            self.view.addSubview(emptyListView)
        }
        else {
           emptyListView.removeFromSuperview()
          }
        
        return dao.getCompanies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CustomViewCell
     
        let company = dao.getCompanies()[indexPath.row]
        
        cell.lblHeading.text = "\(company.name ?? "") (\(company.ticker ?? ""))"
        cell.lblDetail.text = "$\(company.price)"
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
        if(isEditing){
            let companyAddEditViewController = CompanyAddEditViewController()
            companyAddEditViewController.companyIndex = indexPath.row
            self.navigationController?.pushViewController(companyAddEditViewController, animated: true)
        }
    }
    
    
    
    
}

