//
//  RestaurantList_Reservation.m
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "RestaurantList_Reservation.h"
#import "Restaurant.h"
#import "RestaurantInfoViewController.h"
#import "LoadingViewController.h"
#import "ProjectConstant.h"

@interface RestaurantList_Reservation () {
    NSArray *restaurantArray;
}
@end

@implementation RestaurantList_Reservation


- (void)reloadList:(id)sender {
    [[LoadingViewController shareController] startLoading];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:fetchAddressWithSubType, (self.foodType.row+1)]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        restaurantArray = [NSMutableArray new];
        for (NSNumber *num in array) {
            [((NSMutableArray *)restaurantArray) addObject:[[Restaurant alloc] initWithID:num.longLongValue]];
        }
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        [[LoadingViewController shareController] stopLoading];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Refresh Nearby Restaurant", NULL)];
    [self.refreshControl addTarget:self action:@selector(reloadList:) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
    [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return restaurantArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = ((Restaurant *)restaurantArray[indexPath.row]).name;
    cell.detailTextLabel.text = @"100m";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantInfoViewController *con = [[RestaurantInfoViewController alloc] initWithNibName:@"RestaurantInfoViewController" bundle:[NSBundle mainBundle]];
    con.restaurant = restaurantArray[indexPath.row];
    [self.navigationController pushViewController:con animated:YES];
}

@end
