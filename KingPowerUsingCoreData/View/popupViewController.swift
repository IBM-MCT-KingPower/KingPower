//
//  popupViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/26/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

protocol sortDataDelegate{
    func setSorting(sortIndex : Int)
}

class popupViewController: UIViewController, sortViewDelegate {
    var delegate:sortDataDelegate?
    @IBOutlet weak var sortSegment: UIView!
    @IBOutlet weak var filterSegment: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var segment:Int = 0
    var sortingIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (segment==0){
            sortSegment.hidden = false
            filterSegment.hidden = true
            segmentedControl.selectedSegmentIndex = segment
        }
        else{
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
        delegate?.setSorting(self.sortingIndex)
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "sortSegue") {
            (segue.destinationViewController as! sortViewController).markRow = self.sortingIndex
            (segue.destinationViewController as! sortViewController).delegate = self
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
