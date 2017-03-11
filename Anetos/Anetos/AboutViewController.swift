//
//  AboutViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/02.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UIWebViewDelegate {
    
   
    
    @IBOutlet weak var termsWebView: UIWebView!
    
    var targetURL = NSURL(string:"http://52.196.123.118:3000/terms")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.termsWebView.delegate = self
        
        let request = NSURLRequest(url: targetURL as! URL)
        self.termsWebView.loadRequest(request as URLRequest)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
