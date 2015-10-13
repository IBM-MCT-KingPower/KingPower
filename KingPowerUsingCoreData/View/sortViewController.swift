//
//  sortViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/27/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

protocol sortDelegate{
    func setSorting(sortIndex : Int)
}

class sortViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var delegate:sortDelegate?
    var sortDataArray:[String] = ["PRODUCT NAME A-Z","PRODUCT NAME Z-A","BRAND NAME A-Z","BRAND NAME Z-A","PRICE LOW-HIGHT","PRICE HIGHT-LOW","NEW ARRIVAL","MOST POPULAR","DISCOUNT"]
    var markRow:Int = 0
    var indexpath:NSIndexPath = NSIndexPath()
    @IBOutlet weak var sortTableView: UITableView!
    
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
        return self.sortDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifierID = "sortCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierID) as! sortTableViewCell?
        cell?.menuLabel.text = self.sortDataArray[indexPath.row]
        cell?.menuLabel.font = UIFont(name: "Century Gothic", size: 15)
        if (indexPath.row==markRow){
            cell?.markImage.image = UIImage(named: "check")
            self.indexpath = indexPath
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(self.indexpath) as! sortTableViewCell?
        cell?.markImage.image = nil
        cell = tableView.cellForRowAtIndexPath(indexPath) as! sortTableViewCell?
        cell?.markImage.image = UIImage(named: "check")
        self.markRow = indexPath.row
        delegate?.setSorting(self.markRow)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! sortTableViewCell?
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
