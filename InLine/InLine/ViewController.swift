//
//  ViewController.swift
//  InLine
//
//  Created by Emmett Shaughnessy on 3/30/19.
//  Copyright © 2019 Emmett Shaughnessy. All rights reserved.
//

import UIKit
//import MapKit
//import CoreLocation


class ViewController: UIViewController {

    //when using maps, change to:
    //class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate
    
    
    //MARK: Variable Setup
    var YourQueuePosition = Double()
    var currentQueuePosition = Double()
//    let locationManager = CLLocationManager()
    var timeSetup1 = 1
    var timeSetup2 = 2
    var integer1 = Int(1)
    var decimal1 = Int(1)
    var timer = Timer()
    var secondsForTimer = 1
    var hours = Int(1)
    var minuets = Int(1)
    
    var NewCalcHours = Int(1)
    var NewCalcMinutes = Int(1)
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          //Show and Update Map
//        LocationUpdate()
//        mapView.showsUserLocation = true
//        mapView.setUserTrackingMode(.follow, animated: true)
        
        //Setup On-Screen Text
        queueNumber.text = "\(Int(YourQueuePosition))"
        //currentQueue.text = "Now: \(Int(currentQueuePosition))"
        print (YourQueuePosition)
        
        //Show On-Screen Text
        NEWfindQueueTime()
        secondsForTimer = (NewCalcHours * 3600) + (NewCalcMinutes * 60)
        timeRemaining.text = "\(NewCalcHours) hours and \(NewCalcMinutes-1) minutes"
        
        //Setup Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.TimerActions), userInfo: nil, repeats: true)
    }
    
    
    
    
    
    
    
    //MARK: Action for Timer
    @objc func TimerActions(){
        secondsForTimer -= 1
        print (NewCalcHours)
        print (NewCalcHours * 3600)
        print ("hello \(Int(secondsForTimer))")
        
     
        let HoursForTimer = Int(secondsForTimer/3600)
        let convertHoursToMinutes = HoursForTimer*60
        let MinutesForTimer = Int((secondsForTimer/60)-convertHoursToMinutes)
        
        if HoursForTimer < 1 && HoursForTimer > 0 || HoursForTimer == 1{
            timeRemaining.text = "\(HoursForTimer) hour and \(MinutesForTimer) minutes"
        } else if HoursForTimer == 0{
            timeRemaining.text = "\(HoursForTimer) hours and \(MinutesForTimer) minutes"
        }else {
            timeRemaining.text = "\(HoursForTimer) hours and \(MinutesForTimer) minutes"
        }
        
        //Checking for completed timer
        if (secondsForTimer == 0){
            timer.invalidate()
            timeRemaining.text = "Your Up In Line!"
        }
    }
    
    
    
    //MARK: Setup Main Functions
    //Calculate Queue Time
    func findQueueTime() {
        
        if queueNumber.text == nil || queueNumber.text == "0"{
            YourQueuePosition = 2
        }
        if currentQueue.text == nil{
            currentQueuePosition = 1
        }
        
        let currentNumber:Double = Double(currentQueuePosition)
        let queue:Double = Double(YourQueuePosition)
        let queue2 = Int(queue-currentNumber)
        timeSetup1 = Int(queue2 * 1)
        timeSetup2 = Int(timeSetup1 * 1)
        let totalTimeInHours = timeSetup2
        
        hours = Int(totalTimeInHours/60)
        minuets = Int(totalTimeInHours%60)
    
    }
    
    func NEWfindQueueTime() {
        if queueNumber.text == nil || queueNumber.text == "0"{
            YourQueuePosition = 2
        }
        if currentQueue.text == nil{
            currentQueuePosition = 1
        }
        
        let currentNumber:Double = Double(currentQueuePosition)
        let queue:Double = Double(YourQueuePosition)
        let queue2 = queue-currentNumber
        let timeCalc = Int(queue2*17.5)
        
        NewCalcHours = Int(timeCalc/60)
        NewCalcMinutes = Int(timeCalc)
        
    }
    
    
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        timer.invalidate()
    }
    
    
    
    
    //MARK: UI Setup
    @IBOutlet weak var queueNumber: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var currentQueue: UILabel!
//    @IBOutlet weak var mapView: MKMapView!
    
    //    //Setup the Maps
    //    func LocationUpdate(){
    //        self.locationManager.requestAlwaysAuthorization()
    //        // For use in foreground
    //        self.locationManager.requestWhenInUseAuthorization()
    //
    //        if CLLocationManager.locationServicesEnabled() {
    //            locationManager.delegate = self
    //            locationManager.desiredAccuracy = kCLLocationAccuracyBest
    //            locationManager.startUpdatingLocation()
    //        }
    //
    //        mapView.delegate = self
    //        mapView.mapType = .standard
    //        mapView.isZoomEnabled = true
    //        mapView.isScrollEnabled = true
    //
    //        if let coor = mapView.userLocation.location?.coordinate{
    //            mapView.setCenter(coor, animated: true)
    //        }
    //    }
    
}
