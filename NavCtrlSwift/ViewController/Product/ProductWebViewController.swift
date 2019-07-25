//
//  ProductWebViewController.swift
//  NavCtrlSwift
//
//  Created by Aditya Narayan on 7/25/19.
//  Copyright © 2019 TurnToTech. All rights reserved.
//

import WebKit

class ProductWebViewController: UIViewController {
    
    var webView: WKWebView!
    var productUrlString: String!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
        let url = URL(string: productUrlString)!
        webView.load(URLRequest(url: url))
    }

    
}
