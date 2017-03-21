//
//  CurrentOrderModel.m
//  Reservation
//
//  Created by Wai Man Chan on 4/6/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "CurrentOrderModel.h"
#import "CurrentOrderTableViewController.h"
#import "ProjectConstant.h"

@interface CurrentOrderModel () <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *location;
    CurrentOrderTableViewController *orderController;
}


@end

extern UIViewController *rootController;



@implementation CurrentOrderModel
- (id)init {
    self = [super init];
    if (self) {
        _beacon = NULL;
        locationManager = [CLLocationManager new];
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:UUID] identifier:@"Restaurant"];
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;
        region.notifyEntryStateOnDisplay = YES;
        locationManager.delegate = self;
        [locationManager startMonitoringForRegion:region];
        [locationManager startRangingBeaconsInRegion:region];
        tabBar = (UITabBarController *)rootController.parentViewController;
        orderController = [[CurrentOrderTableViewController alloc] initWithNibName:@"CurrentOrderTableViewController" bundle:[NSBundle mainBundle]];
        orderController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Current Order" image:NULL tag:4];
        
    }
    return self;
}


- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    beacons = [beacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rssi.intValue > -60"]];
    if (beacons.count > 0) {
        [self willChangeValueForKey:@"beacon"];
        _beacon = NULL;
        for (CLBeacon *beacon in beacons) {
            if (_beacon) {
                if (_beacon.rssi < beacon.rssi) _beacon = beacon;
            }
            else _beacon = beacon;
        }
        [self didChangeValueForKey:@"beacon"];
        if (tabBar.viewControllers.count == 3) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:tabBar.viewControllers];
            [array addObject:orderController];
            tabBar.viewControllers= array;
        }
    } else {
        if (tabBar.selectedViewController == orderController) {
            NSString *message = [NSString stringWithFormat:@"You left table %d too far, so I can't order for you now. Please try put me near the table", self.tableNumber.intValue];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't order for you now. " message:message delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            tabBar.selectedIndex = 0;
        }
        NSMutableArray *array = [NSMutableArray arrayWithArray:tabBar.viewControllers];
        [array removeObject:orderController];
        tabBar.viewControllers= array;
        _beacon = NULL;
    }
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Can't look for your table", "Fail Beacon Region")
                                                                   message:NSLocalizedString(@"Something is wrong, I can't look for the iBeacon near your phone", "")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [tabBar presentViewController:alert animated:YES completion:nil];
}

+ (CurrentOrderModel *)shareModel {
    static CurrentOrderModel *model = NULL;
    if (model == NULL) model = [CurrentOrderModel new];
    return model;
}
- (Boolean)found { return (_beacon != NULL); }
- (NSNumber *)restaurantNumber { return _beacon.major; }
- (NSNumber *)tableNumber { return _beacon.minor; }


@end
