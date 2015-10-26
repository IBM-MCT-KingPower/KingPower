//
//  MenuTableViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
import APAvatarImageView

class MenuTableViewController: UITableViewController {
    
    @IBOutlet weak var imvProfile: APAvatarImageView!
    @IBOutlet weak var lblProfileFirstName: UILabel!
    @IBOutlet weak var lblProfileLastName: UILabel!
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblOrderList: UILabel!
    @IBOutlet weak var lblCart: UILabel!
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var lblCheckout: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblLogout: UILabel!
    
    @IBOutlet weak var btnLanguage: UIButton!
    
    let commonViewController = CommonViewController()
    var gv = GlobalVariable()
    var constat = Constants()
    var lol = Locale()
    override func viewWillAppear(animated: Bool) {
        self.decorate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadMenuList:",name:"loadMenuList", object: nil)
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        let customer = CustomerController().getCustomerByCustId(custId)!
        
        self.imvProfile.image = UIImage(named: "05.png")
        self.imvProfile.contentMode = .ScaleAspectFit
        self.imvProfile.borderWidth = 5.0
        self.imvProfile.borderColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))
        self.lblProfileFirstName.text = "\(customer.cust_title).  \(customer.cust_first_name)"
        self.lblProfileLastName.text = "\(customer.cust_last_name)"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    
    @IBAction func btnTapped(sender: AnyObject) {
        //sender.target = self.revealViewController()
        //sender.action = "revealToggle:"
        
    }
    func loadMenuList(notification: NSNotification){
        //load data here
        self.decorate()
    }
    func decorate(){
        self.lblMain.text = self.constat.customLocalizedString("menuMain", comment: "this is comment")as String
        self.lblProfile.text = self.constat.customLocalizedString("menuProfile", comment: "this is comment")as String
        self.lblOrderList.text = self.constat.customLocalizedString("menuOrderList", comment: "this is comment")as String
        self.lblCart.text = self.constat.customLocalizedString("menuCart", comment: "this is comment")as String
        self.lblSetting.text = self.constat.customLocalizedString("menuSetting", comment: "this is comment")as String
        //self.lblCheckout.text = self.constat.customLocalizedString("menuCheckout", comment: "this is comment")as String
        self.lblLogout.text = self.constat.customLocalizedString("menuLogout", comment: "this is comment")as String
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("menu : select row \(indexPath.row)")
        if indexPath.row == 1 {
            commonViewController.alertView(self, title: gv.getConfigValue("messageProfileMenuTitle") as! String, message: gv.getConfigValue("messageUnderImplementation") as! String)
        }else if indexPath.row == 4 {
            commonViewController.alertView(self, title: gv.getConfigValue("messageSettingMenuTitle") as! String, message: gv.getConfigValue("messageUnderImplementation") as! String)
        }
    }
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "menuCartSegue" {
            print("Call cart from menu")
            let navVC = segue.destinationViewController as! UINavigationController
            let cartVC = navVC.topViewController as! CartViewController
            cartVC.isCalledFromMenu = true
        }else if segue.identifier == "menuOrderListSegue" {
            print("Call order list from menu")
        }else if segue.identifier == "logoutFromCustomer" {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            prefs.setInteger(0, forKey: gv.getConfigValue("currentCustomerId") as! String)
            prefs.setInteger(0, forKey: gv.getConfigValue("currentUserId") as! String)
            prefs.setInteger(0, forKey: gv.getConfigValue("currentAmountInCart") as! String)
            prefs.setObject("", forKey: gv.getConfigValue("currentLocation") as! String)
            prefs.synchronize()
        }
    }
    

}
