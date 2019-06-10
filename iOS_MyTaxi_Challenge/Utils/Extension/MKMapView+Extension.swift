//
//  MKMapView+Extension.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/10/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

extension MKMapView {
    var northWestCoordinate: CLLocationCoordinate2D {
        print("northWestCoordinate : \(MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.minY).coordinate)")
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.minY).coordinate
    }
    
    var northEastCoordinate: CLLocationCoordinate2D {
        print("northEastCoordinate : \(MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.minY).coordinate)")
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.minY).coordinate
    }
    
    var southEastCoordinate: CLLocationCoordinate2D {
        print("southEastCoordinate : \(MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.maxY).coordinate)")
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.maxY).coordinate
    }
    
    var southWestCoordinate: CLLocationCoordinate2D {
        print("southWestCoordinate : \(MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.maxY).coordinate)")
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.maxY).coordinate
    }
}
