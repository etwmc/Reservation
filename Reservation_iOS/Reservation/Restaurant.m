//
//  Restaurant.m
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import "Restaurant.h"

@interface Restaurant () {
    NSDictionary *dictionary;
    UIImage *logo;
}
@end

@implementation Restaurant
@synthesize durationPerMeal;
- (id)initWithID:(int)restaurantID {
    self = [super init];
    if (self) {
        if (restaurantID > 0) {
            NSString *InfoAddress = [NSString stringWithFormat:@"http://happywaiman.dlinkddns.com:10000/Reserve/Company/Info.php?id=%d", restaurantID];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:InfoAddress]];
            dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        }
        else {
            dictionary = @{@"Name": @"Test Case", @"Phone Number": @"+THIS-IS-TEST-NUM", @"Address": @"Testing Adddress", @"Open Hour" : @"07:00", @"Close Hour" : @"23:00", @"Meal Duration" : @(60*60*2)};
        }
        durationPerMeal = ((NSNumber *)(dictionary[@"Meal Duration"])).doubleValue;
    }
    return self;
}
+ (Restaurant *)testCase {
    return [[Restaurant alloc] initWithID:-1];
}
//Info Retrieve
- (NSString *)name { return dictionary[@"Name"]; }
- (NSString *)phoneNumber { return dictionary[@"Phone Number"]; }
- (NSString *)address { return dictionary[@"Address"]; }
- (UIImage *)restaurantLogo {
    if (logo) return logo;
    logo = [UIImage imageWithData:[NSData dataWithContentsOfURL:dictionary[@"logoAddr"]]];
    if (!logo) logo = [UIImage imageNamed:@"Chinese".lowercaseString];
    return logo;
}
- (NSArray *)listOfPicture {
    return dictionary[@"List of Picture"];
}

- (BOOL)currentlyAvailable {
    return random()>LONG_MAX/2;
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = NULL;
    if (formatter == NULL) {
        formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"HH:mm"];
    }
    return formatter;
}
- (NSDate *)openHour {
    return [[Restaurant dateFormatter] dateFromString:dictionary[@"Open Hour"]];
}
- (NSDate *)closeHour {
    return [[Restaurant dateFormatter] dateFromString:dictionary[@"Close Hour"]];
}

@end
