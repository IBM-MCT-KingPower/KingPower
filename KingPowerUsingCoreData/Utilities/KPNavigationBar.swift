//
//  NavigationBar.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/4/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class KPNavigationBar: NSObject{
    
    var gv = GlobalVariable()
    var buttonCart:UIButton!
    var lblCartCount:UILabel!
    var isCalledFromMenu = false
    func setupNavigationBar(uiView: UIViewController){
        var navBar:UINavigationBar=UINavigationBar()
        print(uiView)
        //Default
        addKPLogo(uiView, navBar: navBar)
        
        if(uiView.isKindOfClass(LoginMethodViewController)){
            addSignOutItem(uiView, navBar: navBar, isEdge: true)
        }else if(uiView.isKindOfClass(LoginByTypeViewController)){
            addSignOutItem(uiView, navBar: navBar, isEdge: true)
            addBackItem(uiView, navBar: navBar, isEdge: true)
        }else if(uiView.isKindOfClass(LoginDetailViewController)){
            addSignOutItem(uiView, navBar: navBar, isEdge: true)
            addBackItem(uiView, navBar: navBar, isEdge: true)
        }else if(uiView.isKindOfClass(WelcomeViewController)){
            addBackItem(uiView, navBar: navBar, isEdge: true)
        }else if(uiView.isKindOfClass(CartViewController)){
            if isCalledFromMenu {
                addHamburgerItem(uiView, navBar: navBar, isEdge: true)
                addFlightItem(uiView, navBar: navBar, isEdge: false)
                addSearchItem(uiView, navBar: navBar, isEdge: true)
                addCartItem(uiView, navBar: navBar, isEdge: false)
                addCallAssistItem(uiView, navBar: navBar, isEdge: false)
            }else{
                addBackItem(uiView, navBar: navBar, isEdge: true)
                addFlightItem(uiView, navBar: navBar, isEdge: false)
                addSearchItem(uiView, navBar: navBar, isEdge: true)
                addCartItem(uiView, navBar: navBar, isEdge: false)
                addCallAssistItem(uiView, navBar: navBar, isEdge: false)
            }
        }else if(uiView.isKindOfClass(CheckoutViewController)){
            addBackItem(uiView, navBar: navBar, isEdge: true)
            addFlightItem(uiView, navBar: navBar, isEdge: false)
            addSearchItem(uiView, navBar: navBar, isEdge: true)
            addCartItem(uiView, navBar: navBar, isEdge: false)
            addCallAssistItem(uiView, navBar: navBar, isEdge: false)
        }else if(uiView.isKindOfClass(FlightInfoViewController)){
            addBackItem(uiView, navBar: navBar, isEdge: true)
            addFlightItem(uiView, navBar: navBar, isEdge: false)
            addSearchItem(uiView, navBar: navBar, isEdge: true)
            addCartItem(uiView, navBar: navBar, isEdge: false)
            addCallAssistItem(uiView, navBar: navBar, isEdge: false)
        }else if(uiView.isKindOfClass(ThankyouViewController)){
            addHamburgerItem(uiView, navBar: navBar, isEdge: true)
            addCallAssistItem(uiView, navBar: navBar, isEdge: true)
        }else if(uiView.isKindOfClass(PromotionDetailViewController)){
            addBackItem(uiView, navBar: navBar, isEdge: true)
            addFlightItem(uiView, navBar: navBar, isEdge: false)
            addSearchItem(uiView, navBar: navBar, isEdge: true)
            addCartItem(uiView, navBar: navBar, isEdge: false)
            addCallAssistItem(uiView, navBar: navBar, isEdge: false)
        }else if(uiView.isKindOfClass(ProductDetailViewController)){
            addBackItem(uiView, navBar: navBar, isEdge: true)
            addFlightItem(uiView, navBar: navBar, isEdge: false)
            addSearchItem(uiView, navBar: navBar, isEdge: true)
            addCartItem(uiView, navBar: navBar, isEdge: false)
            addCallAssistItem(uiView, navBar: navBar, isEdge: false)
        }else if(uiView.isKindOfClass(OrderDetailViewController)){
            addBackItem(uiView, navBar: navBar, isEdge: true)
            addFlightItem(uiView, navBar: navBar, isEdge: false)
            addSearchItem(uiView, navBar: navBar, isEdge: true)
            addCartItem(uiView, navBar: navBar, isEdge: false)
            addCallAssistItem(uiView, navBar: navBar, isEdge: false)
        }else{
            addHamburgerItem(uiView, navBar: navBar, isEdge: true)
            addFlightItem(uiView, navBar: navBar, isEdge: false)
            addSearchItem(uiView, navBar: navBar, isEdge: true)
            addCartItem(uiView, navBar: navBar, isEdge: false)
            addCallAssistItem(uiView, navBar: navBar, isEdge: false)
        }
        
        uiView.navigationItem.hidesBackButton = true
        
    }
    
    func addKPLogo(uiView: UIViewController, navBar: UINavigationBar){
        //Container Layout
        navBar.frame=CGRectMake(0, 0, uiView.navigationController!.navigationBar.frame.width, uiView.navigationController!.navigationBar.frame.height)
        navBar.barTintColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))//UIColor(hexString: "000000")
        uiView.view.addSubview(navBar)
        uiView.view.sendSubviewToBack(navBar)
        
        //Navigation Bar
        uiView.navigationController!.navigationBar.barTintColor =  UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))
        
        let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
        let imageTitleView = UIImageView(frame: CGRect(
            x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
            y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
            width: gv.getConfigValue("navigationBarImgWidth") as! Int,
            height: gv.getConfigValue("navigationBarImgHeight") as! Int))
        
        imageTitleView.contentMode = .ScaleAspectFit
        imageTitleView.image = imageTitleItem
        uiView.navigationItem.titleView = imageTitleView
        
    }
    
    func addCartItem(uiView: UIViewController, navBar: UINavigationBar, isEdge: Bool){ //Right Item
        //Cart
        buttonCart = UIButton(type: UIButtonType.Custom) as UIButton
        buttonCart.frame = CGRectMake(
            gv.getConfigValue("navigationItemCartImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgHeight") as! CGFloat)
        
        buttonCart.setImage(UIImage(named: gv.getConfigValue("navigationItemCartImgName") as! String), forState: UIControlState.Normal)
        buttonCart.addTarget(uiView, action: "viewCartMethod", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemCart = UIBarButtonItem(customView: buttonCart)
        
        
        // add multiple right bar button items
        if(isEdge){
            uiView.navigationItem.setRightBarButtonItems([rightBarButtonItemCart], animated: true)
        }else{
            uiView.navigationItem.rightBarButtonItems?.append(rightBarButtonItemCart)
        }
        var circleView:UIView = UIView(frame: CGRectMake(20,-3, 20, 20))
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true
        circleView.backgroundColor = UIColor.redColor()
        
        lblCartCount = UILabel(frame: CGRectMake(0, 0, 20, 20))
        lblCartCount.font = UIFont.boldSystemFontOfSize(12)
        lblCartCount.textAlignment = .Center;
        setAmountInCart()
        //lblCartCount.font = UIFont(name: "Century Gothic", size: 18)
        lblCartCount.textColor = UIColor.whiteColor()
        circleView.addSubview(lblCartCount)
        //cartCountView.addSubview(circleView)
        //let cur:UIWindow? = UIApplication.sharedApplication().keyWindow
        //cur?.addSubview(circleView)
        buttonCart.addSubview(circleView)
        
        //        var result = KPVariable.addAmountInCart(4)
        //        KPVariable.addAmountInCart(6)
        //        print("Navigate \(KPVariable.getAmountInCart())")
    }
    
    func addCallAssistItem(uiView: UIViewController, navBar: UINavigationBar, isEdge: Bool){ //Right Item
        //Call
        let buttonCall = UIButton(type: UIButtonType.Custom) as UIButton
        buttonCall.frame = CGRectMake(
            gv.getConfigValue("navigationItemCallImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgHeight") as! CGFloat)
        
        buttonCall.setImage(UIImage(named: gv.getConfigValue("navigationItemCallImgName") as! String), forState: UIControlState.Normal)
        buttonCall.addTarget(uiView, action: "callAssistMethod", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemCall = UIBarButtonItem(customView: buttonCall)
        
        if(isEdge){
            uiView.navigationItem.setRightBarButtonItems([rightBarButtonItemCall], animated: true)
        }else{
            uiView.navigationItem.rightBarButtonItems?.append(rightBarButtonItemCall)
        }
        
    }
    
    func addSearchItem(uiView: UIViewController, navBar: UINavigationBar, isEdge: Bool){ //Right Item
        //Search
        let buttonSearch = UIButton(type: UIButtonType.Custom) as UIButton
        buttonSearch.frame = CGRectMake(
            gv.getConfigValue("navigationItemSearchImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgHeight") as! CGFloat)
        buttonSearch.setImage(UIImage(named: gv.getConfigValue("navigationItemSearchImgName") as! String), forState: UIControlState.Normal)
        buttonSearch.addTarget(uiView, action: "searchMethod", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemSearch = UIBarButtonItem(customView: buttonSearch)
        
        if(isEdge){
            uiView .navigationItem.setRightBarButtonItems([rightBarButtonItemSearch], animated: true)
        }else{
            uiView.navigationItem.rightBarButtonItems?.append(rightBarButtonItemSearch)
        }
        
    }
    
    func addSignOutItem(uiView: UIViewController, navBar: UINavigationBar, isEdge: Bool){ //Right Item
        let buttonSignout: UIButton = UIButton(type: UIButtonType.Custom)
        buttonSignout.frame = CGRect(
            x: gv.getConfigValue("navigationItemSignoutImgPositionX") as! CGFloat,
            y: gv.getConfigValue("navigationItemSignoutImgPositionY") as! CGFloat,
            width:  gv.getConfigValue("navigationItemSignoutImgWidth") as! CGFloat,
            height: gv.getConfigValue("navigationItemSignoutImgHeight") as! CGFloat)
        
        buttonSignout.setImage(UIImage(named: gv.getConfigValue("navigationItemSignoutImgName") as! String), forState: UIControlState.Normal)
        buttonSignout.addTarget(uiView, action: "SignoutMethod", forControlEvents: UIControlEvents.TouchUpInside)
        var rightBarButtonItemSignout: UIBarButtonItem = UIBarButtonItem(customView: buttonSignout)
        
        if(isEdge){
            uiView.navigationItem.setRightBarButtonItems([rightBarButtonItemSignout], animated: true)
        }else{
            uiView.navigationItem.rightBarButtonItems?.append(rightBarButtonItemSignout)
        }
        
    }
    
    func addHamburgerItem(uiView: UIViewController, navBar: UINavigationBar, isEdge: Bool){ //Left Item
        //Menu
        let buttonMenu = UIButton(type: UIButtonType.Custom) as UIButton
        buttonMenu.frame = CGRectMake(
            gv.getConfigValue("navigationItemHamburgerImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemHamburgerImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemHamburgerImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemHamburgerImgHeight") as! CGFloat)
        
        
        buttonMenu.setImage(UIImage(named: gv.getConfigValue("navigationItemHamburgerImgName") as! String), forState: UIControlState.Normal)
        buttonMenu.addTarget(uiView.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside) //use thiss
        let leftBarButtonItemMenu = UIBarButtonItem(customView: buttonMenu)
        
        if uiView.revealViewController() != nil {
            uiView.view.addGestureRecognizer(uiView.revealViewController().panGestureRecognizer())
            //btnMenu2.target = self.langRevealViewController()
            //btnMenu2.action = "langRevealToggle:"
            // Uncomment to change the width of menu
            //self.revealViewController().rearViewRevealWidth = 62
        }
        
        if(isEdge){
            uiView.navigationItem.setLeftBarButtonItems([leftBarButtonItemMenu], animated: true)
        }else{
            uiView.navigationItem.leftBarButtonItems?.append(leftBarButtonItemMenu)
        }
        
        
    }
    
    func addFlightItem(uiView: UIViewController, navBar: UINavigationBar, isEdge: Bool){ //Left Item
        //Flight
        let buttonFlight = UIButton(type: UIButtonType.Custom) as UIButton
        buttonFlight.frame = CGRectMake(
            gv.getConfigValue("navigationItemAirplainImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgHeight") as! CGFloat)
        buttonFlight.setImage(UIImage(named: gv.getConfigValue("navigationItemAirplainImgName") as! String), forState: UIControlState.Normal)
        buttonFlight.addTarget(uiView, action: "viewFlightMethod", forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButtonItemFilght = UIBarButtonItem(customView: buttonFlight)
        
        if(isEdge){
            uiView.navigationItem.setLeftBarButtonItems([leftBarButtonItemFilght], animated: true)
        }else{
            uiView.navigationItem.leftBarButtonItems?.append(leftBarButtonItemFilght)
        }
    }
    
    func addBackItem(uiView: UIViewController, navBar: UINavigationBar, isEdge: Bool){ //Left Item
        let buttonBack : UIButton = UIButton(type: UIButtonType.Custom)
        buttonBack.frame = CGRect(
            x: gv.getConfigValue("navigationItemBackImgPositionX") as! CGFloat,
            y: gv.getConfigValue("navigationItemBackImgPositionY") as! CGFloat,
            width:  gv.getConfigValue("navigationItemBackImgWidth") as! CGFloat,
            height: gv.getConfigValue("navigationItemBackImgHeight") as! CGFloat)
        
        buttonBack.setImage(UIImage(named: gv.getConfigValue("navigationItemBackImgName") as! String), forState: UIControlState.Normal)
        buttonBack.addTarget(uiView, action: "BackMethod", forControlEvents: UIControlEvents.TouchUpInside)
        var leftBarButtonItemBack : UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
        
        if(isEdge){
            uiView.navigationItem.setLeftBarButtonItems([leftBarButtonItemBack], animated: true)
        }else{
            uiView.navigationItem.leftBarButtonItems?.append(leftBarButtonItemBack)
        }
        
        
        
    }
    
    func getButtonCart() -> UIButton {
        return buttonCart
    }
    
    func addAmountInCart(b: Int) -> Int {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let amount: Int = Int(prefs.integerForKey(gv.getConfigValue("currentAmountInCart") as! String))
        let totalAmount = b + amount
        lblCartCount.text = "\(totalAmount)"
        prefs.setInteger(totalAmount, forKey: gv.getConfigValue("currentAmountInCart") as! String)
        prefs.synchronize()
        return totalAmount
        
    }
    
    func setAmountInCart() -> Int {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let amount: Int = Int(prefs.integerForKey(gv.getConfigValue("currentAmountInCart") as! String))
        print("Amount \(amount)")
        lblCartCount.text = "\(amount)"
        return amount
    }
    
    
    
    
}