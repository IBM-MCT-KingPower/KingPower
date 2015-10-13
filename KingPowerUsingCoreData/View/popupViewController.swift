//
//  popupViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/26/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

protocol filterDelegate {
    func sendAllFilter(prodcatIndex:Int, brandIndexList:NSMutableArray, genderIndex:Int, priceRangeIndex:Int,  colorIndex:NSMutableArray)
    //func sendCatList(catList:[ProductCategoryModel])
    
}
class popupViewController: UIViewController, sortDelegate, filterDetailDelegate {
    var sDelegate:sortDelegate?
    var fDelegate:filterDelegate?
    @IBOutlet weak var sortSegment: UIView!
    @IBOutlet weak var filterSegment: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var filterSubCatIndex:Int = -1
    var filterBrandIndex:NSMutableArray = NSMutableArray()
    var filterGenderIndex:Int = -1
    var filterPriceRangeIndex:Int = -1
    var filterColorIndex:NSMutableArray = NSMutableArray()
    
    var segment:Int = 0
    var sortingIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (segment==0){
            //btnApply.hidden = true
            sortSegment.hidden = false
            filterSegment.hidden = true
            segmentedControl.selectedSegmentIndex = segment
        }
        else{
            //btnApply.hidden = false
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
        if (segment==0){
            sDelegate?.setSorting(self.sortingIndex)
        }else{
            fDelegate?.sendAllFilter(filterSubCatIndex, brandIndexList: filterBrandIndex, genderIndex: filterGenderIndex, priceRangeIndex: filterPriceRangeIndex, colorIndex: filterColorIndex)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func indexChange(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            sortSegment.hidden = false
            filterSegment.hidden = true
        case 1:
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
    
    func addSubcat(prodCatIndex: Int) {
        print("FilterViewController : Add Subcat")
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
    func addColor (colorIndexList:NSMutableArray){
        filterColorIndex = colorIndexList
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "sortSegue") {
            (segue.destinationViewController as! sortViewController).markRow = self.sortingIndex
            (segue.destinationViewController as! sortViewController).delegate = self
        }else if (segue.identifier == "filterSegue") {
            print("filter segue")
            (segue.destinationViewController as! filterViewController).delegate = self
            
        }else if (segue.identifier == "applySegue") {
            print("apply segue")
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
