//
//  DiveCardView.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 27/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import MapKit

enum DiveType: String {
    case Scuba = "Scuba"
    case Freedive = "Freedive"
    case ExtendedRange = "Extended Range"
    case Rebreather = "Rebreather"
}

struct DiveCardView: View {
    var darkBlue = #colorLiteral(red: 0.04447454959, green: 0.06718366593, blue: 0.2595607936, alpha: 1)
    var lightBlue = #colorLiteral(red: 0, green: 0.3206735253, blue: 0.88473171, alpha: 1)
    var red = #colorLiteral(red: 1, green: 0, blue: 0.1310281456, alpha: 1)
    
    @State var durationTime: String
    @State var maxDepth: String
    @State var diveType: DiveType
    @State var diveDate: Date
    @State var diveNumber: Int
    @State var diveSite: String
    @State var images: [ChosenImage]
    @State var locations: [MKPointAnnotation]
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                LinearGradient(gradient: Gradient(colors: [Color(lightBlue), Color(darkBlue)]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                
                HStack {
                    if images.count > 0 {
                        Image(uiImage: images[0].imageName)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)
                            .frame(minWidth: 40, idealWidth: 60, maxWidth: 60, alignment: .bottom)
                            .rotationEffect(.degrees(-30))
                            .padding(.leading)
                    }
                    if images.count > 1 {
                        Image(uiImage: images[1].imageName)
                            .renderingMode(.original).resizable()
                            .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)
                            .frame(minWidth: 40, idealWidth: 65, maxWidth: 65, alignment: .bottom)
                            .padding(.leading, -10)
                            .padding(.top, -14)
                    }
                    if images.count > 2 {
                        Image(uiImage: images[2].imageName)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)
                            .frame(minWidth: 40, idealWidth: 60, maxWidth: 60, alignment: .bottom)
                            .rotationEffect(.degrees(30))
                            .padding(.leading, -10)
                    }
                    
                    Spacer()
                    VStack(alignment: .trailing, spacing: 10) {
                                Text("\(durationTime):00").foregroundColor(.white).fontWeight(.regular).font(.body)
                                Text("\(maxDepth).00 m").foregroundColor(.white).fontWeight(.regular).font(.body)
                                Text("Scuba").fontWeight(.bold).padding(.horizontal).background(Color.black).foregroundColor(.white).font(.body)
                    }.padding(.all)
                }
                
            }
            .cornerRadius(10)
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 50) {
                    Text("\(diveDate, formatter: dateFormatter)").foregroundColor(Color(red)).font(.caption)
                    Text("#\(diveNumber)").foregroundColor(Color(red)).font(.caption)
                }
                Text("\(diveSite)").font(.subheadline)
            }
        }
    }
}

struct DiveCardView_Previews: PreviewProvider {
    static var previews: some View {
        DiveCardView(durationTime: "54:00", maxDepth: "12.00 m", diveType: .Scuba, diveDate: Date(), diveNumber: 2, diveSite: "White Rocks", images: [ChosenImage()], locations: [MKPointAnnotation.example])
    }
}
