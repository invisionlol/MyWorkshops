//
//  PageTwoViewController.swift
//  MyWorkshops
//
//  Created by INVISION on 17/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit
import QRCode

class PageTwoViewController: UIViewController {
    
    @IBOutlet weak var mTextField: UITextField!
    @IBOutlet weak var mImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func onEditingChange(){
        let text = self.mTextField.text
        if text != "" && text != nil{
            var qrCode = QRCode(text!)
            qrCode?.color = CIColor(rgba: "000000")
            qrCode?.backgroundColor = CIColor(rgba: "FFFFFF")
            self.mImageView.image = qrCode?.image
        }else{
            self.mImageView.image = UIImage(named: "qr_code_generator")
        }
    }
}
