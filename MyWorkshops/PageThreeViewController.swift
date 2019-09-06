//
//  PageThreeViewController.swift
//  MyWorkshops
//
//  Created by INVISION on 17/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit
import Alamofire    //ใช้ยิง feed
import AlamofireImage   //แปลงเป็น url ให้เป็นรูปภาพ
import XCDYouTubeKit //เล่น youtube

class PageThreeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var mTableview: UITableView!
    var mDataArray: [Youtube] = []
    var mBlurView: DKLiveBlurView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedData()
        self.setBlur()

    }
    
    func setBlur(){
        // Add header view
        let headerView = UIView()
        let ratioOfImage: CGFloat = 1.15 //images width/height 2195/1901= 1.15
        let height = UIScreen.main.bounds.width / ratioOfImage
        headerView.frame = CGRect(x: 0, y: 0, width: 1, height: height)
        self.mTableview.tableHeaderView = headerView
        
        // Setup Blur Effect
        self.mBlurView = DKLiveBlurView()
        let image = UIImage(named: "superhero_iphone.jpg") // "superhero_iphone.jpg" "listview_iphone.png"
        self.mBlurView.originalImage = image
        self.mTableview.backgroundView = self.mBlurView
        
        //Row Height
        self.mTableview.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mBlurView.scrollView = self.mTableview
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.mBlurView.scrollView = nil
    }
    
    func feedData() {
        let parame = ["username": "admin","password": "password", "type": "superhero"]
        let url = "http://codemobiles.com/adhoc/youtubes/index_new.php"
        
        AF.request(url, method: .post, parameters: parame).responseJSON { (response) in
            switch response.result {
                
            case .success:
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(YoutubeResponse.self, from: response.data!)
                    self.mDataArray = result.youtubes  //type ต้องตรงกัน
                    self.mTableview.reloadData() //ทำเสร็จให้ reload เสมอ
                    
                } catch let err {
                    print(err)
                }
                break
            default:
                break
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableview.dequeueReusableCell(withIdentifier: "youtube") as? YouTubeDataTableViewCell
        let item = self.mDataArray[indexPath.row]
        cell?.mTitleLable.text = item.title
        cell?.mSubtitleLable.text = item.subtitle
        cell?.mAvatarImageView.af_setImage(withURL: item.avatarImage.url())
        cell?.mYoutubeImageView.af_setImage(withURL: item.youtubeImage.url())
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mTableview.deselectRow(at: indexPath, animated: true)
        
        let item = self.mDataArray[indexPath.row]
        let youtubeVC = XCDYouTubeVideoPlayerViewController(videoIdentifier: item.id) //ตัวแปรไว้เล่นยูทูปตามไอดี
        present(youtubeVC, animated: true, completion: nil)
        
    }

}
