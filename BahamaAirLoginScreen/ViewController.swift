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
                
                let direction: AnimationDirection = data.isTakingOff ?
                    .Positive : .Negative
                
                cubeTransition(label: flightNr, text: data.flightNr,
                    direction: direction)
                cubeTransition(label: gateNr, text: data.gateNr,
                    direction: direction)
                
            } else {
                bgImageView.image = UIImage(named: data.weatherImageName)
                snowView.hidden = !data.showWeatherEffects
                
                flightNr.text = data.flightNr
                gateNr.text = data.gateNr
                
                departingFrom.text = data.departingFrom
                arrivingTo.text = data.arrivingTo
                
                flightStatus.text = data.flightStatus
                
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
    
    enum AnimationDirection: Int {
        case Positive = 1
        case Negative = -1
    }
    
    func cubeTransition(label label: UILabel, text: String, direction: AnimationDirection) {
        
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = label.backgroundColor
        
        let auxLabelOffset = CGFloat(direction.rawValue) *
            label.frame.size.height / 2
        
        auxLabel.transform = CGAffineTransformConcat(
            CGAffineTransformMakeScale(1.0, 0.1),
            CGAffineTransformMakeTranslation(0.0, auxLabelOffset))
        
        label.superview!.addSubview(auxLabel)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut,
            animations: {
                auxLabel.transform = CGAffineTransformIdentity
                label.transform = CGAffineTransformConcat(
                    CGAffineTransformMakeScale(1.0, 0.1),
                    CGAffineTransformMakeTranslation(0.0, -auxLabelOffset))
            }, completion: {_ in
                label.text = auxLabel.text
                label.transform = CGAffineTransformIdentity
                auxLabel.removeFromSuperview()
        })
    }
}