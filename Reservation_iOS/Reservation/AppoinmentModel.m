//
//  AppoinmentModel.m
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "AppoinmentModel.h"
#import "Appoinment.h"
#import "LoginModel.h"
#import "ProjectConstant.h"

@interface AppoinmentModel () {
}
@end

@implementation AppoinmentModel
@synthesize appoinments, available, delegate;
- (void)refresh {
    if (appoinments.count) [((NSMutableArray *)appoinments) removeAllObjects];
    LoginModel *loginModel = [LoginModel shareModel];
    [loginModel queryWithAddress:AppoinmentFetchAddr  withQuery:^(NSData *data) {
        NSArray *list = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        appoinments = [NSMutableArray new];
        for (NSDictionary *dictionary in list) {
            [((NSMutableArray *)appoinments) addObject:[[Appoinment alloc] initWithDictionary:dictionary]];
        }
        available = true;
        [delegate appoinmentModelUpdate];
    } cancel:^{
        appoinments = @[];
        available = false;
        [delegate appoinmentModelUpdate];
    }];
}
+ (AppoinmentModel *)shareModel {
    static AppoinmentModel *model = NULL;
    if (model == NULL) {
        model = [AppoinmentModel new];
    }
    return model;
}
@end
