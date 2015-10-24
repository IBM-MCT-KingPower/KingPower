//
//  OrderDetailViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kanoknacha Adisaiparadee on 10/23/15.
//  Copyright © 2015 IBM. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lblGrandTotalAmt :UILabel!
    @IBOutlet weak var lblPercentDiscount:UILabel!
    @IBOutlet weak var lblDiscount:UILabel!
    @IBOutlet weak var lblNetAmt:UILabel!
    @IBOutlet weak var lblGrandCurrency: UILabel!
    @IBOutlet weak var detailtableview: UITableView!
    
    var setupNav = KPNavigationBar()
    var gv = GlobalVariable()
    var grandTotal : NSDecimalNumber = 0
    var orderId: Int32 = 0
    var currencyOrder: String = ""
    var orderMain:OrderMainModel!
    
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    var orderDetailPickNowArray:[OrderDetailModel] = []
    var orderDetailPickLaterArray:[OrderDetailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav.setupNavigationBar(self)
        self.detailtableview.registerNib(UINib(nibName: "NoItemFoundCell", bundle: nil), forCellReuseIdentifier: "noItemFoundCell")
        //orderId = 2
        
        self.orderDetailPickNowArray = OrderDetailController().getOrderDetailPickTypeByOrderId(orderId, ordd_pickup_now: "Y")!
        self.orderDetailPickLaterArray = OrderDetailController().getOrderDetailPickTypeByOrderId(orderId, ordd_pickup_now: "N")!
        /*
        for var indexNow = 0; indexNow < self.orderDetailPickNowArray.count; ++indexNow {
            self.grandTotal = self.grandTotal.decimalNumberByAdding(NSDecimalNumber(double: self.orderDetailPickNowArray[indexNow].ordd_total_price))
        }
        for var indexLater = 0; indexLater < self.orderDetailPickLaterArray.count; ++indexLater{
            self.grandTotal = self.grandTotal.decimalNumberByAdding(NSDecimalNumber(double: self.orderDetailPickLaterArray[indexLater].ordd_total_price))
        }*/
        let grandTotal = self.orderMain.ordm_total_price
        let netTotal = self.orderMain.ordm_net_total_price
        lblGrandTotalAmt.text = NSDecimalNumber(double: grandTotal).currency
        lblPercentDiscount.text = "\(orderMain.ordm_card_discount)%"
        lblDiscount.text = NSDecimalNumber(double: (netTotal-grandTotal)).currency
        lblNetAmt.text = NSDecimalNumber(double: netTotal).currency
        lblGrandCurrency.text = currencyOrder
        
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            if self.orderDetailPickNowArray.count == 0 {
                return 1
            } else {
                return self.orderDetailPickNowArray.count
            }
        default :
            if self.orderDetailPickLaterArray.count == 0 {
                return 1
            } else {
                return self.orderDetailPickLaterArray.count
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if self.orderDetailPickNowArray.count != 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("orderdetailcell", forIndexPath: indexPath) as! OrderDetailTableViewCell
                
                cell.imgGoods.image = UIImage(named: self.orderDetailPickNowArray[indexPath.row].product.prod_imageArray[0].proi_image_path)
                cell.lblGoods.text = self.orderDetailPickNowArray[indexPath.row].product.prod_name
                cell.lblGoodsDetail.text = self.orderDetailPickNowArray[indexPath.row].product.prod_description
                cell.lblGoodsDetail.font = UIFont(name: "Century Gothic", size: 12)
                let quantity = NSDecimalNumber(int: self.orderDetailPickNowArray[indexPath.row].ordd_quantity)
                cell.lblQuantity.text = String(quantity)
                
                let pricePerProd = NSDecimalNumber(double: self.orderDetailPickNowArray[indexPath.row].product.prod_price)
                let totalPrice = NSDecimalNumber(double: self.orderDetailPickNowArray[indexPath.row].ordd_total_price)
                
                cell.lblUnitPrice.text = pricePerProd.currency
                cell.lblTotalPrice.text = totalPrice.currency
                
                cell.lblUnitCurrency.text = currencyOrder
                cell.lblTotalCurrency.text = currencyOrder
                
                return cell
                
                
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("noItemFoundCell", forIndexPath: indexPath) as! NoItemFoundCell
                
                return cell
            }
        } else {
            
            if self.orderDetailPickLaterArray.count != 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("orderdetailcell", forIndexPath: indexPath) as! OrderDetailTableViewCell
                
                cell.imgGoods.image = UIImage(named: self.orderDetailPickLaterArray[indexPath.row].product.prod_imageArray[0].proi_image_path)
                cell.lblGoods.text = self.orderDetailPickLaterArray[indexPath.row].product.prod_name
                cell.lblGoodsDetail.text = self.orderDetailPickLaterArray[indexPath.row].product.prod_description
                cell.lblGoodsDetail.font = UIFont(name: "Century Gothic", size: 12)
                let quantity = NSDecimalNumber(int: self.orderDetailPickLaterArray[indexPath.row].ordd_quantity)
                cell.lblQuantity.text = String(quantity)
                
                let pricePerProd = NSDecimalNumber(double: self.orderDetailPickLaterArray[indexPath.row].product.prod_price)
                let totalPrice = NSDecimalNumber(double: self.orderDetailPickLaterArray[indexPath.row].ordd_total_price)
                
                cell.lblUnitPrice.text = pricePerProd.currency
                cell.lblTotalPrice.text = totalPrice.currency
                
                cell.lblUnitCurrency.text = currencyOrder
                cell.lblTotalCurrency.text = currencyOrder
                
                return cell
                
                
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("noItemFoundCell", forIndexPath: indexPath) as! NoItemFoundCell
                return cell
            }
            
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 35))
        hView.backgroundColor = UIColor(hexString: String(gv.getConfigValue("sectionHeaderColor")))
        let hLabel = UILabel(frame: CGRectMake(10, 0, tableView.frame.width, 35))
        hLabel.font = UIFont(name: "Century Gothic", size: 20)
        hLabel.textColor = UIColor(hexString: String(gv.getConfigValue("whiteColor")))
        switch section {
        case 0 :
            hLabel.text =  "Pick Now"
        case 1 :
            hLabel.text =   "Pick Later"
        default :
            hLabel.text =   "Pick Now"
        }
        hView.addSubview(hLabel)
        return hView
    }
    
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
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
