//
//  ContentView.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 27/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var showingModal: Bool = false
    
//    let dives: [DiveCard] = [
//    DiveCard( durationTime: "54:00", maxDepth: "12.00 m", diveType: .Scuba, diveDate: Date(), diveNumber: 1, diveSite: "Three Rocks"),
//    DiveCard( durationTime: "59:00", maxDepth: "12.00 m", diveType: .Scuba, diveDate: Date(), diveNumber: 2, diveSite: "White Rocks"),
//    DiveCard(durationTime: "50:00", maxDepth: "19.00 m", diveType: .Scuba, diveDate: Date(), diveNumber: 3, diveSite: "Three Rocks"),
//    DiveCard( durationTime: "34:00", maxDepth: "22.00 m", diveType: .Scuba, diveDate: Date(), diveNumber: 4, diveSite: "Shark Island"),
//    DiveCard(durationTime: "45:00", maxDepth: "18.00 m", diveType: .Scuba, diveDate: Date(), diveNumber: 5, diveSite: "Red Reef"),
//    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(Singleton.shared.dives.reversed()) { dive in
                    NavigationLink(destination: DiveDetailView(dive: DiveCardView(durationTime: dive.durationTime, maxDepth: dive.maxDepth, diveType: dive.diveType, diveDate: dive.diveDate, diveNumber: dive.diveNumber, diveSite: dive.diveSite, images: dive.images))) {
                        DiveCardView(durationTime: dive.durationTime, maxDepth: dive.maxDepth, diveType: dive.diveType, diveDate: dive.diveDate, diveNumber: dive.diveNumber, diveSite: dive.diveSite, images: dive.images)
                    }
                }
            }.padding(.horizontal)
            .navigationBarTitle(Text("Dive Book"))
            .navigationBarItems(trailing: Button(action: {
                print("Button Pressed!")
                self.showingModal = true
            }) {
                Image(systemName: "plus").imageScale(.large)
            }.sheet(isPresented: self.$showingModal) {
                DiveCreateView(health: .meh, sourceType: .library)
            })
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
