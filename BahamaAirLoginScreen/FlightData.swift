//
//  FlightData.swift
//  BahamaAirLoginScreen
//
//  Created by Travis Gillespie on 12/18/15.
//  Copyright © 2015 Travis Gillespie. All rights reserved.
//

import Foundation

// flight model


struct FlightData {
    let summary: String
    let flightNr: String
    let gateNr: String
    let departingFrom: String
    let arrivingTo: String
    let weatherImageName: String
    let showWeatherEffects: Bool
    let isTakingOff: Bool
    let flightStatus: String
}

// Pre- defined flights

let austinToParis = FlightData(
    summary: "01 Apr 2016 09:42",
    flightNr: "ZY 3014",
    gateNr: "T1 A33",
    departingFrom: "AUS",
    arrivingTo: "CDG",
    weatherImageName: "bg-snowy",
    showWeatherEffects: true,
    isTakingOff: true,
    flightStatus: "Boarding")

let parisToRome = FlightData(
    summary: "01 Apr 2016 17:05",
    flightNr: "AE 1107",
    gateNr: "045",
    departingFrom: "CDG",
    arrivingTo: "FCO",
    weatherImageName: "bg-sunny",
    showWeatherEffects: false,
    isTakingOff: false,
    flightStatus: "Delayed")