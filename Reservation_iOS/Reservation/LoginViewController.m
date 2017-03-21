//
//  LogicViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 4/1/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "LoginViewController.h"
#import "ProjectConstant.h"

@protocol AccountManagement <NSObject>
- (void)accountInfoUpdateByVC:(UIViewController *)viewController withState:(Account_Login_Status)status userID:(NSString *)userID credit:(NSString *)credit;
@end
@interface AccountModel () <AccountManagement> {
    dispatch_semaphore_t sem;
}
@end


@implementation LoginViewController

- (NSData *)loginData:(NSString *)username andPassword:(NSString *)password {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Login_Addr, username, password]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}

- (BOOL)checkLoginFromData:(NSData *)data {
    if (data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (((NSNumber *)dictionary[@"State"]).boolValue) {
            [[AccountModel shareInstance] accountInfoUpdateByVC:self withState:login_success userID:dictionary[@"ID"] credit:dictionary[@"UUID"]];
            return YES;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Either the username or password is wrong. Or they're both wrong. " delegate:nil cancelButtonTitle:@"Fine" otherButtonTitles:nil];
            [alert show];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"I can't connect to the server, can you check your network connection? " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    return false;
}

- (IBAction)login:(id)sender {
    NSData *data;
    data = [self loginData:usernameField.text andPassword:passwordField.text];
    [self willChangeValueForKey:@"status"];
    [self checkLoginFromData:data];
    [self didChangeValueForKey:@"status"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (IBAction)registerAcc:(id)sender {
    NSURL *url = [NSURL URLWithString:Register_Addr];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)cancel:(id)sender {
    [[AccountModel shareInstance] accountInfoUpdateByVC:self withState:login_cancel userID:NULL credit:NULL];
}
@synthesize usernameField, passwordField;
@end

@implementation AccountModel
@synthesize creditID, manualStop;
+ (AccountModel *)shareInstance {
    static AccountModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [AccountModel new];
    });
    return model;
}

- (id)init {
    self = [super init];
    if (self) {
        sem = dispatch_semaphore_create(0);
        _login = false;
    }
    return self;
}

- (bool)login {
    if (_login) return _login;
    [self startLoginSession];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    return _login;
}

- (void)startLoginSession {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        _loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
        [application.keyWindow.rootViewController presentViewController:_loginVC animated:YES completion:^{}];
    });
}

- (NSString *)userID {
    if (self.login == false) {
        [self startLoginSession];
    }
    return userID;
}

- (void)accountInfoUpdateByVC:(UIViewController *)viewController withState:(Account_Login_Status)status userID:(NSString *)_userID credit:(NSString *)_credit {
    [viewController dismissViewControllerAnimated:YES completion:^{}];
    _login = (status == login_success);
    manualStop = (status == login_cancel);
    userID = _userID;
    creditID = _credit;
    dispatch_semaphore_signal(sem);
}
- (void)error { [self logout]; }
- (void)logout {
    userID = creditID = NULL;
    _login = false;
}

@end