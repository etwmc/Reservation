//
//  RestaurantBasicInfoViewController.h
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "Appoinment.h"

@interface RestaurantBasicInfoViewController : NSObject  <UIAlertViewDelegate>
@property (readwrite) Appoinment *appoinment;
@property (readwrite) Restaurant *restaurant;
@property IBOutlet UILabel *titleTextView;
@property IBOutlet UILabel *phoneNumView;
@property IBOutlet UILabel *addrNumView;
@property IBOutlet UIImageView *logoView;
@property IBOutlet UIButton *reverseButton;
@property IBOutlet UIViewController *mainView;
- (IBAction)makeReservation:(id)sender;
@end
