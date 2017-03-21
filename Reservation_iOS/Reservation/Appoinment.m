//
//  Appoinment.m
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "Appoinment.h"
#import "LoginModel.h"
#import "ProjectConstant.h"

@implementation Appoinment
@synthesize duration, startDate, restaurant, appoinmentID;
+(void)appoinmentAtRestaurant:(Restaurant *)r atDate:(NSDate *)date withNumberOfPerson:(unsigned short) numberOfPerson success:(void (^)())successBlock failedBlock:(void (^)())failedBlock {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *newAddr = [NSString stringWithFormat:CreateAppoinmentAddr, r.sid, [formatter stringFromDate:date]];
    [[LoginModel shareModel] queryWithAddress:newAddr withQuery:^(NSData *data) {
        successBlock();
    } cancel:^{
        failedBlock();
    }];
}
- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        startDate = [formatter dateFromString:dict[@"Time"]];
        restaurant = [[Restaurant alloc] initWithID:((NSNumber *)dict[@"Store_idStore"]).longLongValue];
        appoinmentID = ((NSNumber *)dict[@"idAppoinment"]).longLongValue;
        duration = restaurant.durationPerMeal;
    }
    return self;
}

- (void)cancel {
    LoginModel *model = [LoginModel shareModel];
    [model queryWithAddress:[NSString stringWithFormat:CancelAppoinmentAddr, appoinmentID] withQuery:^(NSData *data) {
        
    } cancel:^{}];
}

@end
