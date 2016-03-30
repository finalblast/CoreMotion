//
//  AppDelegate.swift
//  CoreMotion
//
//  Created by Nam (Nick) N. HUYNH on 3/30/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var altimeter = CMAltimeter()
    lazy var queue = NSOperationQueue()
    lazy var pedometer = CMPedometer()
    var motionManage = CMMotionManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if motionManage.gyroAvailable {
            
            println("Gyro is available")
            if motionManage.gyroActive == false {
                
                println("Gyro is not active")
                motionManage.gyroUpdateInterval = 1.0 / 40.0
                motionManage.startGyroUpdatesToQueue(queue, withHandler: { (data, error) -> Void in
                    
                    println("Gyro rotation x = \(data.rotationRate.x)")
                    println("Gyro rotation y = \(data.rotationRate.y)")
                    println("Gyro rotation z = \(data.rotationRate.z)")
                    
                })
                
            } else {
                
                println("Gyro is already active")
                
            }
            
        } else {
            
            println("Gyro is not available")
            
        }
        
        if motionManage.accelerometerAvailable {
            
            println("Accelerometer is available")
            if motionManage.accelerometerActive == false {
                
                println("Accelerometer is not active")
                motionManage.startAccelerometerUpdatesToQueue(queue, withHandler: { (data, error) -> Void in
                    
                    println("X = \(data.acceleration.x)")
                    println("Y = \(data.acceleration.y)")
                    println("Z = \(data.acceleration.z)")
                    
                })
                
            } else {
                
                println("Accelerometer is already active")
                
            }
            
        } else {
            
            println("Accelerometer is not available")
            
        }
        
        return true
    
    }

    func applicationWillResignActive(application: UIApplication) {
       
        altimeter.stopRelativeAltitudeUpdates()
        pedometer.stopPedometerUpdates()
        motionManage.stopAccelerometerUpdates()
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        if CMAltimeter.isRelativeAltitudeAvailable() {
            
            println("Altimeter is available")
            altimeter.startRelativeAltitudeUpdatesToQueue(queue, withHandler: { (data, error) -> Void in
                
                println("Relative altitude is \(data.relativeAltitude) meters.")
                
            })
            
        } else {
            
            println("Altimeter is not available")
            
        }
        
        if CMPedometer.isStepCountingAvailable() {
            
            println("Step counting is available")
            pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: { (data, error) -> Void in
                
                println("Step: \(data.numberOfSteps)")
                
            })
            
        } else {
            
            println("Step counting is not available")
            
        }
        
        if CMPedometer.isFloorCountingAvailable() {
            
            println("Floor counting is available")
            pedometer.queryPedometerDataFromDate(NSDate.tenMinuteAgo(), toDate: NSDate.now(), withHandler: { (data, error) -> Void in
                
                println("Floor ascended: \(data.floorsAscended)")
                println("Floor descended: \(data.floorsDescended)")
                
            })
            
        } else {
            
            println("Floor counting is not available")
            
        }
        
        if CMPedometer.isDistanceAvailable() {
            
            println("Distance is available")
            pedometer.queryPedometerDataFromDate(NSDate.yesterday(), toDate: NSDate.now(), withHandler: { (data, error) -> Void in
                
                println("Distance: \(data.distance)")
                
            })
            
        } else {
            
            println("Distance is not available")
            
        }
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension NSDate {
    
    class func now() -> NSDate {
        
        return NSDate()
        
    }
    
    class func yesterday() -> NSDate {
        
        return NSDate(timeIntervalSinceNow: -(24 * 60 * 60))
        
    }
    
    class func tenMinuteAgo() -> NSDate {
        
        return NSDate(timeIntervalSinceNow: -(10 * 60))
        
    }
    
}