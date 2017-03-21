//
//  MenuEntityTableViewCell.h
//  Reservation
//
//  Created by Wai Man Chan on 4/7/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

@interface MenuEntityTableViewCell : UITableViewCell
@property (readwrite, atomic) Product *representObj;
@end
