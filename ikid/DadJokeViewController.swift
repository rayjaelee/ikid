//
//  ViewController.swift
//  ikid
//
//  Created by Raymond Lee on 10/23/18.
//  Copyright © 2018 rayjaelee. All rights reserved.
//

import UIKit

class DadJokeViewController: UIViewController {
    
    fileprivate var dadQuestionViewController : DadQuestionViewController!
    fileprivate var dadAnswerViewController : DadAnswerViewController!
    @IBOutlet weak var btnSwitch: UIButton!
    
    fileprivate func questionBuilder() {
        if dadQuestionViewController == nil {
            dadQuestionViewController = (storyboard?.instantiateViewController(withIdentifier: "DQuestion") as! DadQuestionViewController)
        }
    }
    
    fileprivate func answerBuilder() {
        if dadAnswerViewController == nil {
            dadAnswerViewController = (storyboard?.instantiateViewController(withIdentifier: "DAnswer") as! DadAnswerViewController)
        }
    }
    
    @IBAction func btnFlip(_ sender: Any) {
        questionBuilder()
        answerBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        if dadQuestionViewController != nil && dadQuestionViewController?.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            dadAnswerViewController.view.frame = view.frame
            btnSwitch.setTitle("Back", for: UIControl.State.normal)
            switchViewController(dadQuestionViewController, to: dadAnswerViewController)
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            dadQuestionViewController.view.frame = view.frame
            btnSwitch.setTitle("What she say?", for: UIControl.State.normal)
            switchViewController(dadAnswerViewController, to: dadQuestionViewController)
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
        switchViewController(nil, to: dadQuestionViewController)
    }

}

