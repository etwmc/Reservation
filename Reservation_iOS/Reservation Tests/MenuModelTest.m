//
//  CurrentOrderModelTest.m
//  Reservation
//
//  Created by Wai Man Chan on 5/1/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MenuModel.h"

@interface MenuModel ()
- (void)testMethod:(long long)_rid table:(int)_tableID;
@end

@interface MenuModelTest : XCTestCase {
    MenuModel *model;
}
@end

@implementation MenuModelTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    model = [MenuModel new];
    [model testMethod:2 table:1];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTotal
{
    int quantity = 0;   float totalCost = 0;
    for (NSArray *array in model.menu.allValues) {
        for (Product *product in array) {
            [model addProduct:product];
            quantity++;
            totalCost += product.price.floatValue;
        }
    }
    NSString *numberOfFood = [NSString stringWithFormat:@"%d Food", quantity];
    NSString *totalCostStr = [NSString stringWithFormat:@"%.2f", totalCost];
    XCTAssertEqualObjects(numberOfFood, model.orderTableViewCell.textLabel.text, "Incorrect count");
    XCTAssertEqualObjects(totalCostStr, model.orderTableViewCell.detailTextLabel.text, "Incorrect Total Price");
}

@end
