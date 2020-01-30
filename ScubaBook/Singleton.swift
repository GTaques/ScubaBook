//
//  Singleton.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 28/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Singleton {
    
    static var shared: Singleton = Singleton()
    
    private init() {
    }
    
    var dives: [DiveCard] = [
        DiveCard(
            durationTime: "54",
            maxDepth: "12",
            diveType: .Scuba,
            diveDate: Date(),
            diveNumber: 1,
            diveSite: "Three Rocks",
            images: [
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!)
            ],
            locations: [MKPointAnnotation.example]),
        DiveCard(
            durationTime: "59",
            maxDepth: "12",
            diveType: .Scuba,
            diveDate: Date(),
            diveNumber: 2,
            diveSite: "White Rocks",
            images: [
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!)
            ],
            locations: [MKPointAnnotation.example]),
        DiveCard(
            durationTime: "50",
            maxDepth: "19",
            diveType: .Scuba,
            diveDate: Date(),
            diveNumber: 3,
            diveSite: "Three Rocks",
            images: [
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "dive")!)
            ],
            locations: [MKPointAnnotation.example]),
        DiveCard(
            durationTime: "34",
            maxDepth: "22",
            diveType: .Scuba,
            diveDate: Date(),
            diveNumber: 4,
            diveSite: "Shark Island",
            images: [
                ChosenImage(id: UUID(), imageName: UIImage(named: "color_meh")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "color_happy")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "color_sad")!)
            ],
            locations: [MKPointAnnotation.example]),
        DiveCard(
            durationTime: "45",
            maxDepth: "18",
            diveType: .Scuba,
            diveDate: Date(),
            diveNumber: 5,
            diveSite: "Red Reef",
            images: [
                ChosenImage(id: UUID(), imageName: UIImage(named: "color_meh")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "color_happy")!),
                ChosenImage(id: UUID(), imageName: UIImage(named: "color_sad")!)
            ],
            locations: [MKPointAnnotation.example]),
    ]
}
