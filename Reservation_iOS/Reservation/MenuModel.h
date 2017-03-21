//
//  MenuModel.h
//  Reservation
//
//  Created by Wai Man Chan on 4/7/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

@interface Product : NSObject
@property (readonly) NSString *title;
@property (readonly) NSNumber *price;
@property (readwrite) int quantity;
- (float)totalCost;
@end

@class MenuModel;
@protocol MenuModelDelegate <NSObject>
- (void)orderHasChangedAtModel:(MenuModel *)model;
@end
@interface MenuModel : NSObject <PKPaymentAuthorizationViewControllerDelegate> {
    long long rid;
    int tableID;
    NSDictionary *menu;
    NSMutableArray *list;
    NSString *orderData;
}
+ (MenuModel *)shareModel;
- (void)refresh;
- (void)addProduct:(Product *)product;
- (void)order: (UIViewController *)parentVC;
- (UITableViewCell *)orderTableViewCell;
@property (readonly) NSDictionary *menu;
@property (readwrite) NSObject <MenuModelDelegate> *delegate;
@end
