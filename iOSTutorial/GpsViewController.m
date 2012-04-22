//
//  GpsViewController.m
//  iOSTutorial
//
//  Created by Alejandro Pérez García on 21/04/12.
//  Copyright (c) 2012 Autentia. All rights reserved.
//

#import "GpsViewController.h"

@interface GpsViewController ()

@end

@implementation GpsViewController
@synthesize gpsCoordinatesLbl = _gpsCoordinatesLbl;
@synthesize gpsOldCoordinatesLbl = _gpsOldCoordinatesLbl;
@synthesize gpsInitialCoordinatesLbl = _gpsInitialCoordinatesLbl;
@synthesize totalCounterLbl = _totalCounterLbl;
@synthesize bestCounterLbl = _bestCounterLbl;
@synthesize mapView = _mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    bestLocation = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(0, 0)
                                                 altitude:0
                                       horizontalAccuracy:kCLLocationAccuracyThreeKilometers
                                         verticalAccuracy:0
                                                timestamp:0];
    totalCounter = 0;
    bestCounter = 0;

    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;

    [locationManager startUpdatingLocation];

    _gpsInitialCoordinatesLbl.text = [locationManager.location description];
    NSLog(@"Posición inicial: %@", locationManager.location);
}

- (void)viewDidUnload {
    [locationManager stopUpdatingLocation];

    locationManager = nil;
    bestLocation = nil;
    [self setGpsCoordinatesLbl:nil];
    [self setGpsOldCoordinatesLbl:nil];
    [self setGpsInitialCoordinatesLbl:nil];
    [self setTotalCounterLbl:nil];
    [self setBestCounterLbl:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    totalCounter++;
    if (newLocation.horizontalAccuracy < 0) return;
    if (-[newLocation.timestamp timeIntervalSinceNow] > 5.0) return;

    if (newLocation.horizontalAccuracy <= bestLocation.horizontalAccuracy) {
        _gpsOldCoordinatesLbl.text = [bestLocation description];
        _gpsCoordinatesLbl.text = [newLocation description];
        NSLog(@"Mejor posición anterior: %@   Mejor posición actual: %@", bestLocation, newLocation);

        bestLocation = newLocation;
        bestCounter++;

        if (newLocation.horizontalAccuracy <= kCLLocationAccuracyNearestTenMeters) {
            [locationManager stopUpdatingLocation];
            _gpsCoordinatesLbl.backgroundColor = [UIColor greenColor];

            [self createBestLocationAnnotation];
        }
    }
    _totalCounterLbl.text = [NSString stringWithFormat:@"%d", totalCounter];
    _bestCounterLbl.text = [NSString stringWithFormat:@"%d", bestCounter];
}

- (void)createBestLocationAnnotation {
    MKPointAnnotation *currentLocationPin = [[MKPointAnnotation alloc] init];
    currentLocationPin.coordinate = bestLocation.coordinate;
    currentLocationPin.title = NSLocalizedString(@"Actual position", @"Actual position");
    currentLocationPin.subtitle = NSLocalizedString(@"Yeah!", @"Yeah!";);
    [_mapView addAnnotation:currentLocationPin];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    _gpsCoordinatesLbl.text = [manager.location description];
    NSLog(@"Error en el servicio de localización: %@", error);
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *pin = [mapView dequeueReusableAnnotationViewWithIdentifier:@"currentLocation"];
    if (pin == nil) {
        MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentLocation"];
        pinAnnotationView.annotation = annotation;
        pinAnnotationView.pinColor = MKPinAnnotationColorGreen;
        pinAnnotationView.animatesDrop = TRUE;
        pinAnnotationView.canShowCallout = TRUE;
        pin = pinAnnotationView;
    }
    return pin;
}

@end
