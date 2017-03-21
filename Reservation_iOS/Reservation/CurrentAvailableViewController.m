//
//  CurrentAvailableViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import "CurrentAvailableViewController.h"

#import "Restaurant.h"
#import "RestaurantInfoViewController.h"
#import "LoadingViewController.h"
#import "ProjectConstant.h"

@interface CurrentAvailableViewController () {
    NSArray *availableList;
}
@end

@implementation CurrentAvailableViewController

- (NSArray *)arrayOfAvailableRestaurant {
    return availableList;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)refresh:(id)sender {
    [[LoadingViewController shareController] startLoading];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:fetchAddress];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSArray *array;
        if (data) array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        NSMutableArray *result = [NSMutableArray new];
        for (NSNumber *number in array) {
            [result addObject:[[Restaurant alloc] initWithID:number.longLongValue]];
        }
        [self gatheredAvailableList:result];
        [[LoadingViewController shareController] stopLoading];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"Available";
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor magentaColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Getting Nearest Restaurant", @"")];
    self.refreshControl = refreshControl;
    [refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length, 0);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)gatheredAvailableList:(NSArray *)list {
    if (list) availableList = [list sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Restaurant *r1, *r2;
        r1 = obj1;  r2 = obj2;
        if (r1.currentlyAvailable != r2.currentlyAvailable)
            return r1.currentlyAvailable?NSOrderedAscending:NSOrderedDescending;
        return NSOrderedSame;
    }]; else availableList = @[];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger it = [self arrayOfAvailableRestaurant].count;
    return it==0?1:it;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self arrayOfAvailableRestaurant].count==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Message"];
        cell.textLabel.text = NSLocalizedString(@"We found no restaurant near you", NULL);
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Configure the cell...
    cell.textLabel.text = ((Restaurant *)[self arrayOfAvailableRestaurant][indexPath.row]).name;
    if (((Restaurant *)[self arrayOfAvailableRestaurant][indexPath.row]).currentlyAvailable) {
        cell.detailTextLabel.text = @"Available";
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else  {
        cell.detailTextLabel.text = @"Nope";
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self arrayOfAvailableRestaurant].count==0) { [tableView deselectRowAtIndexPath:indexPath animated:YES]; return; }
    RestaurantInfoViewController *info = [[RestaurantInfoViewController alloc] initWithNibName:@"RestaurantInfoViewController" bundle:[NSBundle mainBundle]];
    info.restaurant = ((Restaurant *)[self arrayOfAvailableRestaurant][indexPath.row]);
    [self.navigationController pushViewController:info animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
