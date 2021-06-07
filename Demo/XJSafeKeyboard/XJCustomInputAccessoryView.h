//
//  XJCustomInputAccessoryView.h
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XJTextFieldConst.h"

typedef void(^XJCustomInputAccessoryViewChangeTypeBlock)(XJCustomKeyboardType type);

typedef void(^XJCustomInputAccessoryViewFinishBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface XJCustomInputAccessoryView : UIView

//左边切换按钮
@property (nonatomic, strong) UIButton *changeTypeButton;

//中间显示文字
@property (nonatomic, strong) UILabel *textLabel;

//右边完成按钮
@property (nonatomic, strong) UIButton *finishButton;

@property (nonatomic, copy) XJCustomInputAccessoryViewChangeTypeBlock changeTypeBlock;

@property (nonatomic, copy) XJCustomInputAccessoryViewFinishBlock finishBlock;

- (instancetype)initWithFrame:(CGRect)frame keyboardType:(XJCustomKeyboardType)type;



@end

NS_ASSUME_NONNULL_END
