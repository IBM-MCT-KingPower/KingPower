//
//  PresentationManager.swift
//  PresentationTutorial
//
//  Created by Sztanyi Szabolcs on 17/11/14.
//  Copyright (c) 2014 Sztanyi Szabolcs. All rights reserved.
//

import UIKit

class filterdetailManager: NSObject, UIViewControllerTransitioningDelegate {
    var width:CGFloat = 600
    var height:CGFloat = 500

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
        let presentationController = filterDetailPresentationController(presentedViewController: presented, presentingViewController: source)
        presentationController.height = height
        presentationController.width = width
        return presentationController;
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionFilterPresentationAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionDismissAnimator()
    }
}