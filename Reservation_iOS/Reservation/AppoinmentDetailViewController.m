//
//  AppoinmentDetailViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "AppoinmentDetailViewController.h"
#import "RestaurantInfoViewController.h"

@interface AppoinmentDetailViewController () <UIAlertViewDelegate> {
    RestaurantInfoViewController *con;
}
@end

@implementation AppoinmentDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	// Do any additional setup after loading the view.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = formatter.timeStyle = NSDateFormatterShortStyle;
    self.title = [formatter stringFromDate:self.appoinment.startDate];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(CancelAppoinment:)];
    
    con = [[RestaurantInfoViewController alloc] initWithNibName:@"RestaurantInfoViewController" bundle:[NSBundle mainBundle]];
    con.restaurant = con.basicInfoCon.restaurant = [Restaurant testCase];
    con.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:con.view];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CancelAppoinment:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel" message:@"Are you sure you want to cancel the appoinment? " delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
#warning - Under construction
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not implement" message:@"This function is still under construction" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:nil];
        [alert show];
    }
}

@end
