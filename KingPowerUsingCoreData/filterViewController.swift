//
//  filterViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/27/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class filterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var filterTableView: UITableView!
    var filterDataArray:[String] = ["SUB CATEGORY","BRAND","GENDER","PRICE RANGE","COLOR"]
    let detailTransitioningDelegate: filterdetailManager = filterdetailManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifierID = "filterCell"
        let cell = filterTableView.dequeueReusableCellWithIdentifier(cellIdentifierID) as UITableViewCell?
        
        cell?.textLabel!.text = self.filterDataArray[indexPath.row]
        cell?.textLabel!.font = UIFont(name: "Century Gothic", size: 15)
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "filterdetailCell") {
            var detailViewController = segue.destinationViewController as! detailFilterViewController
            //detailViewController.transitioningDelegate = detailTransitioningDelegate
            //detailViewController.modalPresentationStyle = .Custom
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
