//
//  CheckoutViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/8/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var checkoutTableView : UITableView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var btnConfirmCheckout: UIButton!
    @IBOutlet weak var btnContinueShopping: UIButton!
    @IBOutlet weak var lblPercentDiscount:UILabel!
    @IBOutlet weak var lblDiscount:UILabel!
    @IBOutlet weak var lblNetTotal:UILabel!
    
    var percentDiscount:NSDecimalNumber = 0.0
    var discount:NSDecimalNumber = 0.0
    var netTotal:NSDecimalNumber = 0.0
    var setupNav = KPNavigationBar()
    var grandTotal : NSDecimalNumber = 0
    //var goodsNowList = [Goods]()
    //var goodsLaterList = [Goods]()
    var cartPickNowArray:[CartModel] = []
    var cartPickLaterArray:[CartModel] = []
    
    //var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialPage()
        self.checkoutTableView.backgroundColor = UIColor.whiteColor()
        print("Now List : \(cartPickNowArray.count)")
        print("Later List : \(cartPickLaterArray.count)")
        self.setupNav.setupNavigationBar(self)
        
        self.lblGrandTotal.text = self.grandTotal.currency
        self.lblPercentDiscount.text = "\(percentDiscount) %"
        self.lblDiscount.text = "-\(discount.currency)"
