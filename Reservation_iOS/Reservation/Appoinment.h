//
//  Appoinment.h
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"

@interface Appoinment : NSObject {
    UIAlertView *alert;
}
@property (readonly) long long appoinmentID;
@property (readonly) NSDate *startDate;
@property (readonly) NSTimeInterval duration;
@property (readonly) Restaurant *restaurant;
@property (readonly) unsigned short numberOfPerson;
+(void)appoinmentAtRestaurant:(Restaurant *)r atDate:(NSDate *)date withNumberOfPerson:(unsigned short) numberOfPerson success:(void (^)())successBlock failedBlock:(void (^)())failedBlock;
- (id)initWithDictionary:(NSDictionary *)dict;
- (void)cancel;
@end
