//
//  ReservationTests.m
//  ReservationTests
//
//  Created by CHAN, Wai Man on 18/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewController.h"
#import "LoginModel.h"
#import "AppDelegate.h"
#import "ProjectConstant.h"

@class LoginViewController;

@interface LoginViewController ()
- (NSData *)loginData:(NSString *)username andPassword:(NSString *)password;
- (BOOL)checkLoginFromData:(NSData *)data;
@end
@interface AccountModel ()
- (void)startLoginSession;
- (void)accountInfoUpdateByVC:(UIViewController *)viewController withState:(Account_Login_Status)status userID:(NSString *)userID credit:(NSString *)credit;
@end
@interface Reservation_Tests : XCTestCase

@end
@implementation Reservation_Tests

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
    
    // Set-up code here.
    [self login];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
    [AppDelegate gcovFlush];
}

/*
 Test user login system
 */

- (void)testLoginSuccess
{
    LoginViewController *model = [LoginViewController new];
    NSData *data = [model loginData:@"tester" andPassword:@"102385"];
    XCTAssertTrue([model checkLoginFromData:data], @"Check success login");
}

- (void)testLoginFailed_Username
{
    LoginViewController *model = [LoginViewController new];
    NSData *data = [model loginData:@"tester1" andPassword:@"102385"];
    XCTAssertFalse([model checkLoginFromData:data], @"Check success login");
}

- (void)testLoginFailed_Password
{
    LoginViewController *model = [LoginViewController new];
    NSData *data = [model loginData:@"tester" andPassword:@"123456"];
    XCTAssertFalse([model checkLoginFromData:data], @"Check success login");
}

/*
 Test query login system
 */

- (void)testQuery {
    LoginModel *model = [LoginModel shareModel];
    [model queryWithAddress:testQueryURL withQuery:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        XCTAssertTrue(((NSNumber *)dictionary[@"State"]).boolValue, @"Success to run trial query");
    } cancel:^{
        XCTAssertTrue(false, @"Not suppose to occur");
    }];
}

- (void)testQueryOnCancel {
    [[AccountModel shareInstance] logout];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[LoginModel shareModel] queryWithAddress:testQueryURL withQuery:^(NSData *data) {
            XCTAssertTrue(false, @"Still login");
        } cancel:^{
            XCTAssertFalse(false, @"Detect logout event");
        }];
    });
    [[AccountModel shareInstance] accountInfoUpdateByVC:[[AccountModel shareInstance] loginVC] withState:login_cancel userID:NULL credit:NULL];
}

@end
