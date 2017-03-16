//
//  GetPhotoViewController.swift
//  Anetos
//
//  Created by 齋藤卓馬 on 2017/01/17.
//  Copyright © 2017年 齋藤卓馬. All rights reserved.
//

import UIKit

class GetPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidAppear(_ animated: Bool) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    

    //撮影が完了し、「Use Photo」が押されたときに呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(#function)
        // print(info[UIImagePickerControllerMediaType]!)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // 撮影した画像をカメラロールに保存
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //画像をアップロードする
        //アップロード先を指定する
        //let url = "http://52.196.123.118:3000/api/v1/clothes/"
        //let params = ["photo": image]
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        
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
