//
//  ProductDetailViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/23/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate , collectionDelegate {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var pickNow: UISwitch!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var productDescript: UITextView!
    @IBOutlet weak var itemControl: UIStepper!
    @IBOutlet weak var ratingControl: RatingControl!

    @IBOutlet weak var moreImageCollectionView: UICollectionView!
    @IBOutlet weak var relatedProductTableView: UITableView!
    @IBOutlet weak var tabView: UIView!
    var setupNav = KPNavigationBar()
    var buttonCart = UIButton()
    var btnRelatedProduct = UIButton()
    var btnRecommendedProduct = UIButton()
    var isRelated = true
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    var productDetail:ProductModel = ProductModel()
    var productArray:[ProductModel] = []
    var productImgArray:[UIImage] = []
    var database:FMDatabase!
    
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    var recommendedProdArray:[ProductModel] = []
    var relatedProdArray:[ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moreImageCollectionView.backgroundColor = UIColor.whiteColor()
        self.initialTabView()
        
        self.setupNav.setupNavigationBar(self)
        
        self.productIdLabel.text = self.productDetail.prod_code
        self.productNameLabel.text = self.productDetail.prod_name
        self.productImageLabel.image = UIImage(named: self.productDetail.prod_imageArray[0].proi_image_path)
        
        for path in self.productDetail.prod_imageArray {
            self.productImgArray.append(UIImage(named: path.proi_image_path)!)
        }
        self.moreImageCollectionView.reloadData()
        
        self.productPrice.text = NSNumber(double: self.productDetail.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
        self.productDescript.text = self.productDetail.prod_description
        self.productDescript.font = UIFont(name: "Century Gothic", size: 15)
        //self.pickNow.on = self.productDetail.pickup_flag
        self.ratingControl.rating = Int(self.productDetail.prod_rating)

        // recommend
        self.recommendedProdArray = ProductController().getProductRecommendByProdId(self.productDetail.prod_id)
        self.relatedProdArray = ProductController().getProductRelatedByProdId(self.productDetail.prod_id)
        self.relatedProductTableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
//        self.setupNavigationBar()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func itemChange(sender: AnyObject) {
        self.amount.text = Int(self.itemControl.value).description
    }
    
    @IBAction func addToCart(sender: AnyObject) {
        let btnAddToCart = sender as! UIButton
        let startPoint = btnAddToCart.center
        let endPoint = buttonCart.center
        
        let cartCountView:UIView = UIView(frame: CGRectMake(0, 0, 30, 30))
        let circleView:UIView = UIView(frame: CGRectMake(0,  0, 30, 30))
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true
        circleView.backgroundColor = UIColor.redColor()
        cartCountView.addSubview(circleView)
        let lblCartCount:UILabel = UILabel(frame: CGRectMake(10, 0, 30, 30))
        lblCartCount.text = self.amount.text
        lblCartCount.font = UIFont.boldSystemFontOfSize(16)
        //lblCartCount.font = UIFont(name: "Century Gothic", size: 18)
        lblCartCount.textColor = UIColor.whiteColor()
        circleView.addSubview(lblCartCount)
        let cur:UIWindow? = UIApplication.sharedApplication().keyWindow
        cur?.addSubview(cartCountView)
        
        
        let pathAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position");
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = false;
        pathAnimation.duration=1.0;
        pathAnimation.delegate=self;
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(startPoint.x, btnAddToCart.frame.origin.y))
        //print("\(pointTest.frame.origin.x), \(pointTest.frame.origin.y)")
        //path.addQuadCurveToPoint(CGPoint(x: endPoint.x + 12, y: endPoint.y + 2), controlPoint: CGPoint(x:760.0, y:125.0))
        path.addQuadCurveToPoint(CGPoint(x: endPoint.x + 12, y: endPoint.y + 2), controlPoint: CGPoint(x:630, y:50))
        pathAnimation.path = path.CGPath
        
        // apply transform animation
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform")
        let transform : CATransform3D = CATransform3DMakeScale(0.25, 0.25, 0.25 ) //0.25, 0.25, 0.25);
        
        animation.setValue(NSValue(CATransform3D: transform), forKey: "transform")
        animation.duration = 1.5
        
        cartCountView.layer.addAnimation(pathAnimation, forKey: "curveAnimation")
        cartCountView.layer.addAnimation(animation, forKey: "transform")
        /*
        let animation2 = CABasicAnimation(keyPath: "transform.scale")
        animation2.toValue = NSNumber(float: 0.5)
        animation2.duration = 1.5
        
        //animation2.
        //animation2.repeatCount = 1.0
        //animation2.autoreverses = false
        cartCountView.layer.addAnimation(animation2, forKey: nil)
*/
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDelegate(self)
       // UIView.setAnimationDelay(0.5)
        UIView.setAnimationDuration(1.0)
        UIView.setAnimationRepeatCount(1)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        cartCountView.transform = CGAffineTransformMakeScale(0.7, 0.7)
        UIView.commitAnimations()
        
    }
    @IBAction func currencyConvertorPopup(sender: AnyObject) {
        self.performSegueWithIdentifier("currencyConvertorSegue", sender: nil)
    }
    
    // MARK: - CollectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productImgArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("moreImageCell",
            forIndexPath: indexPath) as! MoreImageProductCollectionViewCell
        cell.imgProduct.image = self.productImgArray[indexPath.row]
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor(hexString: String(gv.getConfigValue("borderCollectionColor"))).CGColor
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.productImageLabel.image = self.productImgArray[indexPath.row]
    }

    func initialTabView(){
        let imgRelatedProduct = UIImage(named: "tab-Related1.png")
        btnRelatedProduct.frame = CGRectMake(0, 0, (imgRelatedProduct?.size.width)!/2, (imgRelatedProduct?.size.height)!/2)
        btnRelatedProduct.setImage(imgRelatedProduct, forState: .Normal)
        btnRelatedProduct.addTarget(self, action: "tappedRelated:", forControlEvents: UIControlEvents.TouchUpInside)
        self.tabView.addSubview(btnRelatedProduct)
        
        let imgRecommendedProduct = UIImage(named: "tab-Recommend0.png")
        
        btnRecommendedProduct.frame = CGRectMake((imgRelatedProduct?.size.width)!/2, 0, (imgRecommendedProduct?.size.width)!/2, (imgRecommendedProduct?.size.height)!/2)
        btnRecommendedProduct.setImage(imgRecommendedProduct, forState: .Normal)
        btnRecommendedProduct.addTarget(self, action: "tappedRecommended:", forControlEvents: UIControlEvents.TouchUpInside)
        self.tabView.addSubview(btnRecommendedProduct)
        
    }
    
    func tappedRelated(sender:UIButton!){
        print("tab related product")
        btnRelatedProduct.setImage(UIImage(named: "tab-Related1.png"), forState: UIControlState.Normal)
        btnRecommendedProduct.setImage(UIImage(named: "tab-Recommend0.png"), forState: UIControlState.Normal)
        self.isRelated = true
        self.relatedProductTableView.reloadData()
    }
    
    func tappedRecommended(sender:UIButton!){
        print("tab recommended product")
        btnRelatedProduct.setImage(UIImage(named: "tab-Related0.png"), forState: UIControlState.Normal)
        btnRecommendedProduct.setImage(UIImage(named: "tab-Recommend1.png"), forState: UIControlState.Normal)
        self.isRelated = false
        self.relatedProductTableView.reloadData()
    }

    // MARK: - TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CatagoryTableViewCell
        if isRelated {
            cell.clvRelated.hidden = false
            cell.prodRelated = self.relatedProdArray
            cell.delegate = self
            cell.clvRelated.reloadData()
            cell.clvRecommended.hidden = true
        } else {
            cell.clvRelated.hidden = true
            cell.prodRecommend = self.recommendedProdArray
            cell.clvRecommended.reloadData()
            cell.clvRecommended.hidden = false
        }
        return cell

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "currencyConvertorSegue"{
            let viewController:CurrencyConvertorPopupViewController = segue.destinationViewController as! CurrencyConvertorPopupViewController
            print("\(productPrice.text)")
            viewController.grandTotal = NSDecimalNumber(double: self.productDetail.prod_price)
            
        }
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
    
//    
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
//        buttonCart = UIButton(type: UIButtonType.Custom) as UIButton
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
    
    func setSelected(isRelated: Bool, index: Int) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProductDetailViewController") as! ProductDetailViewController
        if isRelated {
            vc.productDetail = self.relatedProdArray[index]
        }else{
            vc.productDetail = self.recommendedProdArray[index]
        }
        self.navigationController?.pushViewController(vc, animated: true)
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
