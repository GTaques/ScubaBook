//
//  DiveDetailView.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 28/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct DiveDetailView: View {
    
    @State var dive: DiveCardView
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarTitle(Text("\(dive.diveSite) #\(dive.diveNumber) "), displayMode: .inline)
    }
}

struct DiveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DiveDetailView(dive: DiveCardView(durationTime: "", maxDepth: "", diveType: .Scuba, diveDate: Date(), diveNumber: 0, diveSite: "", images: [], locations: []))
    }
}
