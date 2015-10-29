//
//  popupViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/26/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

protocol sendSortFilterDelegate {
    func sendAllFilter(prodcatIndex:NSMutableArray, brandIndexList:NSMutableArray, genderIndex:Int, priceRangeIndex:Int,  colorIndexList:NSMutableArray)
    func setSorting(sortIndex : Int)
    
}
class popupViewController: UIViewController, sortDelegate, filterDetailDelegate {
    var delegate:sendSortFilterDelegate?
    @IBOutlet weak var sortSegment: UIView!
    @IBOutlet weak var filterSegment: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var btnClearAll: UIButton!
    
    var filterDetailSubCat:[ProductCategoryModel] = []
    var filterDetailBrand:[BrandModel] = []
    
    var filterSubCatIndex:NSMutableArray = NSMutableArray()
    var filterBrandIndex:NSMutableArray = NSMutableArray()
    var filterGenderIndex:Int = -1
    var filterPriceRangeIndex:Int = -1
    var filterColorIndex:NSMutableArray = NSMutableArray()
    
    var segment:Int = 0
    var sortingIndex:Int = 0
    
    var filterVC:filterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (segment==0){
            btnClearAll.hidden = true
            sortSegment.hidden = false
            filterSegment.hidden = true
            segmentedControl.selectedSegmentIndex = segment
        }
        else{
            btnClearAll.hidden = false
            sortSegment.hidden = true
            filterSegment.hidden = false
            segmentedControl.selectedSegmentIndex = segment
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyPopup(sender: AnyObject) {
        //if (segment==0){
        delegate?.sendAllFilter(filterSubCatIndex, brandIndexList: filterBrandIndex, genderIndex: filterGenderIndex, priceRangeIndex: filterPriceRangeIndex, colorIndexList: filterColorIndex)
        delegate?.setSorting(self.sortingIndex)
        //}else{
        
            
        //}
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func indexChange(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            btnClearAll.hidden = true
            sortSegment.hidden = false
            filterSegment.hidden = true
        case 1:
            btnClearAll.hidden = false
            sortSegment.hidden = true
            filterSegment.hidden = false
        default:
            break;
        }
    }
    
    func setSorting(sortIndex : Int){
        self.sortingIndex = sortIndex
        print(sortIndex)
    }
    
    func addSubcatList (prodCatIndex: NSMutableArray) {
        print("FilterViewController : Add Subcat \(prodCatIndex)")
        filterSubCatIndex = prodCatIndex
        
    }
    func addBrandList (brandIndexList:NSMutableArray){
        filterBrandIndex = brandIndexList
    }
    func addGender (genderIndex:Int){
        filterGenderIndex = genderIndex
    }
    func addPriceRange (rangeIndex:Int){
        filterPriceRangeIndex = rangeIndex
    }
    func addColorList (colorIndexList:NSMutableArray){
        filterColorIndex = colorIndexList
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "sortSegue") {
            (segue.destinationViewController as! sortViewController).markRow = self.sortingIndex
            (segue.destinationViewController as! sortViewController).delegate = self
        }else if (segue.identifier == "filterSegue") {
            print("filter segue")
            filterVC = segue.destinationViewController as! filterViewController
            filterVC.filterSubCatIndex = filterSubCatIndex
            filterVC.filterBrandIndex = filterBrandIndex
            filterVC.filterGenderIndex = filterGenderIndex
            filterVC.filterPriceRangeIndex = filterPriceRangeIndex
            filterVC.filterColorIndex = filterColorIndex
            filterVC.filterDetailSubCat = filterDetailSubCat
            filterVC.filterDetailBrand = filterDetailBrand
            filterVC.delegate = self
            
        }else if (segue.identifier == "applySegue") {
            print("apply segue")
        }
    }
    
    @IBAction func clearAllFilter(sender:AnyObject) {
        delegate?.sendAllFilter(NSMutableArray(), brandIndexList: NSMutableArray(), genderIndex: -1, priceRangeIndex: -1, colorIndexList: NSMutableArray())
        self.dismissViewControllerAnimated(true, completion: nil)
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
