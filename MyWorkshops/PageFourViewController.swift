//
//  PageFourViewController.swift
//  MyWorkshops
//
//  Created by INVISION on 17/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit
import FMDB
import DynamicColor

class PageFourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var mTableView: UITableView!
    var mDatabase: FMDatabase!
    var mDataArray: [[String:String]] = []
    
    let mFlightDummyArray:[String] =
        ["07:00     TG102       BKK     A33",
         "16:30     BE731       LON     B01",
         "09:45     FR122       FRA     D23",
         "19:30     AA911       AME     F53",
         "01:20     CN099       CHA     G22",
         "12:10     TG233       DEN     A23",
         "17:40     KR122       LDN     J32",
         "13:30     JP291       JAN     C04",
         "20:20     KR001       KOR     D09",
         "21:10     LU022       SPN     E22",
         "22:40     TG110       URN     A18"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.openDB()
        self.query()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {   // edit button (top right)
        if self.navigationItem.rightBarButtonItem?.title == "Edit"{
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.mTableView.setEditing(true, animated: true)
        }else{
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.mTableView.setEditing(false, animated: true)
        }
    }
    
    func openDB(){  //connect database
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        //print(documentsFolder)  print หา ที่อยู่ของ database file
        let path = documentsFolder + "/data.sqlite"
        
        let fileManager = FileManager()
        if(!fileManager.fileExists(atPath: path)){
            let dbFilePath = Bundle.main.path(forResource: "data.sqlite", ofType: nil)
            do{
                try fileManager.copyItem(atPath: dbFilePath!, toPath: path)
            }catch let err{
                print(err)
            }
        }
        
        self.mDatabase = FMDatabase(path: path)
        self.mDatabase.open()
        
    }
    
    func query() {     //เรียก database มาใช้ แล้วเอามาแสดง
        self.mDataArray.removeAll()
        
        if let rs = mDatabase.executeQuery("SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW DESC", withArgumentsIn: []){
            
            while rs.next() {
                let data_rowID = rs.int(forColumn: "ROW") // ["ROW": 1]
                let data_field_data = rs.string(forColumn: "FIELD_DATA") // ["FIELD_DATA": "17:40 KR122 LDN J32"]
                let item:[String:String] = ["ROW":String(data_rowID),"FIELD_DATA":data_field_data!]
                // ["ROW": "1", "FIELD_DATA": "17:40 KR122 LDN J32"]
                self.mDataArray.append(item)
            }
            self.mTableView.reloadData()
        } else {
            print("select failed: \(mDatabase.lastErrorMessage())")
        }
        
    }
    
    
    @IBAction func onClickAdd(){
        let randomIndex = Int(arc4random_uniform(11)) // random between 0..10
        let dummyData = self.mFlightDummyArray[randomIndex]
        //print(dummyData)
        if !mDatabase.executeUpdate("INSERT INTO FIELDS (FIELD_DATA) VALUES (?)", withArgumentsIn: [dummyData]) {
            print("insert 1 table failed: \(mDatabase.lastErrorMessage())")
        }
        self.query()
    }
    
    func deleteRow(whichArg: String){  // delete row from database
        if !mDatabase.executeUpdate("DELETE FROM FIELDS WHERE ROW = ?", withArgumentsIn: [whichArg]) {
            print("delete 1 table failed: \(mDatabase.lastErrorMessage())")
        }
        self.query()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.mTableView.dequeueReusableCell(withIdentifier: "header")
        return header?.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: "custom") as? CustomTableViewCell
        let item = self.mDataArray[indexPath.row]
        cell?.mFlightLabel.text = item["FIELD_DATA"]
        
        if indexPath.row % 2 == 0 {
            cell?.mFlightLabel.textColor = UIColor(hexString: "#7BDF2D")
            cell?.mFlightImageView.image = UIImage(named: "takeoff_icon")
            cell?.contentView.backgroundColor = UIColor(hexString: "F2F2F2")
        }else{
            cell?.mFlightLabel.textColor = UIColor(hexString: "#3696EA")
            cell?.mFlightImageView.image = UIImage(named: "landing_icon")
            cell?.contentView.backgroundColor = UIColor(hexString: "FFFFFF")
        }
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //ดักค่า selecting object
        self.mTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.mDataArray[indexPath.row]
        //print(item["ROW"])
        if editingStyle == .delete {
            let rowID = item["ROW"]
            self.deleteRow(whichArg: rowID!)    //ลบ
        }
        
    }
    
    
}
