//
//  ViewController.swift
//  MyWorkshops
//
//  Created by INVISION on 17/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImageLayout()
        
    }
    
    func setImageLayout(){
        let ratioOfImage: CGFloat = 1.15// width/height : 2195/1901 = 1.15
        let height = UIScreen.main.bounds.width / ratioOfImage
        self.tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {     //textlable > title
        let selectedRow = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: selectedRow!)
        segue.destination.title = cell?.textLabel?.text
        
        let backButton = UIBarButtonItem()                                 //change back button
        backButton.title = "กลับ"
        self.navigationItem.backBarButtonItem = backButton
        
        
    }
}

