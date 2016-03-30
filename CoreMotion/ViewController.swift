//
//  ViewController.swift
//  CoreMotion
//
//  Created by Nam (Nick) N. HUYNH on 3/30/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        
        if motion == UIEventSubtype.MotionShake {
            
            let controller = UIAlertController(title: "Shake", message: "The device is shaken", preferredStyle: UIAlertControllerStyle.Alert)
            controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(controller, animated: true, completion: nil)
            
        }
        
    }

}

