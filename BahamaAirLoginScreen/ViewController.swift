//
//  ViewController.swift
//  BahamaAirLoginScreen
//
//  Created by Travis Gillespie on 12/14/15.
//  Copyright © 2015 Travis Gillespie. All rights reserved.
//

import UIKit
import QuartzCore

// A delay function
func delay(seconds seconds: Double, completion:()->()){
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var summaryIcon: UIImageView!
    @IBOutlet weak var summary: UILabel!
    
    @IBOutlet weak var flightNr: UILabel!
    @IBOutlet weak var gateNr: UILabel!
    @IBOutlet weak var departingFrom: UILabel!
    @IBOutlet weak var arrivingTo: UILabel!
    @IBOutlet weak var planeImage: UIImageView!
    
    @IBOutlet weak var flightStatus: UILabel!
    @IBOutlet weak var flightBanner: UIImageView!
    
    var snowView: SnowView!
    
    // MARK view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust ui
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height/2
        
        //add the snow effect layer
        snowView = SnowView(frame: CGRect(x: -150, y: -100, width: 300, height: 50))
        let snowClipView = UIView(frame: CGRectOffset(view.frame, 0, 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        changeFlightDataTo(austinToParis)
    }
    
    //MARK: custom methods
    func changeFlightDataTo(data: FlightData,
        animated: Bool = false){
            
            // populate the UI with the next flight's data
            summary.text = data.summary
            flightNr.text = data.flightNr
            gateNr.text = data.gateNr
            departingFrom.text = data.departingFrom
            arrivingTo.text = data.arrivingTo
            flightStatus.text = data.flightStatus
            
            if animated {
                fadeImageView(bgImageView,
                    toImage: UIImage(named: data.weatherImageName)!,
                    showEffects: data.showWeatherEffects)
            } else {
                bgImageView.image = UIImage(named: data.weatherImageName)
                snowView.hidden = !data.showWeatherEffects
            }
            
            // schedule next flight
            delay(seconds: 3.0) {
                self.changeFlightDataTo(data.isTakingOff ?
                    parisToRome: austinToParis, animated: true)
            }
    }
    
    
    func fadeImageView(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
        
        UIView.transitionWithView(imageView, duration: 1.0,
            options: .TransitionCrossDissolve, animations: {
                imageView.image = toImage
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.snowView.alpha = showEffects ? 1.0 : 0.0
            }, completion: nil)
    }
}