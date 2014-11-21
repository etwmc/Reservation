//
//  FoodTypeModel.m
//  Reservation
//
//  Created by CHAN, Wai Man on 19/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "FoodTypeViewController.h"

@implementation FoodTypeViewController

- (NSArray *)listOfFoodStyle {
    return @[@"Chinese", @"French", @"German", @"Indonesia", @"Italian", @"Japanese", @"Korean", @"Malaysia", @"Middleeast", @"Tailand", @"Taiwan", @"Vietnams"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self listOfFoodStyle].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Style" forIndexPath:indexPath];
    if (cell) {
        NSString *name = [self listOfFoodStyle][indexPath.row];
        UIImageView *view = [[UIImageView alloc] initWithFrame:cell.bounds];
        view.image = [UIImage imageNamed:name.lowercaseString];
        [cell addSubview:view];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender) {
        UIViewController *con = (UIViewController *)segue.destinationViewController;
        NSIndexPath *path = [self.collectionView indexPathForCell:sender];
        con.title = [self listOfFoodStyle][path.row];
    }
}

@end
