//
//  FirstViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/15.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource{
    
    var clothes:[Cloth] = [Cloth]()
    
    @IBOutlet weak var TopsCollectionView: UICollectionView!
    @IBOutlet weak var OthersCollectionView: UICollectionView!

    @IBOutlet weak var bottomsimage: UIImageView!
    
    @IBOutlet weak var home_region: UILabel!
    
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var tenki: UILabel!
    
    @IBOutlet weak var weather_img: UIImageView!
    
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //天気表示用のメソッド
    func weather(){
        let w = self.appDelegate.weather
        switch w {
        case "thunderstorm with light rain","thunderstorm with rain","thunderstorm with heavy rain","light thunderstorm","thunderstorm","heavy thunderstorm","ragged thunderstorm","thunderstorm with light drizzle","thunderstorm with drizzle","thunderstorm with heavy drizzle":
            self.tenki.text = "雷雨"
        case "light rain","moderate rain","heavy intensity rain","very heavy rain","extreme rain","freezing rain","heavy shower rain and drizzle":
            self.tenki.text = "雨"
        case "clear sky":
            self.tenki.text = "晴れ"
        default:
            print("それ以外")
        }
    }
    func setupClothes() {
        //配列で取得したcloth_id分処理を繰り返す
        for cloth_id in self.appDelegate.cloth_array{
            let f = Cloth(imageUrl: NSURL(string: "http://52.193.213.154:3000/clothes/get_image?id=" + cloth_id))
            clothes.append(f)
        }
    }
    
    //データの個数を返すメソッド
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return clothes.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == TopsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopsCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
//            セルの背景色をランダムに設定する。
                        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                                       green: CGFloat(drand48()),
                                                       blue: CGFloat(drand48()),
                                                       alpha: 1.0)
                        cell.setCell(cloth: clothes[indexPath.row])
            
                        return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OthersCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
            
            
                        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                                        green: CGFloat(drand48()),
                                                        blue: CGFloat(drand48()),
                                                        alpha: 1.0)
            
            
                        cell.setCell2(cloth: clothes[indexPath.row])
                        return cell
        }
    }
    
     //ボトムスを表示させるメソッド
    func setupBottoms(){
        let imgUrl = NSURL(string: "http://52.193.213.154:3000/clothes/get_image?id=40");
        // ファイルデータを作る
        let file = NSData(contentsOf: imgUrl! as URL);
        // イメージデータを作る
        let img = UIImage(data:file! as Data)
        
        // イメージビューに表示する
        bottomsimage.image = img
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        TopsCollectionView.delegate = self
//        OthersCollectionView.delegate = self
        
        TopsCollectionView.dataSource = self
        OthersCollectionView.dataSource = self

        //ユーザの地域名を取得
        home_region.text = appDelegate.region
        
        self.view.addSubview(TopsCollectionView)
        self.view.addSubview(OthersCollectionView)
        self.setupClothes()
        self.setupBottoms()
        self.weather()
        //気温のLabel表示
        self.temp.text = self.appDelegate.temperature + "℃"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
