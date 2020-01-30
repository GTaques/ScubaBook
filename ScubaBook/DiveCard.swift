//
//  Dive.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 28/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import UIKit
import MapKit


struct DiveCard: Identifiable {
        var id = UUID()
        var durationTime, maxDepth: String
        var diveType: DiveType
        var diveDate: Date
        var diveNumber: Int
        var diveSite: String
        var images: [ChosenImage]
        var locations: [MKPointAnnotation]
}
