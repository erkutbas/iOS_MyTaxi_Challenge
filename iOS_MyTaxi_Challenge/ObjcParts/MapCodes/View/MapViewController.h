//
//  MapViewController.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

#define METERS_PER_MILE 1609.344

@interface MapViewController : UIViewController <MKMapViewDelegate>{
    MKMapView *mapView;
}

@property (strong, nonatomic) IBOutlet MKMapView *_mapView;

@end

NS_ASSUME_NONNULL_END
