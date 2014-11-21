//
//  LoginViewController.h
//  Reservation
//
//  Created by CHAN, Wai Man on 18/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    login_notfinish = 0,
    login_success,
    login_fail,
    login_no_network
} Account_Login_Status;

@interface LoginViewController : UIViewController
#define Login_Addr @"http://happywaiman.dlinkddns.com/Reserve/User/login.php?username=%@&password%@"
@property (strong, readwrite, atomic) void (^completeLoginBlock)(Account_Login_Status status);
@property IBOutlet UITextField *usernameField;
@property IBOutlet UITextField *passwordField;
- (IBAction)login:(id)sender;
- (IBAction)registerAcc:(id)sender;
@end

@interface AccountModel : NSObject {
    dispatch_semaphore_t sem;
}
+ (AccountModel *)shareInstance;
- (bool)loginSuccess;
- (void)startLoginSession:(void (^)(Account_Login_Status loginStatus))doneLogin;
- (void)startLogoutSession;
- (bool)useAccountToPerformInstruction:(NSString *)instruction;
@end
