//
//  ViewController.swift
//  ReturnKeyDemo
//
//  Created by Nimble Chapps on 09/01/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var txtReturn: UITextField!
    let button = UIButton(type: UIButtonType.Custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle("Return", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 163, 106, 53)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: "Done:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    func keyboardWillShow(note : NSNotification) -> Void{
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.button.hidden = false
            let keyBoardWindow = UIApplication.sharedApplication().windows.last
            self.button.frame = CGRectMake(0, (keyBoardWindow?.frame.size.height)!-53, 106, 53)
            keyBoardWindow?.addSubview(self.button)
            keyBoardWindow?.bringSubviewToFront(self.button)
            
            UIView.animateWithDuration(((note.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.doubleValue)!, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                
                self.view.frame = CGRectOffset(self.view.frame, 0, 0)
                }, completion: { (complete) -> Void in
                    print("Complete")
            })
        }
        
    }
    
    func Done(sender : UIButton){
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.txtReturn.resignFirstResponder()
            
        }
    }


}