//        let netTotal = grandTotal.decimalNumberBySubtracting(discount)
        print("NETTOTAL1 : \(netTotal)")
        self.lblNetTotal.text = "\(netTotal.currency)"
        
    }
    
    func initialPage(){
        self.btnContinueShopping.layer.cornerRadius = 5
        self.btnContinueShopping.layer.borderWidth = 2.0
        self.btnContinueShopping.layer.borderColor = UIColor.blackColor().CGColor
        self.btnConfirmCheckout.layer.cornerRadius = 5
        self.checkoutTableView.registerNib(UINib(nibName: "NoItemFoundCell", bundle: nil), forCellReuseIdentifier: "noItemFoundCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Datasource and Delegate
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
            if self.cartPickNowArray.count == 0 {
                return 1
            }else{
                return self.cartPickNowArray.count
            }
            
        case 1 :
            if self.cartPickLaterArray.count == 0 {
                return 1
            }else{
                return self.cartPickLaterArray.count
            }
        default :
            return 0
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // code
        
        if indexPath.section == 0 {
            if self.cartPickNowArray.count != 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("checkoutTableViewCell", forIndexPath: indexPath) as! CheckoutTableViewCell
                cell.imgGoods.image = UIImage(named: self.cartPickNowArray[indexPath.row].cart_prod.prod_imageArray[0].proi_image_path)
                cell.lblGoods.text = self.cartPickNowArray[indexPath.row].cart_prod.prod_name
                cell.lblGoodsDetail.text = self.cartPickNowArray[indexPath.row].cart_prod.prod_description
                cell.lblGoodsDetail.font = UIFont(name: "Century Gothic", size: 12)
                let quantity = NSDecimalNumber(int: self.cartPickNowArray[indexPath.row].cart_quantity)
                cell.lblQuantity.text = String(quantity)
                let pricePerProd = NSDecimalNumber(double: self.cartPickNowArray[indexPath.row].cart_prod.prod_price)
                let totalPrice = quantity.decimalNumberByMultiplyingBy(NSDecimalNumber(double: self.cartPickNowArray[indexPath.row].cart_prod.prod_price))
                cell.lblUnitPrice.text = pricePerProd.currency
                cell.lblTotalPrice.text = totalPrice.currency
                /*
                self.grandTotal = self.grandTotal.decimalNumberByAdding(totalPrice)
                if indexPath.row == self.cartPickNowArray.count - 1 && self.cartPickLaterArray.count == 0 {
                self.lblGrandTotal.text = self.grandTotal.currency
                }*/
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("noItemFoundCell", forIndexPath: indexPath) as! NoItemFoundCell
                return cell
            }
        }else{
            if self.cartPickLaterArray.count != 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("checkoutTableViewCell", forIndexPath: indexPath) as! CheckoutTableViewCell
                cell.imgGoods.image = UIImage(named: self.cartPickLaterArray[indexPath.row].cart_prod.prod_imageArray[0].proi_image_path)
                cell.lblGoods.text = self.cartPickLaterArray[indexPath.row].cart_prod.prod_name
                cell.lblGoodsDetail.text = self.cartPickLaterArray[indexPath.row].cart_prod.prod_description
                cell.lblGoodsDetail.font = UIFont(name: "Century Gothic", size: 12)
                let quantity = NSDecimalNumber(int: self.cartPickLaterArray[indexPath.row].cart_quantity)
                cell.lblQuantity.text = String(quantity)
                let pricePerProd = NSDecimalNumber(double: self.cartPickLaterArray[indexPath.row].cart_prod.prod_price)
                let totalPrice = quantity.decimalNumberByMultiplyingBy(NSDecimalNumber(double: self.cartPickLaterArray[indexPath.row].cart_prod.prod_price))
                cell.lblUnitPrice.text = pricePerProd.currency
                cell.lblTotalPrice.text = totalPrice.currency
                /*
                self.grandTotal = self.grandTotal.decimalNumberByAdding(totalPrice)
                if indexPath.row == self.cartPickLaterArray.count - 1 {
                self.lblGrandTotal.text = self.grandTotal.currency
                }*/
                return cell
            }else {
                let cell = tableView.dequeueReusableCellWithIdentifier("noItemFoundCell", forIndexPath: indexPath) as! NoItemFoundCell
                return cell
            }
        }
    }
    
    @IBAction func continueShoppingMethod(sender: AnyObject) {
    }
    @IBAction func ConfirmCheckoutMethod(sender: AnyObject) {
        performSegueWithIdentifier("confirmShoppingSegue", sender: nil)
    }
    @IBAction func backToCartMethod(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
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
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        /*
        //var ordm_id         : Int32 = 0
        //var ordm_ords_id    : Int32 = 0
        //var ordm_user_id    : Int32 = 0
        //var ordm_cust_id    : Int32 = 0
        //var ordm_no : String = ""
        //var ordm_currency   : String = ""
        /var ordm_flight_departure : Int32 = 0
        var ordm_receipt_departure : String = ""
        //var ordm_picknow_flag : String = ""
        /var ordm_flight_arrival : Int32 = 0
        var ordm_receipt_arrival : String = ""
        //var ordm_picklater_flag : String = ""
        /var ordm_passport_no : String = ""
        //var ordm_current_location : String = ""
        //var ordm_pickup_location : String = ""
        //var ordm_total_price : Double = 0
        var ordm_submit_date : NSDate = NSDate()
        var ordm_create_date : NSDate = NSDate()
        var ordm_update_date : NSDate = NSDate()
        //var ordm_running_no  : Int32 = 0
        //var ordm_net_total_price : Double = 0
        //var ordm_card_discount : Int32 = 0
        */
        if segue.identifier == "confirmShoppingSegue" {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            // The way to get currentCustomer
            let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
            let userId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentUserId") as! String))
            let currentLocation = prefs.objectForKey(gv.getConfigValue("currentLocation") as! String) as! String
            print("Current Location \(currentLocation)")
            let yFlag = gv.getConfigValue("flagYes") as! String
            let nFlag = gv.getConfigValue("flagNo") as! String
            let orderMain  = OrderMainModel()
            orderMain.ordm_ords_id = 1
            orderMain.ordm_user_id = userId
            orderMain.ordm_cust_id = custId
            if cartPickNowArray.count == 0 {
                orderMain.ordm_picknow_flag = nFlag
            }else{
                orderMain.ordm_picknow_flag = yFlag
            }
            if cartPickLaterArray.count == 0 {
                orderMain.ordm_picklater_flag = nFlag
            }else{
                orderMain.ordm_picklater_flag = yFlag
            }
            orderMain.ordm_current_location = currentLocation
            orderMain.ordm_pickup_location = currentLocation
            orderMain.ordm_total_price = grandTotal.doubleValue
            print("NETTOTAL \(netTotal.doubleValue)")
            orderMain.ordm_net_total_price = netTotal.doubleValue
            orderMain.ordm_card_discount = percentDiscount.intValue
            let viewController:FlightInfoViewController = segue.destinationViewController as! FlightInfoViewController
            viewController.orderMain = orderMain
            viewController.cartPickNowArray = cartPickNowArray
            viewController.cartPickLaterArray = cartPickLaterArray
        }
    }
    
    
    //    func setupNavigationBar(){
    //        print("navigation frame: \(navigationController!.navigationBar.frame.width) x \(navigationController!.navigationBar.frame.height)")
    //        //Remove the shadow image altogether
    //        for parent in self.navigationController!.navigationBar.subviews {
    //            for childView in parent.subviews {
    //                if(childView is UIImageView) {
    //                    childView.removeFromSuperview()
    //                }
    //            }
    //        }
    //        //Container Layout
    //        navBar.frame=CGRectMake(0, 0, navigationController!.navigationBar.frame.width, navigationController!.navigationBar.frame.height)
    //        navBar.barTintColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))//UIColor(hexString: "000000")
    //        self.view.addSubview(navBar)
    //        self.view.sendSubviewToBack(navBar)
    //
    //        //Navigation Bar
    //        self.navigationController!.navigationBar.barTintColor =  UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))
    //
    //        let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
    //        let imageTitleView = UIImageView(frame: CGRect(
    //            x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
    //            y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
    //            width: gv.getConfigValue("navigationBarImgWidth") as! Int,
    //            height: gv.getConfigValue("navigationBarImgHeight") as! Int))
    //
    //        imageTitleView.contentMode = .ScaleAspectFit
    //        imageTitleView.image = imageTitleItem
    //        self.navigationItem.titleView = imageTitleView
    //
    //        self.addRightNavItemOnView()
    //        self.addLeftNavItemOnView()
    //
    //    }
    //    func addLeftNavItemOnView()
    //    {
    //        //Back
    //        let buttonMenu = UIButton(type: UIButtonType.Custom) as UIButton
    //        buttonMenu.frame = CGRectMake(
    //            gv.getConfigValue("navigationItemBackImgPositionX") as! CGFloat,
    //            gv.getConfigValue("navigationItemBackImgPositionY") as! CGFloat,
    //            gv.getConfigValue("navigationItemBackImgWidth") as! CGFloat,
    //            gv.getConfigValue("navigationItemBackImgHeight") as! CGFloat)
    //
    //        buttonMenu.setImage(UIImage(named: gv.getConfigValue("navigationItemBackImgName") as! String), forState: UIControlState.Normal)
    //        buttonMenu.addTarget(self, action: "backToPreviousPage:", forControlEvents: UIControlEvents.TouchUpInside) //use thiss
    //        let leftBarButtonItemMenu = UIBarButtonItem(customView: buttonMenu)
    //
    //        //Flight
    //        let buttonFlight = UIButton(type: UIButtonType.Custom) as UIButton
    //        buttonFlight.frame = CGRectMake(
    //            gv.getConfigValue("navigationItemAirplainImgPositionX") as! CGFloat,
    //            gv.getConfigValue("navigationItemAirplainImgPositionY") as! CGFloat,
    //            gv.getConfigValue("navigationItemAirplainImgWidth") as! CGFloat,
    //            gv.getConfigValue("navigationItemAirplainImgHeight") as! CGFloat)
    //        buttonFlight.setImage(UIImage(named: gv.getConfigValue("navigationItemAirplainImgName") as! String), forState: UIControlState.Normal)
    //        buttonFlight.addTarget(self, action: "navItemFlightClick:", forControlEvents: UIControlEvents.TouchUpInside)
    //        let leftBarButtonItemFilght = UIBarButtonItem(customView: buttonFlight)
    //
    //
    //        // add multiple right bar button items
    //        self.navigationItem.setLeftBarButtonItems([leftBarButtonItemMenu,leftBarButtonItemFilght], animated: true)
    //        // uncomment to add single right bar button item
    //        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
    //
    //    }
    //    func addRightNavItemOnView()
    //    {
    //        //Call
    //        let buttonCall = UIButton(type: UIButtonType.Custom) as UIButton
    //        buttonCall.frame = CGRectMake(
    //            gv.getConfigValue("navigationItemCallImgPositionX") as! CGFloat,
    //            gv.getConfigValue("navigationItemCallImgPositionY") as! CGFloat,
    //            gv.getConfigValue("navigationItemCallImgWidth") as! CGFloat,
    //            gv.getConfigValue("navigationItemCallImgHeight") as! CGFloat)
    //
    //        buttonCall.setImage(UIImage(named: gv.getConfigValue("navigationItemCallImgName") as! String), forState: UIControlState.Normal)
    //        buttonCall.addTarget(self, action: "navItemCallClick:", forControlEvents: UIControlEvents.TouchUpInside)
    //        let rightBarButtonItemCall = UIBarButtonItem(customView: buttonCall)
    //
    //        //Cart
    //        let buttonCart = UIButton(type: UIButtonType.Custom) as UIButton
    //        buttonCart.frame = CGRectMake(
    //            gv.getConfigValue("navigationItemCartImgPositionX") as! CGFloat,
    //            gv.getConfigValue("navigationItemCartImgPositionY") as! CGFloat,
    //            gv.getConfigValue("navigationItemCartImgWidth") as! CGFloat,
    //            gv.getConfigValue("navigationItemCartImgHeight") as! CGFloat)
    //
    //        buttonCart.setImage(UIImage(named: gv.getConfigValue("navigationItemCartImgName") as! String), forState: UIControlState.Normal)
    //        buttonCart.addTarget(self, action: "navItemCartClick:", forControlEvents: UIControlEvents.TouchUpInside)
    //        let rightBarButtonItemCart = UIBarButtonItem(customView: buttonCart)
    //
    //        //Search
    //        let buttonSearch = UIButton(type: UIButtonType.Custom) as UIButton
    //        buttonSearch.frame = CGRectMake(
    //            gv.getConfigValue("navigationItemSearchImgPositionX") as! CGFloat,
    //            gv.getConfigValue("navigationItemSearchImgPositionY") as! CGFloat,
    //            gv.getConfigValue("navigationItemSearchImgWidth") as! CGFloat,
    //            gv.getConfigValue("navigationItemSearchImgHeight") as! CGFloat)
    //        buttonSearch.setImage(UIImage(named: gv.getConfigValue("navigationItemSearchImgName") as! String), forState: UIControlState.Normal)
    //        buttonSearch.addTarget(self, action: "navItemSearchClick:", forControlEvents: UIControlEvents.TouchUpInside)
    //        let rightBarButtonItemSearch = UIBarButtonItem(customView: buttonSearch)
    //
    //
    //
    //        // add multiple right bar button items
    //        self.navigationItem.setRightBarButtonItems([rightBarButtonItemSearch,rightBarButtonItemCart,rightBarButtonItemCall], animated: true)
    //
    //        // uncomment to add single right bar button item
    //        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
    //    }
    //
    //    //Navigation Bar
    //    func backToPreviousPage(sender: AnyObject) {
    //        self.navigationController?.popViewControllerAnimated(true)
    //    }
    //
    //    func navItemFlightClick(sender:UIButton!)
    //    {
    //        self.removeNavigateView()
    //        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
    //        flightViewController.showInView(self.view, animated: true)
    //    }
    //
    //    func navItemCallClick(sender:UIButton!)
    //    {
    //        self.removeNavigateView()
    //        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
    //        callAssistanceViewController.showInView(self.view, animated: true)
    //
    //    }
    //
    //
    //    func navItemCartClick(sender:UIButton!)
    //    {
    //        print("navItemCartClick")
    //        let cartViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CartViewController") as? CartViewController
    //        self.navigationController?.pushViewController(cartViewController!, animated: true)
    //
    //    }
    //
    //    func navItemSearchClick(sender:UIButton!)
    //    {
    //        print("navItemSearchClick")
    //        let searchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
    //        let modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.FormSheet
    //        searchViewController?.modalPresentationStyle = modalStyle
    //        self.presentViewController(searchViewController!, animated: true, completion: nil)
    //    }
    
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
    
}
