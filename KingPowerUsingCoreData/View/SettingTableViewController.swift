//
//  SettingTableViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var sgmLanguage: UISegmentedControl!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var lblLanguage: UILabel!

    var constat = Constants()
    var lol = Locale()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decorate()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if self.revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    @IBAction func sgmLanguageTapped(sender: AnyObject) {
        switch sgmLanguage.selectedSegmentIndex
        {
        case 0:
            //textLabel.text = "First Segment Selected";
            LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE = "en"
            print("\n\ndip\(self.lol.languageCode)")
            self.lol = LanguageManager.sharedInstance.availableLocales[0]
            LanguageManager.sharedInstance.setLanguageWithLocale(self.lol)
            NSNotificationCenter.defaultCenter().postNotificationName("loadMenuList", object: nil)
            //Load selected Language to Views
            self.decorate()
            
            break;
        case 1:
            //textLabel.text = "Second Segment Selected";
            LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE = "th"
            self.lol = LanguageManager.sharedInstance.availableLocales[1]
            LanguageManager.sharedInstance.setLanguageWithLocale(self.lol)
            NSNotificationCenter.defaultCenter().postNotificationName("loadMenuList", object: nil)
            //Load selected Language to Views
            self.decorate()
            
            break;
        default:
            break;
        }

    }
    
    //DIP:: Do view recorating form here
    func decorate() {
        self.lblLanguage.text = self.constat.customLocalizedString("settingLanguage", comment: "this is comment")as String
        
        if constat.getLanguageCode() == "en" {
            sgmLanguage.selectedSegmentIndex = 0
        }
        else{
            sgmLanguage.selectedSegmentIndex = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
