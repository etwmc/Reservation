//
//  LoginViewController.m
//  Reservation
//
//  Created by CHAN, Wai Man on 18/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "LoginViewController.h"

#define Login_Addr @"http://happywaiman.dlinkddns.com/Reserve/User/login.php?username=%@&password%@"

@interface LoginViewController () {
    Account_Login_Status status;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.completeLoginBlock(status);
    });
}

- (IBAction)login:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Login_Addr, usernameField.text, passwordField.text]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data == NULL)
        status = login_no_network;
    else {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if ([@"Success" isEqualToString:dictionary[@"Stage"]]) {
            status = login_success;
        } else if ([@"Fail" isEqualToString:dictionary[@"Stage"]]) {
            status = login_fail;
        }
    }
}

@synthesize usernameField;
@synthesize passwordField;
@synthesize completeLoginBlock;
@end

@implementation AccountModel
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
        sem = dispatch_semaphore_create(1);
    }
    return self;
}

- (bool)loginSuccess {
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    return false;
}

- (void)startLoginSession:(void (^)(Account_Login_Status loginStatus))doneLogin {
    UIApplication *application = [UIApplication sharedApplication];
    LoginViewController *controller = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    controller.completeLoginBlock = doneLogin;
    [application.keyWindow.rootViewController presentViewController:controller animated:YES completion:^{
        dispatch_semaphore_signal(sem);
    }];
}

@end