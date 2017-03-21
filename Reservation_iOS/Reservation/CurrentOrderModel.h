//
//  CurrentOrderModel.h
//  Reservation
//
//  Created by Wai Man Chan on 4/6/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CurrentOrderModel : NSObject {
    UITabBarController *tabBar;
}
+ (CurrentOrderModel *)shareModel;
@property (readonly) CLBeacon *beacon;
@property (readonly) Boolean found;
@property (readonly) NSNumber *restaurantNumber;
@property (readonly) NSNumber *tableNumber;
@end
