//
//  ViewController.swift
//  InLine
//
//  Created by Emmett Shaughnessy on 3/30/19.
//  Copyright © 2019 Emmett Shaughnessy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation


class ViewController: UIViewController {

    //when using maps, change to:
    //class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate
    
    
    //MARK: Variable Setup
    var YourQueuePosition = Double()
    var currentQueuePosition = Double()
    let locationManager = CLLocationManager()
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
    var averageTime_Int = Int(7)
    var averageTime_Double = Double(7)
    var LocationApproved = UserDefaults.standard.set(0, forKey: "approved")
    
    @IBOutlet weak var tipsWithInLine: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        averageTime_Int = Int.random(in: 4...6)
        averageTime_Double = Double(averageTime_Int)
        
        
        timer.invalidate()
        let tipNumber = Int.random(in: 1...3)
        randomFactsWithInline(with: tipNumber)
        
        //Setup On-Screen Text
        queueNumber.text = "\(Int(YourQueuePosition))"
        //currentQueue.text = "Now: \(Int(currentQueuePosition))"
        print (YourQueuePosition)
        
        //Show On-Screen Text
        NEWfindQueueTime()
        secondsForTimer = (NewCalcMinutes * 60)
        timeRemaining.text = "0 hours and 0 minutes"
        
        //Setup Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.TimerActions), userInfo: nil, repeats: true)
    }
    
    
    
    
    
    
    
    //MARK: Action for Timer
    @objc func TimerActions(){
        secondsForTimer -= 1
//        print ("Begin Hours: \(NewCalcHours)")
//        print ("Hours: \(NewCalcHours * 3600)")
        print ("Minutes: \(NewCalcMinutes * 60)")
        print ("Seconds: \(Int(secondsForTimer))")
        
     
        let HoursForTimer = Double(secondsForTimer/3600)
        var MinutesForTimer = Int(HoursForTimer.truncatingRemainder(dividingBy: 60))
        let MinutesForTimer_seconds = Int(secondsForTimer/60)
        
        if HoursForTimer == 0 || HoursForTimer < 0{
            MinutesForTimer = MinutesForTimer_seconds
            timeRemaining.text = "0 hours and \(MinutesForTimer) minutes"
        } else if HoursForTimer > 0 {
            MinutesForTimer = Int(HoursForTimer.truncatingRemainder(dividingBy: 60))
            if HoursForTimer < 1 && HoursForTimer > 0 || HoursForTimer == 1{
                timeRemaining.text = "\(Int(HoursForTimer)) hour and \(MinutesForTimer) minutes"
            }else {
                timeRemaining.text = "\(Int(HoursForTimer)) hours and \(MinutesForTimer) minutes"
            }
        }
        
        
        print ("HoursForTimer: \(HoursForTimer)")
        print ("MinutesForTimer: \(MinutesForTimer)")
        
        
        //Checking for completed timer
        if (secondsForTimer == 0){
            timer.invalidate()
            timeRemaining.text = "Your Up In Line!"
            timeUpNotification()
        }
        if HoursForTimer == 0 && MinutesForTimer == 0{
            timer.invalidate()
            timeRemaining.text = "Your Up In Line!"
            timeUpNotification()
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
        let timeCalc = Int(queue2*averageTime_Double)
        
        NewCalcHours = Int(timeCalc/60)
        NewCalcMinutes = Int(timeCalc)
        
    }
    
    
    func timeUpNotification() {
        
        let alertController = UIAlertController(title: "Time's Up!", message: "According to our estimations, you should be up in line", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func showInMaps(_ sender: Any) {
        let LocationApprovedNumber = UserDefaults.standard.integer(forKey: "approved")
        getUsersLocation()
        ReadyToMapAlert()
    }
    
    
    func getUsersLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func openInMaps() {
        let latitude:CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
        let longitude:CLLocationDegrees =  (locationManager.location?.coordinate.longitude)!
        
        let regionDistance:CLLocationDistance = 5500
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Your location"
        mapItem.openInMaps(launchOptions: options)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    func ReadyToMapAlert(){
        
        let alertController = UIAlertController(title: "Approved for Mapping", message: "You have been authorized to view maps", preferredStyle: .alert)
        let mapAction = UIAlertAction(title: "Map It", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            self.openInMaps()
        }
        
        alertController.addAction(mapAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func randomFactsWithInline(with random: Int) {
        if random == 1{
            tipsWithInLine.text = "Tips with InLine:\n\n1. The time is only based on data points. It may vary up to 30 minutes\n\n2. Check with the front desk before leaving the building just to ensure you won't be late"
        } else if random == 2{
            tipsWithInLine.text = "Fun Fact:\n\nThe highest wait time in the dmv was recorded at over 4 hours!"
        }else if random == 3{
            tipsWithInLine.text = "Fun Fact:\n\nThe DMV was first created in California in 1915"
        }
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
