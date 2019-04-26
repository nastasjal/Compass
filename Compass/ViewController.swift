//
//  ViewController.swift
//  Compass
//
//  Created by Анастасия Латыш on 26/04/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

  


    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        let leftPadding = (self.mapView.frame.size.width - 300) / 2.0;
        let sourceLocation = CLLocationCoordinate2D(latitude: 55.82913635, longitude: 37.4932781)
        let destinationLocation = CLLocationCoordinate2D(latitude: 55.821744, longitude: 37.3404142)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Компасс"
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Красногорск"
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }

        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
      
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking

        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            
            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: leftPadding, left: leftPadding, bottom: leftPadding, right: leftPadding), animated: true)
           
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
}

