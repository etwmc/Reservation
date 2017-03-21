//
//  Restaurant.h
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Restaurant : NSObject
- (id)initWithID:(long long)restaurantID;
/*
 * General Information of the Restaurant
 */
@property (readonly) long long sid;
@property (readonly) NSString *name;
@property (readonly) NSString *phoneNumber;
@property (readonly) NSString *address;
@property (readonly) NSDate *openHour;
@property (readonly) NSDate *closeHour;
@property (readonly) NSTimeInterval durationPerMeal;
@property (readonly) BOOL currentlyAvailable;

@property (readonly) UIImage  *restaurantLogo;
@property (readonly) NSArray *listOfPicture;

+ (Restaurant *)testCase;
@end
