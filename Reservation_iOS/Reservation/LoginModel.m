//
//  LoginModel.m
//  Reservation
//
//  Created by Wai Man Chan on 3/14/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "LoginModel.h"
#import "LoginViewController.h"
#import "LoadingViewController.h"

@interface LoginModel ()
@end

@implementation LoginModel
@synthesize queue;

- (id)init {
    self = [super init];
    if (self) {
        queue = dispatch_queue_create("Login Queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (NSError *)queryWithAddress:(NSString *)address withQuery:(void (^)(NSData *data))finish cancel:(void (^)())cancelFunciton {
    dispatch_barrier_async(queue, ^{
        AccountModel *model = [AccountModel shareInstance];
        bool loged = model.login;
        dispatch_sync(dispatch_get_main_queue(), ^{ [[LoadingViewController shareController] startLoading]; });
        if (loged) {
            NSString *newAddr = [address stringByReplacingOccurrencesOfString:@"_uid" withString:model.userID];
            newAddr = [newAddr stringByReplacingOccurrencesOfString:@"_cid" withString:model.creditID];
            NSURL *url = [NSURL URLWithString:newAddr];
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSDictionary *packet = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
            if (((NSNumber *)packet[@"state"]).boolValue) {
                model.creditID = packet[@"pass"];
                NSString *content = packet[@"content"];
                finish([content dataUsingEncoding:NSUTF8StringEncoding]);
            } else {
                [model logout];
                [self queryWithAddress:address withQuery:finish cancel:cancelFunciton];
            }
        } else {
            cancelFunciton();
        }
        dispatch_sync(dispatch_get_main_queue(), ^{ [[LoadingViewController shareController] stopLoading]; });
    });
    return NULL;
}

+ (LoginModel *)shareModel {
    static LoginModel *model = NULL;
    if (model == NULL) model = [LoginModel new];
    return model;
}

- (NSError *)queryWithAddress:(NSString *)address andData:(NSData *)data withQuery:(void (^)(NSData *data))finish cancel:(void (^)())cancelFunciton {
    dispatch_barrier_async(queue, ^{
        AccountModel *model = [AccountModel shareInstance];
        bool loged = model.login;
        dispatch_sync(dispatch_get_main_queue(), ^{ [[LoadingViewController shareController] startLoading]; });
        if (loged) {
            NSString *newAddr = [address stringByReplacingOccurrencesOfString:@"_uid" withString:model.userID];
            newAddr = [newAddr stringByReplacingOccurrencesOfString:@"_cid" withString:model.creditID];
            NSURL *url = [NSURL URLWithString:newAddr];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            request.HTTPMethod = @"POST";
            request.HTTPBody = data;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
            NSDictionary *packet = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
            if (((NSNumber *)packet[@"state"]).boolValue) {
                model.creditID = packet[@"pass"];
                NSString *content = packet[@"content"];
                finish([content dataUsingEncoding:NSUTF8StringEncoding]);
            } else {
                [model logout];
                [self queryWithAddress:address andData:data withQuery:finish cancel:cancelFunciton];
            }
        } else {
            cancelFunciton();
        }
        dispatch_sync(dispatch_get_main_queue(), ^{ [[LoadingViewController shareController] stopLoading]; });
    });
    return NULL;
}

@end
