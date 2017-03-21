//
//  AppoinmentViewController.m
//  Reservation
//
//  Created by CHAN, Wai Man on 18/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "AppoinmentViewController.h"
#import "LoginViewController.h"
#import "AppoinmentModel.h"
#import "Appoinment.h"
#import "RestaurantInfoViewController.h"
#import "LoadingViewController.h"

@interface AppoinmentViewController () <AppoinmentModelDelegate> {
    AppoinmentModel *model;
    UIAlertView *alert;
}
@end

@implementation AppoinmentViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    model = [AppoinmentModel shareModel];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIRefreshControl *control = [UIRefreshControl new];
    [control addTarget:model action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    control.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Getting your appoinment", @"")];
    model.delegate = self;
    self.refreshControl = control;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"Appoinments";
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.refreshControl beginRefreshing];
    [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return model.appoinments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (model.available) {
        Appoinment *app = model.appoinments[indexPath.row];
        NSDate *date = app.startDate;
        NSString *restaurantName = app.restaurant.name;
        cell.textLabel.text = restaurantName;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = formatter.timeStyle = NSDateFormatterShortStyle;
        cell.detailTextLabel.text = [formatter stringFromDate:date];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (model.available) {
        Appoinment *app = model.appoinments[indexPath.row];
        RestaurantInfoViewController *info = [[RestaurantInfoViewController alloc] initWithNibName:@"RestaurantInfoViewController" bundle:[NSBundle mainBundle]];
        info.appoinment = app;
        [self.navigationController pushViewController:info animated:YES];
    } else {
        [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)appoinmentModelUpdate {
    if (model.available) {
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tabBarController.selectedIndex = 0;
            alert = [[UIAlertView alloc] initWithTitle:@"Cancel Login" message:@"You need to login/register your account to see your appoinments" delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        });
    }
}

@end
