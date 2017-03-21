//
//  AppoinmentModel.h
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppoinmentModelDelegate <NSObject>
- (void)appoinmentModelUpdate;
@end

@interface AppoinmentModel : NSObject
@property (readwrite) NSObject <AppoinmentModelDelegate> *delegate;
@property (readonly) bool available;
@property (readonly) NSArray *appoinments;
- (void)refresh;
+ (AppoinmentModel *)shareModel;
@end
