//
//  MenuModel.m
//  Reservation
//
//  Created by Wai Man Chan on 4/7/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "MenuModel.h"
#import "LoadingViewController.h"
#import "CurrentOrderModel.h"
#import "LoginModel.h"
#import "ProjectConstant.h"

#import <PassKit/PassKit.h>

@interface Product ()
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
@implementation Product
@synthesize title, price, quantity;
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        title = dictionary[@"Title"];
        price = dictionary[@"Price"];
        quantity = 0;
    }
    return self;
}

- (float)totalCost { return price.floatValue * quantity; }

@end

@implementation MenuModel
@synthesize delegate;

+ (MenuModel *)shareModel {
    static MenuModel *model = NULL;
    if (model == NULL) model = [MenuModel new];
    return model;
}

- (id)init {
    self = [super init];
    if (self) {
        CurrentOrderModel *model = [CurrentOrderModel shareModel];
        rid = model.restaurantNumber.longLongValue;
        tableID = model.tableNumber.intValue;
        list = [NSMutableArray new];
    }
    return self;
}

- (void)refresh {
    [[LoadingViewController shareController] startLoading];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:menuFetchURL, rid]];
    NSData * data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    for (NSString *key in dictionary.allKeys) {
        NSArray *array = dictionary[key];
        NSMutableArray *_array = [NSMutableArray new];
        for (NSDictionary *dict in array) {
            [_array addObject:[[Product alloc] initWithDictionary:dict]];
        }
        [tempDict setObject:[NSArray arrayWithArray:_array] forKey:key];
    }
    menu = [NSDictionary dictionaryWithDictionary:tempDict];
    
    [[LoadingViewController shareController] stopLoading];
}

- (NSDictionary *)menu {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self refresh];
    });
    return menu;
}

- (void)addProduct:(Product *)product {
    if (![list containsObject:product]) {
        [list addObject:product];
        product.quantity = 1;
        [product addObserver:self forKeyPath:@"quantity" options:0 context:NULL];
        [delegate orderHasChangedAtModel:self];
    } else {
        product.quantity++;
    }
}

- (int)totalQuantity {
    int total = 0;
    for (Product *p in list) {
        total += p.quantity;
    }
    return total;
}

- (float)totalCost {
    float total = 0;
    for (Product *p in list) {
        total += p.totalCost;
    }
    return total;
}

- (UITableViewCell *)orderTableViewCell {
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Order"];
    tableViewCell.textLabel.text = [NSString stringWithFormat:@"%d Food", [self totalQuantity]];
    tableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", self.totalCost];
    return tableViewCell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [delegate orderHasChangedAtModel:self];
}

- (void)order: (UIViewController *)parentVC {
    if (list.count > 0) {
        NSMutableDictionary *tmp = [NSMutableDictionary new];
        NSMutableArray *paymentItem = [NSMutableArray new];
        NSMutableDictionary *orderList = [NSMutableDictionary new];
        for (Product *p in list) {
            [tmp setObject:[NSNumber numberWithInt:p.quantity] forKey:p.title];
            [orderList setObject:p forKey:p.title];
        }
        for (NSString *productName in tmp.allKeys) {
            NSNumber *quantiy = tmp[productName];
            double amount = quantiy.doubleValue * ((Product*)orderList[productName]).price.doubleValue;
            PKPaymentSummaryItem *item = [PKPaymentSummaryItem summaryItemWithLabel:productName amount:[[NSDecimalNumber alloc] initWithDouble:amount] type:PKPaymentSummaryItemTypeFinal];
            [paymentItem addObject:item];
        }
        orderData = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:NULL];
        list = [NSMutableArray new];
        
        //Payment
        NSNumber *total;
        PKPaymentRequest *paymentReq = [PKPaymentRequest new];
        paymentReq.paymentSummaryItems = paymentItem;
        paymentReq.applicationData = orderData;
        
        PKPaymentAuthorizationViewController *vc = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:paymentReq];
        [parentVC presentViewController:vc animated:true completion:^{}];
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No order" message:@"You haven't order anything yet. " delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [controller dismissViewControllerAnimated:true completion:^{}];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion {
    [[LoginModel shareModel] queryWithAddress:[NSString stringWithFormat:addOrderAddress, tableID, rid] andData:orderData withQuery:^(NSData *data) {
        NSLog(@"data");
    } cancel:^{
        NSLog(@"Cancel");
    }];
}

#ifdef DEBUG
- (void)testMethod:(long long)_rid table:(int)_tableID {
    rid = _rid; tableID = _tableID;
}
#endif

@end
