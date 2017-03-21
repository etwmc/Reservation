//
//  CurrentOrderTableViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 4/7/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "CurrentOrderTableViewController.h"
#import "MenuModel.h"
#import "MenuEntityTableViewCell.h"
#import "CurrentOrderModel.h"
#import "Restaurant.h"

@interface CurrentOrderTableViewController () <MenuModelDelegate> {
    UIAlertView *alertView;
    NSIndexPath *orderCellIndex;
}

@end

@implementation CurrentOrderTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Welcome to %@", [[Restaurant alloc] initWithID:[CurrentOrderModel shareModel].restaurantNumber.longLongValue].name] message:@"To add single object, click on the food. Too add more, hold the food title. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"Order For Table %d", [CurrentOrderModel shareModel].tableNumber.intValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MenuModel shareModel].delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    [tableView registerClass:[MenuEntityTableViewCell class] forCellReuseIdentifier:@"MenuEntry"];
    return ([[MenuModel shareModel].menu count]+1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([MenuModel shareModel].menu.count >section) {
        NSDictionary *dictionary = [MenuModel shareModel].menu;
        return ((NSDictionary *)dictionary[dictionary.allKeys[section]]).count;
    } else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([MenuModel shareModel].menu.count > indexPath.section) {
        MenuEntityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuEntry" forIndexPath:indexPath];
        // Configure the cell...
        NSDictionary *section = [MenuModel shareModel].menu;
        NSArray *product = section[section.allKeys[indexPath.section]];
        cell.representObj = product[indexPath.row];
        
        return cell;
    } else {
        orderCellIndex = indexPath;
        return [MenuModel shareModel].orderTableViewCell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([MenuModel shareModel].menu.count > section) {
        NSDictionary *list = [MenuModel shareModel].menu;
        return list.allKeys[section];
    } else return NULL;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < tableView.numberOfSections-1) {
        MenuEntityTableViewCell *cell = (MenuEntityTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.representObj.quantity++;
        [[MenuModel shareModel] addProduct:cell.representObj];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
        [[MenuModel shareModel] order:self];
    }
}

- (void)orderHasChangedAtModel:(MenuModel *)model {
    if (orderCellIndex) {
        [self.tableView reloadRowsAtIndexPaths:@[orderCellIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
