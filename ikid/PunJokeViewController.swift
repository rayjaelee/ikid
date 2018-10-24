//
//  PunJokeViewController.swift
//  ikid
//
//  Created by Raymond Lee on 10/23/18.
//  Copyright © 2018 rayjaelee. All rights reserved.
//

import UIKit

class PunJokeViewController: UIViewController {
    
    fileprivate var punQuestionViewController : PunQuestionViewController!
    fileprivate var punAnswerViewController : PunAnswerViewController!
    @IBOutlet weak var btnFlip: UIButton!

    fileprivate func questionBuilder() {
        if punQuestionViewController == nil {
            punQuestionViewController = (storyboard?.instantiateViewController(withIdentifier: "PQuestion") as! PunQuestionViewController)
        }
    }
    
    fileprivate func answerBuilder() {
        if punAnswerViewController == nil {
            punAnswerViewController = (storyboard?.instantiateViewController(withIdentifier: "PAnswer") as! PunAnswerViewController)
        }
    }
    
    @IBAction func btnPunFlip(_ sender: Any) {
        questionBuilder()
        answerBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        if punQuestionViewController != nil && punQuestionViewController?.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            punAnswerViewController.view.frame = view.frame
            btnFlip.setTitle("Back", for: UIControl.State.normal)
            switchViewController(punQuestionViewController, to: punAnswerViewController)
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            punQuestionViewController.view.frame = view.frame
            btnFlip.setTitle("What she say?", for: UIControl.State.normal)
            switchViewController(punAnswerViewController, to: punQuestionViewController)
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
        switchViewController(nil, to: punQuestionViewController)
    }

}
