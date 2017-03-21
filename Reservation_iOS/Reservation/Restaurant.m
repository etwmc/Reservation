//
//  Restaurant.m
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import "Restaurant.h"
#import "ProjectConstant.h"

@interface Restaurant () {
    NSDictionary *dictionary;
    UIImage *logo;
    NSArray *photoList;
}
@end

@implementation Restaurant
@synthesize durationPerMeal, sid;
+ (Restaurant *)testCase {
}
- (id)initWithID:(long long)restaurantID {
    self = [super init];
    if (self) {
        NSString *InfoAddress = [NSString stringWithFormat:restaurantInfo, restaurantID];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:InfoAddress]];
        dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        durationPerMeal = ((NSNumber *)(dictionary[@"Meal Duration"])).doubleValue;
        sid = restaurantID;
    }
    return self;
}
//Info Retrieve
- (NSString *)name { return dictionary[@"CompanyName"]; }
- (NSString *)phoneNumber { return dictionary[@"phoneNumber"]; }
- (NSString *)address { return dictionary[@"StoreAddr"]; }
- (UIImage *)restaurantLogo {
    if (logo) return logo;
    NSURL *url = [NSURL URLWithString:dictionary[@"LogoAddress"]];
    logo = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if (!logo) logo = [UIImage imageNamed:@"Chinese".lowercaseString];
    return logo;
}
- (NSArray *)listOfPicture {
    NSURL *url = [NSURL URLWithString:dictionary[@"ListofPicture"]];
    if (photoList == NULL) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        photoList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
    }
    return photoList;
}

- (BOOL)currentlyAvailable {
#warning - Not defined
    return sid<10;
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = NULL;
    if (formatter == NULL) {
        formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"HH:mm:ss"];
    }
    return formatter;
}
- (NSDate *)openHour {
    return [[Restaurant dateFormatter] dateFromString:dictionary[@"OpenHour"]];
}
- (NSDate *)closeHour {
    return [[Restaurant dateFormatter] dateFromString:dictionary[@"CloseHour"]];
}
@end
