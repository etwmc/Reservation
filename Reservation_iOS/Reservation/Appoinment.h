//
//  Appoinment.h
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appoinment : NSObject
@property (readonly) NSDate *startDate;
@property (readonly) NSTimeInterval *duration;
#warning - Not Include in real program
@property (readonly) NSString *restaurantName;
+ (Appoinment *)testCase;
@end
