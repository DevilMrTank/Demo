//
//  XJCustomInputAccessoryView.m
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#import "XJCustomInputAccessoryView.h"

@interface XJCustomInputAccessoryView ()

@property (nonatomic, copy) NSArray *keyboardTitles;

@property (nonatomic, assign) XJCustomKeyboardType keyboardType;

@end

@implementation XJCustomInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame keyboardType:(XJCustomKeyboardType)type {
    if (self = [super initWithFrame:frame]) {
        self.keyboardType = type;
        self.backgroundColor = [UIColor blackColor];
        
        if (self.keyboardTitles.count) {
            [self.changeTypeButton setTitle:self.keyboardTitles[1] forState:UIControlStateNormal];
        }
        [self.finishButton setTitle:FINISH_STRING forState:UIControlStateNormal];
    }
    
    return self;
}

#pragma mark - Private
- (XJCustomKeyboardType)keyboardFromString:(NSString *)title {
    if ([title isEqualToString:KEYBOARD_TYPE_LETTER]) {
        return XJCustomKeyboardTypeLetter;
    } else if ([title isEqualToString:KEYBOARD_TYPE_CHARACTER]){
        return XJCustomKeyboardTypeCharacters;
    } else if ([title isEqualToString:KEYBOARD_TYPE_NUMBER]){
        return XJCustomKeyboardTypeNumber;
    } else if ([title isEqualToString:KEYBOARD_TYPE_DIGITAL]){
        return XJCustomKeyboardTypeDigital;
    } else{
        return XJCustomKeyboardTypeLetter;
    }
}
#pragma mark - Button Action
- (void)changeTypeAction:(UIButton *)sender{
    NSString *text = [sender titleForState:UIControlStateNormal];
    NSInteger idx = [self.keyboardTitles indexOfObject:text];
    NSInteger currentIdx = (idx +1) % self.keyboardTitles.count;
    [self.changeTypeButton setTitle:self.keyboardTitles[currentIdx] forState:UIControlStateNormal];
    if (self.changeTypeBlock) {
        self.changeTypeBlock([self keyboardFromString:text]);
    }
}

- (void)finishAction:(UIButton *)sender{
    if (self.finishBlock) {
        self.finishBlock();
    }
}

#pragma mark - Lazy load
- (UIButton *)changeTypeButton {
    if (!_changeTypeButton) {
        _changeTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeTypeButton.frame = CGRectMake(0, 0, 50, 40);
        [_changeTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _changeTypeButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_changeTypeButton addTarget:self action:@selector(changeTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_changeTypeButton];
    }
    
    return  _changeTypeButton;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel =[[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 200) / 2, 0, 200, CGRectGetHeight(self.bounds))];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    
    return _textLabel;
}

- (UIButton *)finishButton {
    if (!_finishButton) {
        _finishButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _finishButton.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-50, 0, 50, 40);
        [_finishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _finishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_finishButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_finishButton];
    }
 
    return _finishButton;
}

- (NSArray *)keyboardTitles {
    if (!_keyboardTitles) {
        NSMutableArray *titles = [NSMutableArray array];
        if (self.keyboardType & XJCustomKeyboardTypeNumber) {
            [titles addObject:KEYBOARD_TYPE_NUMBER];
        }
        if (self.keyboardType & XJCustomKeyboardTypeLetter) {
            [titles addObject:KEYBOARD_TYPE_LETTER];
        }
        if (self.keyboardType & XJCustomKeyboardTypeCharacters) {
            [titles addObject:KEYBOARD_TYPE_CHARACTER];
        }
        if (self.keyboardType & XJCustomKeyboardTypeDigital) {
            [titles addObject:KEYBOARD_TYPE_DIGITAL];
        }
        
        _keyboardTitles = [NSArray arrayWithArray:titles];
    }
    
    return _keyboardTitles;
}

@end
