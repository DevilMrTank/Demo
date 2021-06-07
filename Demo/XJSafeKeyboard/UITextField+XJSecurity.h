//
//  UITextField+XJSecurity.h
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (XJSecurity)

@property (nonatomic, copy) NSString *securityText;

@property (nonatomic, assign) BOOL isPlainText;

//刷新输入框的内容
- (void)refreshTextField;

@end

NS_ASSUME_NONNULL_END
