//
//  XJCustomKeyboardView.h
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XJTextFieldConst.h"
#import "XJCustomInputAccessoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XJCustomKeyboardView : UIView <UIInputViewAudioFeedback>

//背景颜色
@property (nonatomic, strong) UIColor *keyboardBackgroundColor;
//键盘背景颜色
@property (nonatomic, strong) UIColor *keyboardItemColor;
//键盘背景深色 特殊按钮背景色
@property (nonatomic, strong) UIColor *cuItemDarkColor;
//键盘颜色
@property (nonatomic, strong) UIColor *cuKeyColor;
//字体
@property (nonatomic, strong) UIFont *cuKeyFont;
//accessoryColor
@property (nonatomic, strong) UIColor *accessoryColor;
//accessoryFont
@property (nonatomic, strong) UIFont *accessoryFont;

/**
 实例方法

 @param view textField
 @param keyboardType 键盘
 @param random 是否随机
 @return 实例
 */
+ (instancetype)configWithView:(UIView<UIKeyInput> *)view
                  keyboardType:(XJCustomKeyboardType)keyboardType
                        random:(BOOL)random;

/**
 实例方法

 @param view textField
 @param keyboardType 键盘
 @param random 是否随机
 @param title 键盘标题
 @return 实例
 */
+ (instancetype)configWithView:(UIView<UIKeyInput> *)view
                  keyboardType:(XJCustomKeyboardType)keyboardType
                        random:(BOOL)random
                         title:(NSString *)title;

/**
 实例方法

 @param view textField
 @param keyboardType 键盘
 @param random 是否随机
 @param title 键盘标题
 @param length 是否限制长度,不限制传-1
 @return 实例
 */
+ (instancetype)configWithView:(UIView<UIKeyInput> *)view
                  keyboardType:(XJCustomKeyboardType)keyboardType
                        random:(BOOL)random
                         title:(NSString *)title
                        length:(NSInteger)length;
@end

NS_ASSUME_NONNULL_END
