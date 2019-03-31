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

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    var YourQueuePosition = Double()
    var currentQueuePosition = Double()
    let locationManager = CLLocationManager()
    var timer = 1
    var timeToDoIt = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationUpdate()
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        queueNumber.text = String(YourQueuePosition)
        currentQueue.text = String(currentQueuePosition)
        print (YourQueuePosition)
//        button = dropDownButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        button.setTitle("Location", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(button)
//        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        
        findQueueTime()
        timeRemaining.text = "\(hours) hours and \(minuets) minutes"
        
        let timeer = hours * 3600
        
//        Timer.scheduledTimer(timeInterval: timeer, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        runTimer()
    }
    
    
    var seconds1 = 60
    var timerTime = Timer()
    var isTimerRunning = false
    
    func timeString(time:TimeInterval) -> String {
        let hourstime = Int(time) / 3600
        let minutestime = Int(time) / 60 % 60
        let secondstime = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hourstime, minutestime, secondstime)
    }
    func runTimer() {
        timerTime = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        seconds1 -= 1     //This will decrement(count down)the seconds.
        timeRemaining.text = "\(hours) hours and \(minuets) minutes"
    }
    
    
    
    @objc func timeToMoveOn() {
        print("Hello. Time is up!")
        timer = 0
    }

    
//    var button = dropDownButton()
    
    var timeSetup1 = 1
    var timeSetup2 = 2
    var hours = Double(1)
    var minuets = Double(1)
    var integer1 = Double(1)
    var decimal1 = Double(1)
    var seconds:Double = 1
    
    func LocationUpdate(){
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
    }
    
    
    
    @IBOutlet weak var queueNumber: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var currentQueue: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    func findQueueTime() {
        
        let currentNumber:Double = Double(currentQueuePosition)
        let queue:Double = Double(YourQueuePosition)
        let queue2 = Int(queue-currentNumber)
        print (queue2)
        timeSetup1 = Int(queue2 * 1)
        print (timeSetup1)
        timeSetup2 = Int(timeSetup1 * 1)
        let totalTimeInHours = timeSetup2
        print (totalTimeInHours)
        let hoursPt1 = Double(totalTimeInHours/60)
        print (hoursPt1)
        hours = hoursPt1.rounded(.down)
        print (hours)

        minuets = Double(totalTimeInHours%60)
        seconds = hours * 3600
    }

    
    
    
    
//    class dropDownButton: UIButton {
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//
//            self.backgroundColor = UIColor.darkGray
//
//        }
//
//        class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
//            func numberOfSections(in tableView: UITableView) -> Int {
//                return 1
//            }
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//    }
    
    
}

public extension FloatingPoint {
    public var whole: Self { return modf(self).0 }
    public var fraction: Self { return modf(self).1 }
}

//origfinality
//3 minuets
//theme
//elegence
//completeness
//presentation
//potential for success; long term impact
