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
#import "AppoinmentDetailViewController.h"

@interface AppoinmentViewController () {
    AccountModel *model;
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
    self.tableView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height+20, 0, 0, 0);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    model = [AccountModel shareInstance];
    //[model startLoginSession];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    return 1;
    // Return the number of sections.
    if (true) return 0;
    else {
        //Retrieve date booked
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    return [AppoinmentModel shareModel].appoinments.count;
    // Return the number of rows in the section.
    if (true) return 0;
    else {
        //Retrueve number of booking at specific date
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDate *date = ((Appoinment *)[AppoinmentModel shareModel].appoinments[indexPath.row]).startDate;
    NSString *restaurantName = ((Appoinment *)[AppoinmentModel shareModel].appoinments[indexPath.row]).restaurantName;
    cell.textLabel.text = restaurantName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = formatter.timeStyle = NSDateFormatterShortStyle;
    cell.detailTextLabel.text = [formatter stringFromDate:date];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (segue) {
        AppoinmentDetailViewController *con = segue.destinationViewController;
        con.appoinment = [AppoinmentModel shareModel].appoinments[([self.tableView indexPathForCell:sender].row)];
    }
}

@end
