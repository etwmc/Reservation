//
//  Reservation_AppoinmentTest.m
//  Reservation
//
//  Created by Wai Man Chan on 4/15/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Appoinment.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "AppoinmentModel.h"
#import "LoginModel.h"

@interface Reservation_AppoinmentTest : XCTestCase {
    Appoinment *app, *app1;
}
@end
@interface LoginViewController ()
- (NSData *)loginData:(NSString *)username andPassword:(NSString *)password;
- (BOOL)checkLoginFromData:(NSData *)data;
@end
@interface AccountModel ()
- (void)startLoginSession;
- (void)accountInfoUpdateByVC:(UIViewController *)viewController withState:(Account_Login_Status)status userID:(NSString *)userID credit:(NSString *)credit;
@end

@implementation Reservation_AppoinmentTest

- (void)login {
    AccountModel *accountModel = [AccountModel new];
    [accountModel startLoginSession];
    // Use test account
    dispatch_async(dispatch_get_main_queue(), ^{
        accountModel.loginVC.usernameField.text = @"tester";
        accountModel.loginVC.passwordField.text = @"102385";
        [accountModel.loginVC login:self];
    });
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSMutableDictionary *sampleDictionary = [NSMutableDictionary new];
    sampleDictionary[@"idAppoinment"] = @10000;
    sampleDictionary[@"Store_idStore"] = @2;
    sampleDictionary[@"Time"] = @"2015-01-01 20:00:00";
    app = [[Appoinment alloc] initWithDictionary:sampleDictionary];
}

- (void)testAppoinmentID {
    XCTAssertEqual(app.appoinmentID, 10000, "Parse of dictionary incorrect");
}

- (void)testRestaurant {
    XCTAssertNotNil(app.restaurant, "Restaurant can't be created");
    XCTAssertEqual(app.restaurant.sid, 2, "Incorrect Prase on dictionary");
}

- (void)testAppoinment {
    [self login];
    [Appoinment appoinmentAtRestaurant:app.restaurant atDate:app.startDate withNumberOfPerson:1 success:^{
        AppoinmentModel *model = [AppoinmentModel shareModel];
        XCTAssertTrue(model.appoinments.count, "Made appoinment");
    } failedBlock:^{
        XCTFail("Fail");
    }];
}

- (void)testCancelAppoinment {
    [self login];
    [Appoinment appoinmentAtRestaurant:app.restaurant atDate:app.startDate withNumberOfPerson:1 success:^{
        AppoinmentModel *model = [AppoinmentModel shareModel];
        XCTAssertTrue(model.appoinments.count, "Made appoinment");
        [((Appoinment *)model.appoinments[0]) cancel];
        XCTAssertTrue(model.appoinments.count==0, "Made appoinment");
    } failedBlock:^{
        XCTFail("Fail");
    }];
}

- (void)testRefresh {
    [self login];
    AppoinmentModel *model = [AppoinmentModel shareModel];
    [model refresh];
    XCTAssertTrue(true, "No crash on refresh appoinments");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [AppDelegate gcovFlush];
}

@end
