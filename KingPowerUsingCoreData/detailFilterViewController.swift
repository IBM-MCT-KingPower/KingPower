//
//  detailFilterViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/27/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class detailFilterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var filterDetailTable: UITableView!
    var filterDetailDataArray:[String] = ["Watches","Sunglasses","Bags","Belt"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

    @IBAction func doneAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterDetailDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifierID = "detailCell"
        let cell = filterDetailTable.dequeueReusableCellWithIdentifier(cellIdentifierID) as! filterDetailTableViewCell?
        
        cell?.detailLabel!.text = self.filterDetailDataArray[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = filterDetailTable.cellForRowAtIndexPath(indexPath) as! filterDetailTableViewCell?
        cell?.markImage.image = UIImage(named: "check")
 
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = filterDetailTable.cellForRowAtIndexPath(indexPath) as! filterDetailTableViewCell?
        cell?.markImage.image = nil
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
