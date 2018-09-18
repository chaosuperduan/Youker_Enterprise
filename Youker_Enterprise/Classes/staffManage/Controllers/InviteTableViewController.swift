//
//  InviteTableViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/8.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class InviteTableViewController: BaseTableViewController {
    var isJoin:Bool = false
    var dataArray:[User] = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatas()
        self.tableView.register(UINib.init(nibName: "InviteTableViewCell", bundle: nil), forCellReuseIdentifier: "invite")

       
    }
    override func loadDatas() {
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        
        params["state"] = isJoin ? 134:133
        params["operateUser"] = UserAccount.loadUserAccount()?.user_Id
        
        InviteViewModel.sharedInstance.GetInviteUsers(params: params as! [String : AnyObject], orVC: self) {
            
        }
        
        
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invite", for: indexPath) as! InviteTableViewCell

        if cell == nil  {
            cell == InviteTableViewCell()
        }
        cell.user = self.dataArray[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
