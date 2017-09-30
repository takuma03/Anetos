//
//  ForgetPasswordViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/09/03.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var targetURL = "http://52.193.213.154:3000/users/password/new"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadAddressURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAddressURL() {
        
        let url: NSURL = NSURL(string: targetURL)!
        let urlRequest = NSURLRequest(url: url as URL)
        webView.loadRequest(urlRequest as URLRequest)
    }
 
}
