//
//  RegisterClothViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/04/24.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit
import GoogleMobileAds

class RegisterClothViewController: UIViewController, GADInterstitialDelegate   {
    
    // Simulator ID
    let SIMULSTOR_ID = kGADSimulatorID
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBAction func unwindToRegisterCloth(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        bannerView.adUnitID = "ca-app-pub-3212052928179442/5622608724"
        bannerView.rootViewController = self

        //テスト広告表示用
        let request:GADRequest = GADRequest()
        if TARGET_OS_SIMULATOR == 1 {
            request.testDevices = [kGADSimulatorID] //iOSシミュレータ用
        } else {
            request.testDevices = ["a2ee1fac3f6650ef1203513e62848f7a"] //実機用
        }
        //広告を読み込んで表示
        
        bannerView.load(request)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
