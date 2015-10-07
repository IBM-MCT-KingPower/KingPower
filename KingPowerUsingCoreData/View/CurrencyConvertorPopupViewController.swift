//
//  CurrencyConvertorViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/23/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class CurrencyConvertorPopupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tbvCurrency1: UITableView!
    @IBOutlet weak var tbvCurrency2: UITableView!
    @IBOutlet weak var btnOk: UIButton!
    var currencyArray = NSArray()
    var currencyArray1 = NSMutableArray()
    var currencyArray2 = NSMutableArray()
    var grandTotal:NSDecimalNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.btnOk.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(animated: Bool) {
        let currencyFilePath = NSBundle.mainBundle().pathForResource("Currency", ofType: "plist")
        currencyArray = NSArray(contentsOfFile: currencyFilePath!)!
        var i = 0
        let count = currencyArray.count / 2
        for currency in currencyArray {
            if i <=  count {
                self.currencyArray1.addObject(currency)
            }else{
                self.currencyArray2.addObject(currency)
            }
            i++
        }
        print("\(self.currencyArray.count)")
        print("\(self.currencyArray1.count)")
        print("\(self.currencyArray2.count)")
        self.tbvCurrency1.reloadData()
        self.tbvCurrency2.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tbvCurrency1 {
            return self.currencyArray1.count
        }else{
            return self.currencyArray2.count
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = CurrencyTableViewCell()
        if tableView == self.tbvCurrency1 {
            cell = self.tbvCurrency1.dequeueReusableCellWithIdentifier("currencyTableViewCell", forIndexPath: indexPath) as! CurrencyTableViewCell
            cell.imgNation.image = UIImage(named: String(currencyArray1[indexPath.row].objectForKey("nation")!))
            cell.lblNationName.text = String(currencyArray1[indexPath.row].objectForKey("nation")!)
            let rate : NSNumber = currencyArray1[indexPath.row].objectForKey("rate") as! NSNumber!
            cell.lblCurrency.text = String((NSNumber(float: grandTotal.floatValue / rate.floatValue).currency))
            
        }else{
            cell = self.tbvCurrency2.dequeueReusableCellWithIdentifier("currencyTableViewCell", forIndexPath: indexPath) as! CurrencyTableViewCell
            cell.imgNation.image = UIImage(named: String(currencyArray2[indexPath.row].objectForKey("nation")!))
            cell.lblNationName.text = String(currencyArray2[indexPath.row].objectForKey("nation")!)
            let rate : NSNumber = currencyArray2[indexPath.row].objectForKey("rate") as! NSNumber!
            cell.lblCurrency.text = String((NSNumber(float: grandTotal.floatValue / rate.floatValue).currency))
            
        }
        return cell
    }
    
    // MARK: - Action
    @IBAction func okClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
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