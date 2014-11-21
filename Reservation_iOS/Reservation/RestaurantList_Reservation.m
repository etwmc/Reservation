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

@implementation RestaurantList_Reservation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Restaurant";
    cell.detailTextLabel.text = @"100m";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Restaurant *rest = [Restaurant testCase];
    RestaurantInfoViewController *con = [[RestaurantInfoViewController alloc] initWithNibName:@"RestaurantInfoViewController" bundle:[NSBundle mainBundle]];
    con.restaurant = rest;
    [self.navigationController pushViewController:con animated:YES];
}

@end
