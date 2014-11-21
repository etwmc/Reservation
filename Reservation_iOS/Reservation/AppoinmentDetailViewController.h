//
//  AppoinmentDetailViewController.h
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appoinment.h"

@interface AppoinmentDetailViewController : UIViewController
@property Appoinment *appoinment;
- (IBAction)CancelAppoinment:(id)sender;
@end
