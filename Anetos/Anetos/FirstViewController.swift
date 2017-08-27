//
//  FirstViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/15.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var tops_clothes:[Cloth] = [Cloth]()
    var others_clothes:[Cloth] = [Cloth]()
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
            weather_img.image = UIImage(named:"1.png")
        case "light intensity drizzle":
            self.tenki.text = "薄い霧"
            weather_img.image = UIImage(named:"2.png")
        case "drizzle","heavy intensity drizzle","light intensity drizzle rain","drizzle rain","heavy intensity drizzle rain","shower drizzle":
            self.tenki.text = "霧雨"
            weather_img.image = UIImage(named:"2.png")
        case "heavy intensity drizzle":
            self.tenki.text = "濃い霧"
            weather_img.image = UIImage(named:"2.png")
        case "light rain","moderate rain","heavy intensity rain","very heavy rain","extreme rain","freezing rain":
            self.tenki.text = "雨"
            weather_img.image = UIImage(named:"3.png")
        case "shower rain and drizzle","heavy shower rain and drizzle","light intensity shower rain","shower rain","heavy intensity shower rain","ragged shower rain","squalls":
            self.tenki.text = "にわか雨"
            weather_img.image = UIImage(named:"3.png")
        case "light snow","snow","heavy snow","light shower snow","shower snow","heavy shower snow":
            self.tenki.text = "雪"
            weather_img.image = UIImage(named:"4.png")
        case "sleet","shower sleet","light rain and snow","rain and snow":
            self.tenki.text = "みぞれ"
            weather_img.image = UIImage(named:"5.png")
        case "mist","smoke","haze","fog":
            self.tenki.text = "霧"
            weather_img.image = UIImage(named:"6.png")
        case "sand, dust whirls","sand":
            self.tenki.text = "砂塵"
            weather_img.image = UIImage(named:"6.png")
        case "dust":
            self.tenki.text = "ほこり"
            weather_img.image = UIImage(named:"6.png")
        case "volcanic ash":
            self.tenki.text = "火山灰"
            weather_img.image = UIImage(named:"6.png")
        case "tornado":
            self.tenki.text = "竜巻"
            weather_img.image = UIImage(named:"6.png")
        case "clear sky","few clouds":
            self.tenki.text = "晴れ"
            weather_img.image = UIImage(named:"7.png")
        case "scattered clouds","broken clouds":
            self.tenki.text = "くもり"
            weather_img.image = UIImage(named:"8.png")
        case "overcast clouds":
            self.tenki.text = "くもり"
            weather_img.image = UIImage(named:"9.png")
        default:
            print("それ以外")
        }
    }
    func setupClothes() {
        //配列で取得したcloth_id分処理を繰り返す
        for cloth_id in self.appDelegate.tops_cloth_array{
            let f = Cloth(imageUrl: NSURL(string: "http://52.193.213.154:3000/clothes/get_image?id=" + cloth_id))
            tops_clothes.append(f)
        }
        
        for cloth_id in self.appDelegate.others_cloth_array{
            let f = Cloth(imageUrl: NSURL(string: "http://52.193.213.154:3000/clothes/get_image?id=" + cloth_id))
            others_clothes.append(f)
        }
    }
    
    //データの個数を返すメソッド
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == TopsCollectionView {
            return tops_clothes.count
        }else{
            return others_clothes.count
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == TopsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopsCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
                        cell.setCell(cloth: tops_clothes[indexPath.row])
                        return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OthersCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
                        cell.setCell2(cloth: others_clothes[indexPath.row])
                        return cell
        }
    }
    
    //UICollectionViewDelegateFlowLayoutに定義されたメソッド
    //セクションごとに上下左右の余白を示すUIEdgeInsetsを返す
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        print("test")
        guard
            let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
            case let numItems = collectionView.numberOfItems(inSection: section), numItems > 0
            else {
                return .zero
        }
        
        //1セクション分の表示幅の計算(セルを可変サイズにする場合などは要修正)
        let minSpacing = flowLayout.minimumInteritemSpacing
        let itemWidth = flowLayout.itemSize.width
        let minSectionWidth = itemWidth * CGFloat(numItems) + minSpacing * CGFloat(numItems-1)
        
        //CollectionViewのコンテンツ領域の幅の計算
        let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
        
        //デフォルトのInsetsの取得
        var insets = flowLayout.sectionInset
        //セクションの表示幅がコンテンツ領域より小さい時には余白を計算
        if minSectionWidth < contentWidth {
            let paddingWidth = (contentWidth - minSectionWidth)/2
            insets.left = paddingWidth
            insets.right = paddingWidth
        }
        return insets
    }
    
  
     //ボトムスを表示させるメソッド
    func setupBottoms(){
        if self.appDelegate.bottoms_cloth == "" {
            return
        }
        
        let imgUrl = NSURL(string: "http://52.193.213.154:3000/clothes/get_image?id=" + self.appDelegate.bottoms_cloth);
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
        
        //洋服が登録されていない場合の処理
        if self.appDelegate.cloth_array.isEmpty{
            // ボタンのサイズを定義.
            let bWidth: CGFloat = 300
            let bHeight: CGFloat = 300
            // 配置する座標を定義(画面の中心).
            let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
            let posY: CGFloat = self.view.bounds.height/2 - bHeight/2
            // Labelを作成.
            let label: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
            // UILabelに文字を代入.
            label.numberOfLines = 3
            label.text = "洋服が登録されていないため、\n本日のおすすめはありません。\n洋服を登録してください。  "
            // Textを中央寄せにする.
            label.textAlignment = NSTextAlignment.center
            // ViewにLabelを追加.
            self.view.addSubview(label)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
