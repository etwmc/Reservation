//
//  CommentTableViewCell.m
//  Reservation
//
//  Created by Wai Man Chan on 4/2/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "ProjectConstant.h"

@implementation CommentTableViewCell
@synthesize comment, writer, numberOfStar;
- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setComment:(NSString *)_comment {
    comment = _comment;
    if (_comment&&[_comment isKindOfClass:[NSString class]])
        commentLabel.text = comment;
}
- (void)setWriter:(NSString *)_writer {
    NSString *fullAddr = [NSString stringWithFormat:UsernameFetchAddr, _writer];
    writerLabel.text = writer = [NSString stringWithContentsOfURL:[NSURL URLWithString:fullAddr] encoding:NSUTF8StringEncoding error:NULL];
    if (_writer)
        writerLabel.text = writer;
}
- (void)setNumberOfStar:(int)_numberOfStar {
#define thumbUp1 @"👍"
#define thumbUp2 @"👍👍"
#define thumbUp3 @"👍👍👍"
#define thumbUp4 @"👍👍👍👍"
#define thumbUp5 @"👍👍👍👍👍"
    switch (_numberOfStar) {
        case 1:
            thumbupLabel.text = thumbUp1;
            break;
        case 2:
            thumbupLabel.text = thumbUp2;
            break;
        case 3:
            thumbupLabel.text = thumbUp3;
            break;
        case 4:
            thumbupLabel.text = thumbUp4;
            break;
        case 5:
            thumbupLabel.text = thumbUp5;
            break;
    }
    numberOfStar = _numberOfStar;
}
@end
