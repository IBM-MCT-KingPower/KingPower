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
    @IBOutlet weak var addToCartPopupView: AddToCartView!
    var setupNav = KPNavigationBar()
    //var buttonCart = UIButton()
    var btnRelatedProduct = UIButton()
    var btnRecommendedProduct = UIButton()
    var isRelated = true
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    var productDetail:ProductModel = ProductModel()
    var productArray:[ProductModel] = []
    var productImgArray:[UIImage] = []
    var database:FMDatabase!
    
    var commonViewController = CommonViewController()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    let detailTransitioningDelegate: PresentationManager = PresentationManager()
    
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

        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        let userId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentUserId") as! String))
        var picknowFlag = "Y"
        if pickNow.on {
            picknowFlag = "Y"
        }else{
            picknowFlag = "N"
        }
        let currentLocation = prefs.objectForKey(gv.getConfigValue("currentLocation") as! String) as! String
        print("Current Location \(currentLocation)")
        CartController().insert(userId, cart_cust_id: custId, cart_prod_id: productDetail.prod_id, cart_quantity: Int32(self.amount.text!)!, cart_pickup_now: picknowFlag, cart_current_location: currentLocation)
        
        // Animation add to cart
        let btnAddToCart = sender as! UIButton
        let startPoint = btnAddToCart.center
        let endPoint = setupNav.getButtonCart().center//buttonCart.center
        
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
        pathAnimation.duration=0.8;
        pathAnimation.delegate=self;
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(startPoint.x, btnAddToCart.frame.origin.y))
        path.addQuadCurveToPoint(CGPoint(x: endPoint.x + 12, y: endPoint.y + 10), controlPoint: CGPoint(x:630, y:5))
        pathAnimation.path = path.CGPath
        
        // apply transform animation
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform")
        let transform : CATransform3D = CATransform3DMakeScale(0.25, 0.25, 0.25 ) //0.25, 0.25, 0.25);
        
        animation.setValue(NSValue(CATransform3D: transform), forKey: "transform")
        animation.duration = 1.5
        
        cartCountView.layer.addAnimation(pathAnimation, forKey: "curveAnimation")
        cartCountView.layer.addAnimation(animation, forKey: "transform")
        
        
        
        UIView.animateWithDuration(2, animations: {
            cartCountView.alpha = 0
            cartCountView.transform = CGAffineTransformMakeScale(0.7, 0.7)
            self.setupNav.addAmountInCart(Int(self.amount.text!)!)
            }, completion: {
                finished in
                cartCountView.removeFromSuperview()
                
        })
        // Add to cart popup
        addToCartPopupView.imgProduct.image = UIImage(named: productDetail.prod_imageArray[0].proi_image_path)
        addToCartPopupView.txtProductName.text = productDetail.prod_name
        addToCartPopupView.txtProductName.font = UIFont(name: "Century Gothic", size: 12)
        addToCartPopupView.lblQuantity.text = "\(self.amount.text!)"
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // do your task
            dispatch_async(dispatch_get_main_queue()) {
                UIView.animateWithDuration(2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.addToCartPopupView.alpha = 1.0 }, completion: nil)
                UIView.animateWithDuration(1, delay: 3.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.addToCartPopupView.alpha = 0.0 }, completion: nil)
                
                
            }
        }

        
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
            detailTransitioningDelegate.height = 500
            detailTransitioningDelegate.width = 600
            viewController.transitioningDelegate = detailTransitioningDelegate
            viewController.modalPresentationStyle = .Custom
            viewController.netTotal = NSDecimalNumber(double: self.productDetail.prod_price)
            
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

    
    func setSelected(isRelated: Bool, index: Int) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProductDetailViewController") as! ProductDetailViewController
        if isRelated {
            vc.productDetail = self.relatedProdArray[index]
        }else{
            vc.productDetail = self.recommendedProdArray[index]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
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
