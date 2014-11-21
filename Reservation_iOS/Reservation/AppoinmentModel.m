//
//  AppoinmentModel.m
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "AppoinmentModel.h"
#import "Appoinment.h"

@implementation AppoinmentModel
- (NSArray *)appoinments {
    return @[[Appoinment testCase], [Appoinment testCase], [Appoinment testCase]];
}
+ (AppoinmentModel *)shareModel {
    static AppoinmentModel *model = NULL;
    if (model == NULL) {
        model = [AppoinmentModel new];
    }
    return model;
}
@end
