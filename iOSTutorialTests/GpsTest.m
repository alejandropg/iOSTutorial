//
//  iOSTutorial
//
//  Created by alex on 20/04/12.
//  Copyright (c) 2012 Autentia. All rights reserved.
//

#import "GpsTest.h"

@implementation GpsTest {

}

- (void)testDeviceHasLocationServices {
    STAssertTrue([CLLocationManager locationServicesEnabled], nil);
}

- (void)testDeviceSupportsSignificantLocationChanges_soSupportsChangesInCellularCell {
    STAssertTrue([CLLocationManager significantLocationChangeMonitoringAvailable], nil);
}

- (void)testGetLocation {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];

    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;

    [locationManager startUpdatingLocation];

    NSLog(@"Posición actual: %@", locationManager.location);

    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"Posición anterior: %@   Posición actual: %@", oldLocation, newLocation);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error en el servicio de localización: %@", error);
}

@end
