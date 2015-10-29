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
        self.TableViewOrder.registerNib(UINib(nibName: "NoItemFoundCell", bundle: nil), forCellReuseIdentifier: "noItemFoundCell")
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        
        self.orderCurrentDateArray = OrderMainController().getOrderByCurrentDate(custId)
        for orderMain in orderCurrentDateArray! {
            print("current : \(orderMain.ordm_id) \(orderMain.ordm_flight_departure) \(orderMain.ordm_flight_arrival) \(orderMain.ordm_no)")
        }
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
        
        if indexPath.section == 0 {
            if self.orderCurrentDateArray?.count == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("noItemFoundCell", forIndexPath: indexPath) as! NoItemFoundCell
                
                return cell
                
                
            } else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("orderlistcell", forIndexPath: indexPath) as! OrderListTableViewCell
                
                orderstatusid = (self.orderCurrentDateArray?[indexPath.row].ordm_ords_id)!
                orderstatus = OrderStatusController().getOrderByStatusId(Int32(orderstatusid))?.ords_name
                
                cell.mOrderNo.text = self.orderCurrentDateArray?[indexPath.row].ordm_no
                var amount:Int32 = 0
                for orderDetail in (self.orderCurrentDateArray?[indexPath.row].ordm_ords)!{
                    amount += orderDetail.ordd_quantity
                }
                //let amount = self.orderCurrentDateArray?[indexPath.row].ordm_ords.count
                
                cell.mOrderAmt.text = String(amount)
                
                let total = NSDecimalNumber(double:(self.orderCurrentDateArray?[indexPath.row].ordm_net_total_price)!)
                cell.mOrderTotal.text = total.currency + " " + (self.orderCurrentDateArray?[indexPath.row].ordm_currency)!
                
                cell.mOrderDateTime.text = self.orderCurrentDateArray?[indexPath.row].ordm_submit_date
                cell.mOrderStatus.text = orderstatus
                
                if orderstatusid == 4 {
                    cell.mOrderStatus.textColor = UIColor.blueColor()
                } else {
                    cell.mOrderStatus.textColor = UIColor.orangeColor()
                }
                
                return cell
            }
            
        } else {
            if self.orderHistoryDateArray?.count == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("noItemFoundCell", forIndexPath: indexPath) as! NoItemFoundCell
                
                return cell
                
                
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("orderlistcell", forIndexPath: indexPath) as! OrderListTableViewCell
                
                
                orderstatusid = (self.orderHistoryDateArray?[indexPath.row].ordm_ords_id)!
                orderstatus = OrderStatusController().getOrderByStatusId(Int32(orderstatusid))?.ords_name
                
                cell.mOrderNo.text = self.orderHistoryDateArray?[indexPath.row].ordm_no
                var amount:Int32 = 0
                for orderDetail in (self.orderHistoryDateArray?[indexPath.row].ordm_ords)!{
                    amount += orderDetail.ordd_quantity
                }
                //let amount = self.orderHistoryDateArray?[indexPath.row].ordm_ords.count
                cell.mOrderAmt.text = String(amount)
                
                let total = NSDecimalNumber(double:(self.orderHistoryDateArray?[indexPath.row].ordm_net_total_price)!)
                cell.mOrderTotal.text = total.currency + " " + (self.orderHistoryDateArray?[indexPath.row].ordm_currency)!
                
                cell.mOrderDateTime.text = self.orderHistoryDateArray?[indexPath.row].ordm_submit_date
                cell.mOrderStatus.text = orderstatus
                if orderstatusid == 4 {
                    cell.mOrderStatus.textColor = UIColor.blueColor()
                } else {
                    cell.mOrderStatus.textColor = UIColor.orangeColor()
                }
                
                return cell
            }
        }
        
    }
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let hView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 30))
        hView.backgroundColor = UIColor.whiteColor()
        
        return hView
    }

    func viewFlightMethod(){
        self.removeNavigateView()
        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
        CommonViewController().viewFlightMethod(self, flight: flightViewController)
    }
    func callAssistMethod(){
        self.removeNavigateView()
        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
        CommonViewController().callAssistMethod(self, call: callAssistanceViewController)
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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectedOrderSegue" {
            if let indexPath = self.TableViewOrder.indexPathForSelectedRow {
                print("index path : \(indexPath.row)")
                if self.TableViewOrder.indexPathForSelectedRow?.section == 0 {
                
                    let selectedOrderId = self.orderCurrentDateArray![indexPath.row].ordm_id
                    let selectedCurrency = self.orderCurrentDateArray![indexPath.row].ordm_currency
                    (segue.destinationViewController as! OrderDetailViewController).orderMain = self.orderCurrentDateArray![indexPath.row]
                    (segue.destinationViewController as! OrderDetailViewController).orderId = selectedOrderId
                    (segue.destinationViewController as! OrderDetailViewController).currencyOrder = selectedCurrency
                } else {
                    let selectedOrderId = self.orderHistoryDateArray![indexPath.row].ordm_id
                    let selectedCurrency = self.orderHistoryDateArray![indexPath.row].ordm_currency
                    (segue.destinationViewController as! OrderDetailViewController).orderMain = self.orderHistoryDateArray![indexPath.row]
                    (segue.destinationViewController as! OrderDetailViewController).orderId = selectedOrderId
                    (segue.destinationViewController as! OrderDetailViewController).currencyOrder = selectedCurrency
                    
                }
            }
        }
    }

}
