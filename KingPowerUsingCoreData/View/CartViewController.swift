//
//  CartViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/5/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
import Foundation

struct  Goods {
    var goodsImageName : String
    var goodsName : String
    var goodsQuantity : Int
    var goodsPricePerItem : NSDecimalNumber
    
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var constat = Constants()
    var goodsNowList = [Goods]()
    var goodsLaterList = [Goods]()
    var grandTotal:NSDecimalNumber = 0.0
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var allPopupView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var btnContinueShopping: UIButton!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var btnContinueShoppingPopup: UIButton!
    @IBOutlet weak var btnCheckoutPopup: UIButton!
    @IBOutlet weak var imgPromotion: UIImageView!
    @IBOutlet weak var txtvPromotionDetail: UITextView!
    var btnRelatedProduct = UIButton()
    var btnRecommendedProduct = UIButton()
    var isRelated = true
    
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialValue()
        self.customPromotionPopup()
        self.title  = self.constat.customLocalizedString("cartTitle", comment: "this is comment")as String
        self.cartTableView.backgroundColor = UIColor.whiteColor()
        let goods1 = Goods(goodsImageName: "557590-L3.jpg", goodsName: "Good1", goodsQuantity: 1, goodsPricePerItem : 1280.0)
        let goods2 = Goods(goodsImageName: "543709-L1.jpg", goodsName: "Good2", goodsQuantity: 2, goodsPricePerItem : 2430.0)
        self.goodsNowList.append(goods1)
        self.goodsNowList.append(goods2)
        let goods3 = Goods(goodsImageName: "480103-L1.jpg", goodsName: "Good3", goodsQuantity: 3, goodsPricePerItem : 8990.0)
        let goods4 = Goods(goodsImageName: "461108-M3.jpg", goodsName: "Good4", goodsQuantity: 4, goodsPricePerItem : 14210.0)
        self.goodsLaterList.append(goods3)
        self.goodsLaterList.append(goods4)
        // Do any additional setup after loading the view.
        self.cartTableView.delegate = self
        self.setupNavigationBar()
        
    }
    
    func initialValue(){
        self.allPopupView.hidden = true
        self.popupView.hidden = true
        self.btnContinueShopping.layer.cornerRadius = 5
        self.btnContinueShopping.layer.borderWidth = 2.0
        self.btnContinueShopping.layer.borderColor = UIColor.blackColor().CGColor
        self.btnCheckout.layer.cornerRadius = 5
        self.btnContinueShoppingPopup.layer.cornerRadius = 5
        self.btnContinueShoppingPopup.layer.borderWidth = 2.0
        self.btnContinueShoppingPopup.layer.borderColor = UIColor.blackColor().CGColor
        self.btnCheckoutPopup.layer.cornerRadius = 5

    }
    
    func customPromotionPopup(){
        self.popupView.layer.cornerRadius = 20
        self.popupView.alpha = 0.0
        let lineView = UIView(frame: CGRectMake(0, 250, self.popupView.bounds.size.width, 1))
        lineView.backgroundColor = UIColor.lightGrayColor()
        self.popupView.addSubview(lineView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - TableView Datasource and Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == cartTableView {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // code
        let cell = tableView.dequeueReusableCellWithIdentifier("cartTableViewCell", forIndexPath: indexPath) as! CartTableViewCell
        if indexPath.section == 0 {
            cell.imgGoods.image = UIImage(named: self.goodsNowList[indexPath.row].goodsImageName)
            cell.lblGoods.text = self.goodsNowList[indexPath.row].goodsName
            let quantity = NSDecimalNumber(integer: self.goodsNowList[indexPath.row].goodsQuantity)
            cell.txtfQuantity.text = String(quantity)
            let price = quantity.decimalNumberByMultiplyingBy(self.goodsNowList[indexPath.row].goodsPricePerItem)
            cell.lblUnitPrice.text = self.goodsNowList[indexPath.row].goodsPricePerItem.currency
            cell.lblTotalPrice.text = price.currency
            cell.swtPickupType.on = true
            self.grandTotal = self.grandTotal.decimalNumberByAdding(price)
        }else{
            cell.imgGoods.image = UIImage(named: self.goodsLaterList[indexPath.row].goodsImageName)
            cell.lblGoods.text = self.goodsLaterList[indexPath.row].goodsName
            let quantity = NSDecimalNumber(integer: self.goodsLaterList[indexPath.row].goodsQuantity)
            cell.txtfQuantity.text = String(quantity)
            let price = quantity.decimalNumberByMultiplyingBy(self.goodsLaterList[indexPath.row].goodsPricePerItem)
            cell.lblUnitPrice.text = self.goodsLaterList[indexPath.row].goodsPricePerItem.currency
            cell.lblTotalPrice.text = price.currency
            cell.swtPickupType.on = false
            self.grandTotal = self.grandTotal.decimalNumberByAdding(price)
            if indexPath.row == self.goodsLaterList.count - 1 {
                self.lblGrandTotal.text = self.grandTotal.currency
            }

        }
        cell.stpQuantity.value = Double(cell.txtfQuantity.text!)!
        cell.swtPickupType.addTarget(self, action: Selector("checkSwitchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        cell.stpQuantity.addTarget(self, action: Selector("checkQuantityChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return self.goodsNowList.count
        case 1 :
            return self.goodsLaterList.count
        default :
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section {
            case 0 :
                return "Pick Now"
            case 1 :
                return "Pick Later"
            default :
                return "Pick Now"
            }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let hView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 30))
            hView.backgroundColor = UIColor(hexString: String(gv.getConfigValue("sectionHeaderColor")))
            let hLabel = UILabel(frame: CGRectMake(10, 0, tableView.frame.width, 30))
            hLabel.font = UIFont(name: "Century Gothic", size: 18)
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

    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var oldPrice = NSDecimalNumber(int: 0)
        var oldQuantity = NSDecimalNumber(int: 0)
        if editingStyle == .Delete {
            switch indexPath.section {
            case 0 :
                oldPrice = self.goodsNowList[indexPath.row].goodsPricePerItem
                oldQuantity = NSDecimalNumber(integer: self.goodsNowList[indexPath.row].goodsQuantity)
                self.goodsNowList.removeAtIndex(indexPath.row)
                self.cartTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                //self.cartTableView.reloadData()
            case 1 :
                oldPrice = self.goodsLaterList[indexPath.row].goodsPricePerItem
                oldQuantity = NSDecimalNumber(integer: self.goodsLaterList[indexPath.row].goodsQuantity)
                self.goodsLaterList.removeAtIndex(indexPath.row)
                self.cartTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                //self.cartTableView.reloadData()
            default :
                print("default")
            }
            let oldTotalPrice = oldQuantity.decimalNumberByMultiplyingBy(oldPrice)
            self.grandTotal = self.grandTotal.decimalNumberBySubtracting(oldTotalPrice)
            self.lblGrandTotal.text = self.grandTotal.currency
        }
    }
    // MARK: - Action
    @IBAction func checkOutClicked(sender: AnyObject) {
        self.allPopupView.hidden = false
        self.popupView.hidden = false
        UIView.animateWithDuration(0.5, animations: {
            self.popupView.alpha = 1.0
        })
    }
    
    
   
    @IBAction func continueShoppingClicked(sender: AnyObject) {
        
    }
    
    @IBAction func checkoutWithPopupMethod(sender: AnyObject) {
    }
    
    
    @IBAction func checkSwitchChanged(sender: AnyObject) {
        self.grandTotal = NSDecimalNumber(double: 0.0)
        let switch1 = sender as! UISwitch
        
        let clickedCell  = switch1.superview?.superview as! UITableViewCell
        let indexPath = self.cartTableView.indexPathForCell(clickedCell) as NSIndexPath?
        if switch1.on == true {
            let curGoods = self.goodsLaterList[indexPath!.row]
            self.goodsLaterList.removeAtIndex(indexPath!.row)
            self.goodsNowList.append(curGoods)
        }else{
            let curGoods = self.goodsNowList[indexPath!.row]
            self.goodsNowList.removeAtIndex(indexPath!.row)
            self.goodsLaterList.append(curGoods)
        }
        print("SWITCH : \(switch1.on) SECTION : \(indexPath!.section) ROW : \(indexPath!.row)")
        self.cartTableView.reloadData()
    }
    
    @IBAction func checkQuantityChanged(sender: AnyObject) {
        
        let stepper = sender as! UIStepper
        let quantity = NSDecimalNumber(double : stepper.value)
        let pricePerItem:NSDecimalNumber!
        
        let clickedCell  = stepper.superview?.superview as! CartTableViewCell
        let indexPath = self.cartTableView.indexPathForCell(clickedCell) as NSIndexPath?
        var oldPrice = NSDecimalNumber(int: 0)
        var oldQuantity = NSDecimalNumber(int: 0)
        if indexPath!.section == 0 {
            oldPrice = self.goodsNowList[indexPath!.row].goodsPricePerItem
            oldQuantity = NSDecimalNumber(integer: self.goodsNowList[indexPath!.row].goodsQuantity)
            self.goodsNowList[indexPath!.row].goodsQuantity = Int(stepper.value)
            pricePerItem = self.goodsNowList[indexPath!.row].goodsPricePerItem
        }else{
            oldPrice = self.goodsLaterList[indexPath!.row].goodsPricePerItem
            oldQuantity = NSDecimalNumber(integer: self.goodsLaterList[indexPath!.row].goodsQuantity)
            self.goodsLaterList[indexPath!.row].goodsQuantity = Int(stepper.value)
            pricePerItem = self.goodsLaterList[indexPath!.row].goodsPricePerItem
        }
        clickedCell.txtfQuantity.text = String(Int(stepper.value))
        let oldTotalPrice = oldQuantity.decimalNumberByMultiplyingBy(oldPrice)
        let newTotalPrice = quantity.decimalNumberByMultiplyingBy(pricePerItem)
        clickedCell.lblTotalPrice.text = newTotalPrice.currency
        self.grandTotal = self.grandTotal.decimalNumberBySubtracting(oldTotalPrice).decimalNumberByAdding(newTotalPrice)
        self.lblGrandTotal.text = self.grandTotal.currency
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        /*
        if segue.identifier == "promotionPopupSegue" {
        let viewController:PromotionPopupViewController = segue.destinationViewController as! PromotionPopupViewController
        viewController.goodsNowList = goodsNowList
        viewController.goodsLaterList = goodsLaterList
        }*/
        self.allPopupView.hidden = true
        self.popupView.hidden = true
        if segue.identifier == "checkoutSegue" {
            let viewController:CheckoutViewController = segue.destinationViewController as! CheckoutViewController
            viewController.goodsNowList = goodsNowList
            viewController.goodsLaterList = goodsLaterList
        }else if segue.identifier == "currencyConvertorSegue"{
            let viewController:CurrencyConvertorPopupViewController = segue.destinationViewController as! CurrencyConvertorPopupViewController
            viewController.grandTotal = self.grandTotal
            
        }
    }

    
    func setupNavigationBar(){
        print("navigation frame: \(navigationController!.navigationBar.frame.width) x \(navigationController!.navigationBar.frame.height)")
        //Remove the shadow image altogether
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        //Container Layout
        navBar.frame=CGRectMake(0, 0, navigationController!.navigationBar.frame.width, navigationController!.navigationBar.frame.height)
        navBar.barTintColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))//UIColor(hexString: "000000")
        self.view.addSubview(navBar)
        self.view.sendSubviewToBack(navBar)
        
        //Navigation Bar
        self.navigationController!.navigationBar.barTintColor =  UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))
        
        let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
        let imageTitleView = UIImageView(frame: CGRect(
            x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
            y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
            width: gv.getConfigValue("navigationBarImgWidth") as! Int,
            height: gv.getConfigValue("navigationBarImgHeight") as! Int))
        
        imageTitleView.contentMode = .ScaleAspectFit
        imageTitleView.image = imageTitleItem
        self.navigationItem.titleView = imageTitleView
        
        self.addRightNavItemOnView()
        self.addLeftNavItemOnView()
        
    }
    func addLeftNavItemOnView()
    {
        //Back
        let buttonMenu = UIButton(type: UIButtonType.Custom) as UIButton
        buttonMenu.frame = CGRectMake(
            gv.getConfigValue("navigationItemBackImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemBackImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemBackImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemBackImgHeight") as! CGFloat)
        
        buttonMenu.setImage(UIImage(named: gv.getConfigValue("navigationItemBackImgName") as! String), forState: UIControlState.Normal)
        buttonMenu.addTarget(self, action: "backToPreviousPage:", forControlEvents: UIControlEvents.TouchUpInside) //use thiss
        let leftBarButtonItemMenu = UIBarButtonItem(customView: buttonMenu)
        
        //Flight
        let buttonFlight = UIButton(type: UIButtonType.Custom) as UIButton
        buttonFlight.frame = CGRectMake(
            gv.getConfigValue("navigationItemAirplainImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgHeight") as! CGFloat)
        buttonFlight.setImage(UIImage(named: gv.getConfigValue("navigationItemAirplainImgName") as! String), forState: UIControlState.Normal)
        buttonFlight.addTarget(self, action: "navItemFlightClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButtonItemFilght = UIBarButtonItem(customView: buttonFlight)
        
        
        // add multiple right bar button items
        self.navigationItem.setLeftBarButtonItems([leftBarButtonItemMenu,leftBarButtonItemFilght], animated: true)
        // uncomment to add single right bar button item
        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
        
    }
    func addRightNavItemOnView()
    {
        //Call
        let buttonCall = UIButton(type: UIButtonType.Custom) as UIButton
        buttonCall.frame = CGRectMake(
            gv.getConfigValue("navigationItemCallImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgHeight") as! CGFloat)
        
        buttonCall.setImage(UIImage(named: gv.getConfigValue("navigationItemCallImgName") as! String), forState: UIControlState.Normal)
        buttonCall.addTarget(self, action: "navItemCallClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemCall = UIBarButtonItem(customView: buttonCall)
        
        //Cart
        let buttonCart = UIButton(type: UIButtonType.Custom) as UIButton
        buttonCart.frame = CGRectMake(
            gv.getConfigValue("navigationItemCartImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgHeight") as! CGFloat)
        
        buttonCart.setImage(UIImage(named: gv.getConfigValue("navigationItemCartImgName") as! String), forState: UIControlState.Normal)
        buttonCart.addTarget(self, action: "navItemCartClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemCart = UIBarButtonItem(customView: buttonCart)
        
        //Search
        let buttonSearch = UIButton(type: UIButtonType.Custom) as UIButton
        buttonSearch.frame = CGRectMake(
            gv.getConfigValue("navigationItemSearchImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgHeight") as! CGFloat)
        buttonSearch.setImage(UIImage(named: gv.getConfigValue("navigationItemSearchImgName") as! String), forState: UIControlState.Normal)
        buttonSearch.addTarget(self, action: "navItemSearchClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemSearch = UIBarButtonItem(customView: buttonSearch)
        
        
        
        // add multiple right bar button items
        self.navigationItem.setRightBarButtonItems([rightBarButtonItemSearch,rightBarButtonItemCart,rightBarButtonItemCall], animated: true)
        
        // uncomment to add single right bar button item
        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
    }
    
    //Navigation Bar
    func backToPreviousPage(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func navItemFlightClick(sender:UIButton!)
    {
        self.removeNavigateView()
        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
        flightViewController.showInView(self.view, animated: true)
    }
    
    func navItemCallClick(sender:UIButton!)
    {
        self.removeNavigateView()
        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
        callAssistanceViewController.showInView(self.view, animated: true)
        
    }
    
    func navItemCartClick(sender:UIButton!)
    {
        print("navItemCartClick")
        let cartViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CartViewController") as? CartViewController
        self.navigationController?.pushViewController(cartViewController!, animated: true)
        
    }
    
    func navItemSearchClick(sender:UIButton!)
    {
        print("navItemSearchClick")
        let searchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
        let modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.FormSheet
        searchViewController?.modalPresentationStyle = modalStyle
        self.presentViewController(searchViewController!, animated: true, completion: nil)
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

}
