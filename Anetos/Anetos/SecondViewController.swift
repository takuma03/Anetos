//
//  SecondViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/15.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    //var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    //TODO
    //ユーザ毎に一覧を表示させる必要がある
    let targetURL = "http://52.196.123.118:3000/clothes/index/takuma"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if let url = NSURL(string: targetURL){
            let urlRequest = NSURLRequest(url: url as URL)
            self.webView.loadRequest(urlRequest as URLRequest)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    
    }
}

