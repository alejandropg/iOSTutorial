//
//  GpsViewController.h
//  iOSTutorial
//
//  Created by Alejandro Pérez García on 21/04/12.
//  Copyright (c) 2012 Autentia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface GpsViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
@private
    CLLocationManager *locationManager;
    CLLocation *bestLocation;
    NSUInteger totalCounter;
    NSUInteger bestCounter;
}
@property (strong, nonatomic) IBOutlet UILabel *gpsCoordinatesLbl;
@property (strong, nonatomic) IBOutlet UILabel *gpsOldCoordinatesLbl;
@property (strong, nonatomic) IBOutlet UILabel *gpsInitialCoordinatesLbl;
@property (strong, nonatomic) IBOutlet UILabel *totalCounterLbl;
@property (strong, nonatomic) IBOutlet UILabel *bestCounterLbl;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
