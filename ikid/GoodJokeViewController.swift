//
//  GoodJokeViewController.swift
//  ikid
//
//  Created by Raymond Lee on 10/23/18.
//  Copyright © 2018 rayjaelee. All rights reserved.
//

import UIKit

class GoodJokeViewController: UIViewController {
    
    fileprivate var goodQuestionViewController : GoodQuestionViewController!
    fileprivate var goodAnswerviewController : GoodAnswerViewController!
    @IBOutlet weak var btnFlip: UIButton!
    
    fileprivate func questionBuilder() {
        if goodQuestionViewController == nil {
            goodQuestionViewController = (storyboard?.instantiateViewController(withIdentifier: "GQuestion") as! GoodQuestionViewController)
        }
    }
        
    fileprivate func answerBuilder() {
        if goodAnswerviewController == nil {
            goodAnswerviewController = (storyboard?.instantiateViewController(withIdentifier: "GAnswer") as! GoodAnswerViewController)
        }
    }
    
    @IBAction func btnFlip(_ sender: Any) {
        questionBuilder()
        answerBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        if goodQuestionViewController != nil && goodQuestionViewController?.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            goodAnswerviewController.view.frame = view.frame
            btnFlip.setTitle("Back", for: UIControl.State.normal)
            switchViewController(goodQuestionViewController, to: goodAnswerviewController)
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            goodQuestionViewController.view.frame = view.frame
            btnFlip.setTitle("What is it?", for: UIControl.State.normal)
            switchViewController(goodAnswerviewController, to: goodQuestionViewController)
        }
        
        UIView.commitAnimations()
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
        
        questionBuilder()
        switchViewController(nil, to: goodQuestionViewController)
    }

}
