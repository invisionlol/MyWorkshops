//
//  PageOneViewController.swift
//  MyWorkshops
//
//  Created by INVISION on 17/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit
import WebKit
import QRCodeReader     //ดึง library ของคนอื่นมาใช้

class PageOneViewController: UIViewController, WKNavigationDelegate, QRCodeReaderViewControllerDelegate {
    
    
    @IBOutlet weak var mWebView: WKWebView!     //ผูกตัวแปรกับ object
    @IBOutlet weak var mActivityIndicatorView: UIActivityIndicatorView!
    
    
    var mUrl = "https://pospos.co/"
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.openWeb()
        self.mWebView.navigationDelegate = self
        
    }
    
    func openWeb(){
        let url = URL(string: self.mUrl)        //Load Website
        let request = URLRequest(url: url!)
        self.mWebView.load(request)
    }
    
    func openPdf(){
        let pdfPath = Bundle.main.path(forResource: "product.pdf", ofType: nil)     //Find Path for File
        let pdfData = NSData(contentsOfFile: pdfPath!)
        self.mWebView.load(pdfData! as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL() as URL)
    }
    
    @IBAction func onClickSegmentControl(sender: UISegmentedControl){       //ผูกตัวแปรกับ action
        switch sender.selectedSegmentIndex {
        case 0:
            self.openWeb()
        default:
            self.openPdf()
        }
    }
    
    func scanQrcode(){
        self.readerVC.delegate = self
        self.readerVC.modalPresentationStyle = .formSheet
        present(self.readerVC, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.mActivityIndicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.mActivityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.absoluteString == "https://pospos.co/register" {
            self.scanQrcode()
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
        func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {   //ต้องมี qrcode reader
            print(result.value)
            dismiss(animated: true, completion: nil)
        }
        
        func readerDidCancel(_ reader: QRCodeReaderViewController) {
            dismiss(animated: true, completion: nil)
        }
        
    }

