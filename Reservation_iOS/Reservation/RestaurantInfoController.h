//
//  RestaurantInfoController.h
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"

typedef enum {
    RestaurantGeneralInfo,
    RestaurantMenu,
    RestaurantComment,
    RestaurantPhoto
} restaurantInfoType;

@interface RestaurantInfoController : NSObject <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (readwrite) Restaurant *restaurant;
@property (readwrite) restaurantInfoType infoType;
@property (readonly) UIView *infoView;
@end
