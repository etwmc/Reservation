//
//  RestaurantBasicInfoViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import "RestaurantBasicInfoViewController.h"

@interface RestaurantBasicInfoViewController () {
    Restaurant *_rest;
}
@end

@implementation RestaurantBasicInfoViewController

- (void)setRestaurant:(Restaurant *)restaurant {
    _rest = restaurant;
    self.titleTextView.text = _rest.name;
    self.phoneNumView.text = [@"Phone Number: " stringByAppendingString:_rest.phoneNumber];
    self.addrNumView.text = [@"Address: " stringByAppendingString:_rest.address];
    self.logoView.image = _rest.restaurantLogo;
}
- (Restaurant *)restaurant { return _rest; }

@end
