//
//  PageFiveViewController.swift
//  MyWorkshops
//
//  Created by INVISION on 17/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit
import Alamofire

class PageFiveViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var mImageView: UIImageView!{
        didSet{
            self.mImageView.drawAsCircle()
        }
    }
    @IBOutlet weak var mProgressView: UIProgressView!{
        didSet {
            self.mProgressView.progress = 0.0
        }
    }
    
    var mImagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImagePicker()
        //self.mImageView.drawAsCircle()
        
    }
    
    func setImagePicker(){
        self.mImagePicker = UIImagePickerController()
        self.mImagePicker.sourceType = .photoLibrary //เปิด photo library
        self.mImagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        let selectedImage = info[.originalImage] as! UIImage  //เอารูปที่เลือกไปใส่ใน imageview
        self.mImageView.image = selectedImage
    }
    
    @IBAction func onClickCamera(){
        //print("camera")
        present(self.mImagePicker, animated: true, completion: nil)
    }
    @IBAction func onClickShare(){  //ยิงไป server
        //print("upload")
        let image = self.mImageView.image?.jpegData(compressionQuality: 1.0)
        let name = "(\(arc4random()).jpeg"
        let url = "http://192.168.0.135:3000/uploads"
        self.uploadFile(url: url, data: image!, fileName: name)
    }
    
    func uploadFile(url: String, data: Data, fileName: String) {
        
        let params = ["username": "admin","password": "asdasdasd"]
        
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(data, withName: "userfile", fileName: fileName, mimeType: "image/jpg")
            for(key,value) in params{
                MultipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: url, method: .post).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
            self.mProgressView.progress = Float(progress.fractionCompleted)
        }).responseString(completionHandler: { (response) in
            self.mProgressView.progress = 0;
            switch response.result {
            case .success(let value):
                //                self.showNormalAlert(responseMsg: value)  //alert มีปุ่ม
               self.showAlertWithGesture(responseMsg: value)     //alert ไม่มีปุ่ม
                break
            case .failure:
                self.showAlertWithGesture(responseMsg: "failure")
                print("failure")
                break
            }
        })
        
    }
    
    func showNormalAlert(responseMsg: String){          //alert แบบมีปุ่ม
        let alertVC = UIAlertController(title: "Response", message: responseMsg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))  //สร้างปุ่มใน alert ให้ปิด
        alertVC.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (alert) in //สร้างปุ่มใน alert ให้ให้ทำใหม่
            self.onClickShare()
        }))
        present(alertVC, animated: true, completion: nil)
        
    }
    
    func showAlertWithGesture(responseMsg: String){
        let alertVC = UIAlertController(title: "Response", message: responseMsg, preferredStyle: .alert)
        present(alertVC, animated: true, completion: {() -> Void in
            alertVC.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeAlert(_:))))
            
            })
    }
    
    @objc func closeAlert(_ alert: UIAlertController){
        dismiss(animated: true, completion: nil)
    }
    

}
