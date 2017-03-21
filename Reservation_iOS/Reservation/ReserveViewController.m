//
//  ReserveViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 4/22/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "ReserveViewController.h"
#import "LoginModel.h"
#import "ProjectConstant.h"
@interface ReserveViewController ()

@end

@implementation ReserveViewController
@synthesize restaurant;

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
    self.title = @"Reserve";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReserve:)];
}

- (IBAction)doneReserve:(id)sender {
    LoginModel *model = [LoginModel shareModel];
    NSString *address = [NSString stringWithFormat:reservationFinishURL, restaurant.sid];
    [model queryWithAddress:address withQuery:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        if (((NSNumber *)dictionary[@"state"]).boolValue) {
            
        } else {
            
        }
    } cancel:^{
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickOutside:(id)sender {
    [partySizeField resignFirstResponder];
}

@end
