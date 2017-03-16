//
//  AppDelegate.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/15.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //ユーザ名初期設定
    var user_name: String = ""
    
    //トークン初期設定
    var token: String = ""
    
    //レスポンスデータ初期設定
    var data: String = ""
    
    //タグ名初期設定
    var tag_name: String = ""
    
    //ユーザーの洋服ID格納用配列初期設定
    var cloth_array: Array<String> = []
    
    
    //初回ログイン時の処理
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //windowを生成
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //Storyboardを指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //Viewcontrollerを指定
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "Top")
        //rootViewControllerに入れる
        self.window?.rootViewController = initialViewController
        //表示
        print("Topを表示")
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    //バッググウンドからアプリが起動された際の処理
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        if(token==""){
            //windowを生成
            self.window = UIWindow(frame: UIScreen.main.bounds)
            //Storyboardを指定
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //Viewcontrollerを指定
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Top")
            //rootViewControllerに入れる
            self.window?.rootViewController = initialViewController
            //表示
            print("Topを表示")
            self.window?.makeKeyAndVisible()
        }else{
            print("トークンを表示")
            print(token)
            print(type(of: token))
            //TODO
            //トークンの期限が切れていないか確認
            //POSTするデータを設定する
            let postString = "user_name=\(user_name)&token=\(token)"
            print("POSTするデータを表示")
            print(postString)
            //URLを設定する
            var request = URLRequest(url: URL(string: "http://54.92.44.56:3000/api/v1/check/")!)
            //HTTPメソッドを設定する
            request.httpMethod = "POST"
            //HTTPBodyにデータを設定する
            request.httpBody = postString.data(using: .utf8)
            //タスクを作成する
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                print("response: \(response!)")
                let message: String = String(data: data!, encoding: .utf8)!
                print(message)
                self.data = message
                self.completionHandler()
            })
            //タスクを開始する
            task.resume()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //通信が完了した後に実行する関数
    func completionHandler(){
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        DispatchQueue.main.async {
            print("data: \(self.data)")
            //レスポンスデータにエラーが含まれている場合はTop画面へ遷移
            if (self.data.contains("エラー")) {
                print("ログインエラー")
                //windowを生成
                self.window = UIWindow(frame: UIScreen.main.bounds)
                //Storyboardを指定
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //Viewcontrollerを指定
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "Top")
                //rootViewControllerに入れる
                self.window?.rootViewController = initialViewController
                //表示
                print("Topを表示")
                self.window?.makeKeyAndVisible()
            //レスポンスデータにエラーが含まれていない場合はHome画面へ遷移
            }else{
                //windowを生成
                self.window = UIWindow(frame: UIScreen.main.bounds)
                //Storyboardを指定
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //Viewcontrollerを指定
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "Home")
                //rootViewControllerに入れる
                self.window?.rootViewController = initialViewController
                //表示
                print("Homeを表示")
                self.window?.makeKeyAndVisible()
            }
        }
    }
    


}

