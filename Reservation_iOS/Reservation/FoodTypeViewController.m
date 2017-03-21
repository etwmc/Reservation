//
//  FoodTypeModel.m
//  Reservation
//
//  Created by CHAN, Wai Man on 19/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "FoodTypeViewController.h"
#import "RestaurantList_Reservation.h"
#import "CurrentOrderModel.h"
#import "LoadingViewController.h"
#import "ProjectConstant.h"

#import "Multithread.h"

@interface NSData (cachedData)
+ (NSData*)dataCachedWithContentsOfURL:(NSURL *)url;
@end
@implementation NSData (cachedData)
+ (NSData*)dataCachedWithContentsOfURL:(NSURL *)url {
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:&error];
    if (error) {
#if DEBUG
        NSLog(@"Data cached download failed: %@", error);
#endif
        return nil;
    }
    return data;
}
@end

@interface UIImage (URLImage)
+ (UIImage*) retinaImage: (NSURL*) url;
@end

@implementation UIImage (URLImage)
+ (UIImage*) retinaImage: (NSURL*)url {
    NSString *urlStr = url.absoluteString;
    for (int scale = [UIScreen mainScreen].scale; scale > 1; scale--) {
        NSString *lastComponenet = urlStr.lastPathComponent.stringByDeletingPathExtension;
        NSString *pathExt = urlStr.pathExtension;
        NSString *root = urlStr.stringByDeletingLastPathComponent;
        NSString *newURL = [NSString stringWithFormat:@"%@/%@\@%dx.%@", root, lastComponenet, scale, pathExt];
        NSURL *url = [NSURL URLWithString:newURL];
        NSData *data = [NSData dataCachedWithContentsOfURL:url];
        
        if (data == nil) {
            NSLog(@"Failed to load data from URL: %@", urlStr);
            
            return nil;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        //Resample the image to be for retina
        return [UIImage imageWithCGImage:[image CGImage]
                                   scale:scale
                             orientation:UIImageOrientationUp];
        
    }
    
    NSData *data = [NSData dataCachedWithContentsOfURL:url];
    
    if (data == nil) {
        NSLog(@"Failed to load data from URL: %@", urlStr);
        
        return nil;
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    //Resample the image to be for retina
    return [UIImage imageWithCGImage:[image CGImage]
                               scale:[UIScreen mainScreen].scale
                         orientation:UIImageOrientationUp];
    
    
}
@end

@implementation FoodTypeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"Réservation";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    rootController = self;
    CurrentOrderModel *model = [CurrentOrderModel shareModel];
    [model description];
}

- (NSArray *)listOfFoodStyle {
    static NSArray *styles = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[LoadingViewController shareController] startLoading];
        NSURL *url = [NSURL URLWithString:CompanyTypeAddress];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
            if (tempArray.count > 0) {
                NSMutableArray *container = [NSMutableArray new];
                for (NSArray *array in tempArray) {
                    [container addObject:array[1]];
                }
                styles = [NSArray arrayWithArray:container];
            }
        }
        if (styles.count == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Failed" message:@"I can't connect to the server. Please check your network" delegate:NULL cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        [[LoadingViewController shareController] stopLoading];
        [self.collectionView reloadData];
    });
    
    return styles;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self listOfFoodStyle].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodTypeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Style" forIndexPath:indexPath];
    if (cell) {
        NSString *name = [self listOfFoodStyle][indexPath.row];
        
        cell.layer.bounds = cell.bounds;
        cell.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        cell.layer.borderWidth = 3;
        cell.title.text = NSLocalizedString(name, @"Localize food style").capitalizedString;
        //[cell addSubview:textView];
        
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:subTypeImageAddress, indexPath.row+1]];
        dispatch_async([Multithread onlineQueryThread], ^{
            UIImage *image = [UIImage retinaImage:imageURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.backgroundView.image = image;
                cell.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
            });
        });
        
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender) {
        UIViewController *con = (UIViewController *)segue.destinationViewController;
        NSIndexPath *path = [self.collectionView indexPathForCell:sender];
        con.title = [self listOfFoodStyle][path.row];
        ((RestaurantList_Reservation *)con).foodType = path;
    }
}

@end


@implementation FoodTypeViewCell
@synthesize title;
@end