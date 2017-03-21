//
//  ReserveViewController.h
//  Reservation
//
//  Created by Wai Man Chan on 4/22/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface ReserveViewController : UIViewController {
    IBOutlet UITextField *partySizeField;
}
- (IBAction)clickOutside:(id)sender;
@property (readwrite) Restaurant *restaurant;
@end
