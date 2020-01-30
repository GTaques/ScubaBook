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
