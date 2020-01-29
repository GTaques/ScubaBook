//
//  Singleton.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 28/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation

class Singleton {
    
    static var shared: Singleton = Singleton()
    
    private init() {
    }
    
    var dives: [DiveCard] = [
    DiveCard( durationTime: "54", maxDepth: "12", diveType: .Scuba, diveDate: Date(), diveNumber: 1, diveSite: "Three Rocks"),
    DiveCard( durationTime: "59", maxDepth: "12", diveType: .Scuba, diveDate: Date(), diveNumber: 2, diveSite: "White Rocks"),
    DiveCard(durationTime: "50", maxDepth: "19", diveType: .Scuba, diveDate: Date(), diveNumber: 3, diveSite: "Three Rocks"),
    DiveCard( durationTime: "34", maxDepth: "22", diveType: .Scuba, diveDate: Date(), diveNumber: 4, diveSite: "Shark Island"),
    DiveCard(durationTime: "45", maxDepth: "18", diveType: .Scuba, diveDate: Date(), diveNumber: 5, diveSite: "Red Reef"),
    ]
}
