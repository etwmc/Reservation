//
//  FoodTypeModel.h
//  Reservation
//
//  Created by CHAN, Wai Man on 19/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>

UIViewController *rootController;

@interface FoodTypeViewCell : UICollectionViewCell
@property (readonly) IBOutlet UILabel *title;
@property (readonly) IBOutlet UIImageView *backgroundView;
@end

@interface FoodTypeViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
}
@end
