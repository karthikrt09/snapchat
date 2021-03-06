//
//  selectUserViewController.swift
//  Snapchat
//
//  Created by Karthik Thirunavukkarasan on 10/1/17.
//  Copyright © 2017 Karthik Thiru. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class selectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource=self
        self.tableView.delegate=self
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            
            let user = User()
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
            
        })

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }

}
