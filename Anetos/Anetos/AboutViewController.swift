//
//  AboutViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/03/02.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UIWebViewDelegate {
    
   
    // ActivityIndicator を用意
    var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var termsWebView: UIWebView!
    
    var targetURL = NSURL(string:"http://52.193.213.154:3000/terms")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.termsWebView.delegate = self
        
        let request = NSURLRequest(url: targetURL as! URL)
        self.termsWebView.loadRequest(request as URLRequest)
        
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        // ActivityIndicatorを作成＆中央に配置
        ActivityIndicator = UIActivityIndicatorView()
        ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        ActivityIndicator.center = self.view.center
        
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        
        // 色を設定
        ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        //Viewに追加
        self.view.addSubview(ActivityIndicator)
        // クルクルスタート
        ActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // クルクルストップ
        ActivityIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
