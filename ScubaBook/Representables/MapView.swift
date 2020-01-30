//
//  MapView.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 30/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.addAnnotation(MapView.makeAnnotationOnMap(title: "London", subtitle: "lalal", latitude: 51.5, longitude: 0.13))
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        return Coordinator(self)
    }
    
    static func makeAnnotationOnMap(title: String, subtitle: String, latitude: Double, longitude: Double) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return annotation
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
}

extension MKPointAnnotation {
    
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
    
}
