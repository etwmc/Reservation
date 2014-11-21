//
//  ReservationTests.m
//  ReservationTests
//
//  Created by CHAN, Wai Man on 18/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "ReservationTests.h"
#import "LoginViewController.h"

@implementation ReservationTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    AccountModel *model = [AccountModel shareInstance];
    STAssertNotNil(model, @"Test the model has single instance");
    STAssertFalse(model.loginSuccess, @"Test init login state of the model");
}

@end
