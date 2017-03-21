//
//  LoginModel.h
//  Reservation
//
//  Created by Wai Man Chan on 3/14/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject {
}
@property (readonly) dispatch_queue_t queue;
- (NSError *)queryWithAddress:(NSString *)address withQuery:(void (^)(NSData *data))finish cancel:(void (^)())cancelFunciton;
- (NSError *)queryWithAddress:(NSString *)address andData:(NSData *)data withQuery:(void (^)(NSData *data))finish cancel:(void (^)())cancelFunciton;
+ (LoginModel *)shareModel;
@end
