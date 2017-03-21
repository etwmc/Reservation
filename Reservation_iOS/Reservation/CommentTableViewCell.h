//
//  CommentTableViewCell.h
//  Reservation
//
//  Created by Wai Man Chan on 4/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell {
    IBOutlet UILabel *commentLabel, *writerLabel;
    IBOutlet UILabel *thumbupLabel;
}
@property (readwrite, nonatomic) NSString *comment;
@property (readwrite, nonatomic) NSString *writer;
@property (readwrite, nonatomic) int numberOfStar;
@end
