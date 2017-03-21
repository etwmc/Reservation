//
//  MenuEntityTableViewCell.m
//  Reservation
//
//  Created by Wai Man Chan on 4/7/14.
//  Copyright (c) 2014 CHAN, Wai Man. All rights reserved.
//

#import "MenuEntityTableViewCell.h"

@interface MenuEntityTableViewCell () {
    Product *representObj;
}
@end

@implementation MenuEntityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.gestureRecognizers];
        [array addObject:longPress];
        [self setGestureRecognizers:array];
        UIView *selectionView = [[UIView alloc] initWithFrame:self.selectedBackgroundView.frame];
        selectionView.backgroundColor = [UIColor greenColor];
        self.selectedBackgroundView = selectionView;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)longPress:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Yep" message:@"That's right" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    int amount = [alertView textFieldAtIndex:0].text.intValue;
    representObj.quantity += amount;
}

- (Product *)representObj { return representObj; }
- (void)setRepresentObj:(Product *)_representObj {
    representObj = _representObj;
    self.textLabel.text = representObj.title;
    self.detailTextLabel.text = representObj.price.stringValue;
}

@end
