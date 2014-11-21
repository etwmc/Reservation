//
//  AppoinmentModel.h
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppoinmentModel : NSObject
@property (readonly) NSArray *appoinments;
+ (AppoinmentModel *)shareModel;
@end
