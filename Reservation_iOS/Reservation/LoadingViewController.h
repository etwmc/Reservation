//
//  LoadingViewController.h
//  Reservation
//
//  Created by Wai Man Chan on 4/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingViewController : NSObject {
    UIView *loadingView;
    UIActivityIndicatorView *active;
}
- (void)startLoading;
- (void)stopLoading;
+ (LoadingViewController *)shareController;
@property (readonly) BOOL loading;
@end
