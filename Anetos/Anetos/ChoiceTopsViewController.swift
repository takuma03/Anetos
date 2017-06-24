//
//  ChoiceTopsViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/16.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class ChoiceTopsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBAction func unwindToChoice(segue: UIStoryboardSegue){
        
    }
    
    @IBOutlet weak var topsPicker: UIPickerView!
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var list = ["アウター（厚手）","アウター（薄手）","ジャケット","シャツ（半袖）","シャツ（長袖）","トレーナー","セーター","カーディガン","チュニック","Tシャツ（半袖）","Tシャツ（長袖）"]
    
    //PickerViewに表示する列数を返す
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //PickerViewに表示する行数を返す
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    //Picker Viewに表示する値を返す
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // FIXME
        // 選択したデータをグローバル変数に渡せていない気がする
        self.appDelegate.tag_name = "\(list[row])"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
