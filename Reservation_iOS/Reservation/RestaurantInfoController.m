//
//  RestaurantInfoController.m
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "RestaurantInfoController.h"
#import "CommentTableViewCell.h"
#import "ProjectConstant.h"

@interface RestaurantInfoController () <UITableViewDataSource, UITableViewDelegate> {
    restaurantInfoType _type;
    UIView *_infoView;
    NSArray *comments;
}
@end
@implementation RestaurantInfoController
@synthesize restaurant;

//Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (self.infoType) {
        case RestaurantGeneralInfo:
            return 1;
        case RestaurantComment:
            return 1;
        case RestaurantMenu:
            return 10;
        default:
            return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.infoType) {
        case RestaurantGeneralInfo:
            return 5;
        case RestaurantComment:
            return comments.count;
        case RestaurantMenu:
            return 2;
        default:
            return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.infoType) {
        case RestaurantGeneralInfo: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Info" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            switch (indexPath.row) {
                case 0: {
                    NSDateFormatter *formatter = [NSDateFormatter new];
                    formatter.dateStyle = NSDateFormatterNoStyle; formatter.timeStyle = NSDateFormatterShortStyle;
                    if ([restaurant.openHour isEqualToDate:restaurant.closeHour]) cell.textLabel.text = NSLocalizedString(@"24 Hours", "Restaurant is 24 hours open");
                    else cell.textLabel.text = [NSString stringWithFormat:@"Hour: %@-%@", [formatter stringFromDate:restaurant.openHour], [formatter stringFromDate:restaurant.closeHour]];
                }
                    break;
                case 1: {
                    NSTimeInterval interval = restaurant.durationPerMeal;
                    short hour = interval/3600; interval -= hour*3600;
                    short minute = interval /60;
                    NSString *string = NULL;
                    if (minute)
                        string = [NSString stringWithFormat:@"Meal Time: %d Hour and %d Minutes", hour, minute];
                    else
                        string = [NSString stringWithFormat:@"Meal Time: %d Hour", hour];
                    cell.textLabel.text = string;
                }
                    break;
                case 2:
                    break;
                default:
                    break;
            }
            return cell;
    }
            break;
        case RestaurantMenu: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Menu" forIndexPath:indexPath];
            return cell;
        }
            break;
        case RestaurantComment: {
            CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment" forIndexPath:indexPath];
            if (cell == NULL) {
                NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:NULL];
                cell = cells[0];
            }
            NSDictionary *dict = comments[indexPath.row];
            cell.comment = dict[@"review"];
            cell.writer = dict[@"uid"];
            if (((NSNumber *)dict[@"star"]))
                cell.numberOfStar = ((NSNumber *)dict[@"star"]).intValue;
            else cell.numberOfStar = 0;
            return cell;
        }
            break;

        default:
            return NULL;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.infoType) {
        case RestaurantComment:
            return 130;
        default:
            return 44;
    }
}

//Collection View Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    switch (self.infoType) {
        case RestaurantPhoto:
            return 1;
        default:
            return 0;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (self.infoType) {
        case RestaurantPhoto:
            return 10;
        default:
            return 0;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (_type) {
        case RestaurantPhoto: {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Photo" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor blackColor];
            return cell;
        }
        default:
            return NULL;
    }
}

- (restaurantInfoType)infoType {
    return _type;
}
- (void)setInfoType:(restaurantInfoType)_infoType {
    _type = _infoType;
    switch (_type) {
        case RestaurantComment:
        case RestaurantGeneralInfo:
        case RestaurantMenu: {
            if (_type == RestaurantMenu)
                _infoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
            else _infoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
            [((UITableView *)_infoView) registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Info"];
            
            [((UITableView *)_infoView) registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Comment"];
            
            [((UITableView *)_infoView) registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Menu"];
            ((UITableView *)_infoView).dataSource = self;   ((UITableView *)_infoView).delegate = self;
        }
            break;
        case RestaurantPhoto: {
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.itemSize = CGSizeMake(80, 80);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            _infoView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) collectionViewLayout:layout];
            ((UICollectionView *)_infoView).dataSource = self;  ((UICollectionView *)_infoView).delegate = self;
            [((UICollectionView *)_infoView) registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Photo"];
            _infoView.backgroundColor = [UIColor whiteColor];
        }
            break;
        default:
            _infoView = NULL;
            break;
    }
    switch (_type) {
        case RestaurantComment:
            [self updateCommet:self];
            [((UITableView *)_infoView) reloadData];
            break;
        case RestaurantGeneralInfo:
        case RestaurantMenu:
            break;
        case RestaurantPhoto:
            break;
        default:
            break;
    }
    [_infoView layoutSubviews];
    switch (_type) {
        case RestaurantGeneralInfo:
            ((UITableView *)_infoView).separatorStyle = UITableViewCellSeparatorStyleNone;
        case RestaurantComment:
        case RestaurantMenu:
            _infoView.frame = CGRectMake(_infoView.frame.origin.x, _infoView.frame.origin.y, ((UITableView *)_infoView).contentSize.width, ((UITableView *)_infoView).contentSize.height);
            break;
        case RestaurantPhoto:
            _infoView.frame = CGRectMake(_infoView.frame.origin.x, _infoView.frame.origin.y, ((UICollectionView *)_infoView).contentSize.width, ((UICollectionView *)_infoView).contentSize.height);
            break;
        default:
            break;
    }
}
- (void)updateCommet:(id)sender {
    NSString *addr = [NSString stringWithFormat:CommentAddress, restaurant.sid];
    NSURL *commentURL = [NSURL URLWithString:addr];
    NSData *data = [NSData dataWithContentsOfURL:commentURL];
    comments = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
    [((UITableView *) _infoView) reloadData];
}
- (UIView *)infoView {
    return _infoView;
}
@end








