//
//  LoadingViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 4/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "LoadingViewController.h"

@implementation LoadingViewController
@synthesize loading;
- (id)init {
    self = [super init];
    if (self) {
        CGRect rect = [UIApplication sharedApplication].keyWindow.bounds;
        loadingView = [[UIView alloc] initWithFrame:rect];
        loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [loadingView addSubview:active];
        active.center = loadingView.center;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.text = NSLocalizedString(@"Loading", @"Loading content string");
        label.font = [UIFont systemFontOfSize:40];
        label.textColor = [UIColor whiteColor];
        [loadingView addSubview:label];
        [label sizeToFit];
        label.center = CGPointMake(loadingView.center.x, loadingView.center.y-40);
    }
    return self;
}
- (void)startLoading {
    if (!self.loading) {
        [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
        active.hidden = false;
        [active startAnimating];
        loading = true;
    }
}
- (void)stopLoading {
    if (loadingView) {
        [loadingView removeFromSuperview];
        active.hidden = false;
        [active stopAnimating];
        loading = false;
    }
}
+ (LoadingViewController *)shareController {
    static LoadingViewController *con = NULL;
    if (con == NULL) {
        con = [LoadingViewController new];
    }
    return con;
}
@end
