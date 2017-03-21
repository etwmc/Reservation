//
//  RestaurantBasicInfoViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import "RestaurantBasicInfoViewController.h"
#import "LoginModel.h"
#import "ReserveViewController.h"

@interface RestaurantBasicInfoViewController () {
    Restaurant *_rest;
    Appoinment *_appoinment;
}
- (void)cancelReservation:(id)sender;
@end

@implementation RestaurantBasicInfoViewController
- (void)setAppoinment:(Appoinment *)appoinment {
    _appoinment = appoinment;
    self.restaurant = appoinment.restaurant;
    [self.reverseButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [self.reverseButton addTarget:self action:@selector(cancelReservation:) forControlEvents:UIControlEventTouchDown];
}
- (void)cancelReservation:(id)sender {
    if (_appoinment) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure? " message:@"Are you sure to cancel this appoinment? " delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}
- (Appoinment *)appoinment { return _appoinment; }
- (void)setRestaurant:(Restaurant *)restaurant {
    _rest = restaurant;
    self.titleTextView.text = _rest.name;
    self.phoneNumView.text = [@"Phone Number: " stringByAppendingString:_rest.phoneNumber];
    self.addrNumView.text = [@"Address: " stringByAppendingString:_rest.address];
    self.logoView.image = _rest.restaurantLogo;
}
- (Restaurant *)restaurant { return _rest; }
- (IBAction)makeReservation:(id)sender {
    ReserveViewController *con = [[ReserveViewController alloc] initWithNibName:@"ReserveViewController" bundle:[NSBundle mainBundle]];
    con.restaurant = _rest;
    [self.mainView.navigationController pushViewController:con animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.appoinment) {
        if (buttonIndex == 1) {
            [self.appoinment cancel];
            [self.mainView.navigationController popViewControllerAnimated:YES];
        }
    } else {
        
    }
    
}
@end
