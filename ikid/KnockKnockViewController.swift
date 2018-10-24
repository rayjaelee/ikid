//
//  KnockKnockViewController.swift
//  ikid
//
//  Created by Raymond Lee on 10/23/18.
//  Copyright © 2018 rayjaelee. All rights reserved.
//

import UIKit

class KnockKnockViewController: UIViewController {
    
    fileprivate var knockOneViewController : KnockOneViewController!
    fileprivate var knockTwoViewController : KnockTwoViewController!
    fileprivate var knockThreeViewController : KnockThreeViewController!
    @IBOutlet weak var btnKnock: UIButton!
    
    fileprivate func firstBuilder() {
        if knockOneViewController == nil {
            knockOneViewController = (storyboard?.instantiateViewController(withIdentifier: "KnockOne") as! KnockOneViewController)
        }
    }
    
    fileprivate func secondBuilder() {
        if knockTwoViewController == nil {
            knockTwoViewController = (storyboard?.instantiateViewController(withIdentifier: "KnockTwo") as! KnockTwoViewController)
        }
    }
    
    fileprivate func thirdBuilder() {
        if knockThreeViewController == nil {
            knockThreeViewController = (storyboard?.instantiateViewController(withIdentifier: "KnockThree") as! KnockThreeViewController)
        }
    }
    
    @IBAction func btnKnockFlip(_ sender: Any) {
        firstBuilder()
        secondBuilder()
        thirdBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        if knockOneViewController != nil && knockOneViewController?.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            knockTwoViewController.view.frame = view.frame
            btnKnock.setTitle("Hatch who?", for: UIControl.State.normal)
            
            switchViewController(knockOneViewController, to: knockTwoViewController)
        } else if knockTwoViewController != nil && knockTwoViewController?.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            knockThreeViewController.view.frame = view.frame
            btnKnock.setTitle("Back", for: UIControl.State.normal)
            
            switchViewController(knockTwoViewController, to: knockThreeViewController)
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            knockOneViewController.view.frame = view.frame
            btnKnock.setTitle("Who's there?", for: UIControl.State.normal)
            
            switchViewController(knockThreeViewController, to: knockOneViewController)
        }
    }
    
    fileprivate func switchViewController(_ from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMove(toParent: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParent()
        }
        
        if to != nil {
            self.addChild(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParent: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        firstBuilder()
        switchViewController(nil, to: knockOneViewController)
    }

}
