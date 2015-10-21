//
//  OrderListViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kanoknacha Adisaiparadee on 10/18/15.
//  Copyright © 2015 IBM. All rights reserved.
//

import UIKit
import Foundation

class OrderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableViewOrder: UITableView!
    
    var setupNav = KPNavigationBar()
    var gv = GlobalVariable()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    var orderCurrentDateArray:[OrderMainModel]? = []
    var orderHistoryDateArray:[OrderMainModel]? = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableViewOrder.backgroundColor = UIColor.whiteColor()
        self.setupNav.setupNavigationBar(self)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        
        self.orderCurrentDateArray = OrderMainController().getOrderByCurrentDate(custId)
        self.orderHistoryDateArray = OrderMainController().getOrderByHistoryDate(custId)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let hView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 30))
        hView.backgroundColor = UIColor(hexString: String(gv.getConfigValue("sectionHeaderColor")))
        let hLabel = UILabel(frame: CGRectMake(10, 0, tableView.frame.width, 30))
        hLabel.font = UIFont(name: "Century Gothic", size: 18)
        hLabel.textColor = UIColor(hexString: String(gv.getConfigValue("whiteColor")))
        switch section {
        case 0 :
            hLabel.text =  "CURRENT ORDER"
        default :
            hLabel.text =  "PURCHASE HISTORY"
        }
        hView.addSubview(hLabel)
        return hView
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            if self.orderCurrentDateArray?.count == 0 {
                return 1
            } else {
                return self.orderCurrentDateArray!.count
            }
        default :
            if self.orderHistoryDateArray?.count == 0 {
                return 1
            } else {
                return self.orderHistoryDateArray!.count
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var orderstatus : String?
        var orderstatusid : Int32
        let cell = tableView.dequeueReusableCellWithIdentifier("orderlistcell", forIndexPath: indexPath) as! OrderListTableViewCell
        
        if indexPath.section == 0 {
            if self.orderCurrentDateArray?.count == 0 {
                cell.mOrderNo.text = "No Order"
                cell.mOrderAmt.text = ""
                cell.mOrderTotal.text = ""
                cell.mOrderDateTime.text = ""
                cell.mOrderStatus.text = ""
            } else {
                orderstatusid = (self.orderCurrentDateArray?[indexPath.row].ordm_ords_id)!
                orderstatus = OrderStatusController().getOrderByStatusId(Int32(orderstatusid))?.ords_name
                
                cell.mOrderNo.text = self.orderCurrentDateArray?[indexPath.row].ordm_no
                
                let amount = self.orderCurrentDateArray?[indexPath.row].ordm_ords.count
                cell.mOrderAmt.text = String(amount!)
                
                let total = NSDecimalNumber(double:(self.orderCurrentDateArray?[indexPath.row].ordm_net_total_price)!)
                cell.mOrderTotal.text = total.currency + " " + (self.orderCurrentDateArray?[indexPath.row].ordm_currency)!
                
                cell.mOrderDateTime.text = self.orderCurrentDateArray?[indexPath.row].ordm_submit_date
                cell.mOrderStatus.text = orderstatus
                
                if orderstatusid == 4 {
                    cell.mOrderStatus.textColor = UIColor.blueColor()
                } else {
                    cell.mOrderStatus.textColor = UIColor.orangeColor()
                }
            }
            
        } else {
            if self.orderHistoryDateArray?.count == 0 {
                cell.mOrderNo.text = "No Order"
                cell.mOrderAmt.text = ""
                cell.mOrderTotal.text = ""
                cell.mOrderDateTime.text = ""
                cell.mOrderStatus.text = ""
            } else {
                orderstatusid = (self.orderHistoryDateArray?[indexPath.row].ordm_ords_id)!
                orderstatus = OrderStatusController().getOrderByStatusId(Int32(orderstatusid))?.ords_name
                
                cell.mOrderNo.text = self.orderHistoryDateArray?[indexPath.row].ordm_no
                
                let amount = self.orderHistoryDateArray?[indexPath.row].ordm_ords.count
                cell.mOrderAmt.text = String(amount!)
                
                let total = NSDecimalNumber(double:(self.orderHistoryDateArray?[indexPath.row].ordm_net_total_price)!)
                cell.mOrderTotal.text = total.currency + " " + (self.orderHistoryDateArray?[indexPath.row].ordm_currency)!
                
                cell.mOrderDateTime.text = self.orderHistoryDateArray?[indexPath.row].ordm_submit_date
                cell.mOrderStatus.text = orderstatus
                if orderstatusid == 4 {
                    cell.mOrderStatus.textColor = UIColor.blueColor()
                } else {
                    cell.mOrderStatus.textColor = UIColor.orangeColor()
                }
            }
        }
        return cell
    }
    func viewFlightMethod(){
        self.removeNavigateView()
        CommonViewController().viewFlightMethod(self)
    }
    func callAssistMethod(){
        self.removeNavigateView()
        CommonViewController().callAssistMethod(self)
    }
    func searchMethod(){
        CommonViewController().searchMethod(self)
    }
    func viewCartMethod(){
        CommonViewController().viewCartMethod(self)
    }
    func removeNavigateView(){
        if(flightViewController != nil && !flightViewController.view.hidden)
        {
            flightViewController.view.removeFromSuperview()
        }
        if(callAssistanceViewController != nil && !callAssistanceViewController.view.hidden)
        {
            callAssistanceViewController.view.removeFromSuperview()
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
