//
//  Appoinment.m
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "Appoinment.h"

@implementation Appoinment
@synthesize duration, startDate, restaurantName;
- (id)init {
    self = [super init];
    if (self) {
        duration = 3600;
        startDate = [NSDate date];
        restaurantName = @"Test";
    }
    return self;
}
+ (Appoinment *)testCase {
    static Appoinment *app = NULL;
    if (app == NULL) {
        app = [Appoinment new];
    }
    return app;
}
@end
