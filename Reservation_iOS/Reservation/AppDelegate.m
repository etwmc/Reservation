//
//  AppDelegate.m
//  Reservation
//
//  Created by CHAN, Wai Man on 18/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "AppDelegate.h"
#import "Restaurant.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate () <CLLocationManagerDelegate> {
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    CLLocationManager *manager = [CLLocationManager new];
    [manager requestWhenInUseAuthorization];
    ((UIWindow *)application.windows[0]).tintColor = [UIColor colorWithRed:29/255.0 green:163/255.0 blue:116/255.0 alpha:1.0];
    return YES;
}
+(void)gcovFlush{
    extern void __gcov_flush(void);
    __gcov_flush();
    NSLog(@"%s - GCOV FLUSH!", __PRETTY_FUNCTION__);
}
@end
