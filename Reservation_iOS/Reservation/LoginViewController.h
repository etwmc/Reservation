//
//  LogicViewController.h
//  Reservation
//
//  Created by Wai Man Chan on 4/1/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    login_notfinish = 0,
    login_success,
    login_cancel,
    login_no_network
} Account_Login_Status;

@interface LoginViewController : UIViewController

@property IBOutlet UITextField *usernameField;
@property IBOutlet UITextField *passwordField;
- (IBAction)login:(id)sender;
- (IBAction)registerAcc:(id)sender;
- (IBAction)cancel:(id)sender;
@end

@interface AccountModel : NSObject  {
    NSString *userID, *creditID;
    bool _login;
}
#ifdef DEBUG
#endif
+ (AccountModel *)shareInstance;
- (void)logout;
- (void)error;
@property (readonly) NSString *userID;
@property (readwrite) NSString  *creditID;
@property (readonly) bool login;
@property (readonly) bool manualStop;
@property (readonly) LoginViewController *loginVC;
@end