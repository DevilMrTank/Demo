//
//  XJKeyboardCollectionViewCell.m
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#import "XJKeyboardCollectionViewCell.h"
#import "XJTextFieldConst.h"

@implementation XJKeyboardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor darkTextColor];
        _textLabel = [[UILabel alloc] init];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_textLabel];
        NSArray *constraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)];
        NSArray *constraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)];
        [self addConstraints:constraints1];
        [self addConstraints:constraints2];
        self.textLabel.textColor = KEYBOARD_KEY_COLOR;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2.5;
    }
    
    return self;
}
@end
