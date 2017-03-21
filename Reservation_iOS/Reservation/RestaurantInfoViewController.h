//
//  RestaurantInfoViewController.h
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "RestaurantBasicInfoViewController.h"

@interface RestaurantInfoViewController : UIViewController <UIScrollViewDelegate>
@property (readwrite) Restaurant *restaurant;
@property (readwrite) Appoinment *appoinment;
@property IBOutlet UIView *basicInfoView;
@property IBOutlet UIView *additionInfoView;
@property IBOutlet RestaurantBasicInfoViewController *basicInfoCon;
- (IBAction)modeChange:(id)sender;
@end
