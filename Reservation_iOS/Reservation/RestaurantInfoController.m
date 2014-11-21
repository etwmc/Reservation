//
//  RestaurantInfoController.m
//  Reservation
//
//  Created by Wai Man Chan on 2/24/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "RestaurantInfoController.h"

@interface RestaurantInfoController () {
    restaurantInfoType _type;
    UIView *_infoView;
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
            return 20;
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
                    cell.textLabel.text = [NSString stringWithFormat:@"Hour: %@-%@", [formatter stringFromDate:restaurant.openHour], [formatter stringFromDate:restaurant.closeHour]];
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
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment" forIndexPath:indexPath];
            return cell;
        }
            break;

        default:
            return NULL;
            break;
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
            _infoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
            [((UITableView *)_infoView) registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Info"];
            [((UITableView *)_infoView) registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Comment"];
            [((UITableView *)_infoView) registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Menu"];
            ((UITableView *)_infoView).dataSource = ((UITableView *)_infoView).delegate = self;
        }
            break;
        case RestaurantPhoto: {
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.itemSize = CGSizeMake(80, 80);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            _infoView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) collectionViewLayout:layout];
            ((UICollectionView *)_infoView).dataSource = ((UICollectionView *)_infoView).delegate = self;
            [((UICollectionView *)_infoView) registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Photo"];
            _infoView.backgroundColor = [UIColor redColor];
        }
            break;
        default:
            _infoView = NULL;
            break;
    }
}
- (UIView *)infoView {
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
    return _infoView;
}
@end








