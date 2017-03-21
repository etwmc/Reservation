//
//  Reservation_RestaurantModelTest.m
//  Reservation
//
//  Created by Wai Man Chan on 4/15/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Restaurant.h"
#import "AppDelegate.h"
#import "RestaurantBasicInfoViewController.h"

@interface Reservation_RestaurantModelTest : XCTestCase {
    //Using a restaurant information to test
    Restaurant *testingRestaurant;
}
@end

@implementation Reservation_RestaurantModelTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    testingRestaurant = [[Restaurant alloc] initWithID:2];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [AppDelegate gcovFlush];
}

- (void)testRestaurantID {
    XCTAssertEqual(testingRestaurant.sid, 2, @"SID is not equal");
}

- (void)testRestaurantName {
    XCTAssertEqualObjects(testingRestaurant.name, @"Test Kitchen 1", @"Name is not equal");
}

- (void)testRestaurantPhoneNumber {
    XCTAssertEqualObjects(testingRestaurant.phoneNumber, @"123456", @"Phone Number is not equal");
}

- (void)testRestaurantAddr {
    XCTAssertEqualObjects(testingRestaurant.address, @"Hong Kong University of Science and Technology", @"Address is not equal");
}

- (void)testOpenCloseHour {
    XCTAssertEqualObjects(testingRestaurant.openHour, testingRestaurant.closeHour, @"Test Address is equal");
}

@end
