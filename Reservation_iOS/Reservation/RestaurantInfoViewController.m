//
//  RestaurantInfoViewController.m
//  Reservation
//
//  Created by Wai Man Chan on 2014/2/21.
//  Copyright (c) 2014年 CHAN, Wai Man. All rights reserved.
//

#import "RestaurantInfoViewController.h"
#import "RestaurantInfoController.h"

@interface RestaurantInfoViewController () {
    RestaurantInfoController *con;
    Restaurant *_restaurant;
    Appoinment *_appoinment;
}
@end

@implementation RestaurantInfoViewController

- (void)setAppoinment:(Appoinment *)appoinment {
    _appoinment = appoinment;
    self.restaurant = appoinment.restaurant;
}
- (Appoinment *)appoinment { return _appoinment; }
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    con = [RestaurantInfoController new];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_appoinment) self.basicInfoCon.appoinment = _appoinment;
    self.basicInfoCon.restaurant = self.restaurant;
    self.basicInfoCon.mainView = self;
}

- (void)viewDidAppear:(BOOL)animated {
    con.restaurant = _restaurant;
    con.infoType = RestaurantGeneralInfo;
    UIView *view = con.infoView;
    self.additionInfoView.frame = CGRectMake(self.additionInfoView.frame.origin.x, self.additionInfoView.frame.origin.y, 320, view.frame.size.height);
    [self.additionInfoView addSubview:view];
    ((UIScrollView *)self.view).contentSize = CGSizeMake(320, view.frame.size.height+265);
    CGRect rect = self.additionInfoView.frame;
    self.additionInfoView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 2000);
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)modeChange:(id)sender {
    if (self.additionInfoView.subviews.count)[[self.additionInfoView subviews][0] removeFromSuperview];
    NSInteger mode = ((UISegmentedControl *) sender).selectedSegmentIndex;
    switch (mode) {
        case 0:
            con.infoType = RestaurantGeneralInfo;
            break;
        case 1:
            con.infoType = RestaurantMenu;
            break;
        case 2:
            con.infoType = RestaurantPhoto;
            break;
        case 3:
            con.infoType = RestaurantComment;
            break;
    }
    UIView *view = con.infoView;
    self.additionInfoView.frame = CGRectMake(self.additionInfoView.frame.origin.x, self.additionInfoView.frame.origin.y, 320, view.frame.size.height);
    [self.additionInfoView addSubview:view];
    ((UIScrollView *)self.view).contentSize = CGSizeMake(320, view.frame.size.height+265);
    
}

- (Restaurant *)restaurant {
    return _restaurant;
}
- (void)setRestaurant:(Restaurant *)restaurant {
    _restaurant = restaurant;
    con.restaurant = _restaurant;
}
@end
