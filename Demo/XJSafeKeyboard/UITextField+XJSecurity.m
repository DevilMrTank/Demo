//
//  UITextField+XJSecurity.m
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#import "UITextField+XJSecurity.h"
#import "XJTextFieldConst.h"

#import <objc/runtime.h>

static const void *xjSecurityKey = &xjSecurityKey;
static const void *xjIsPlainKey = &xjIsPlainKey;

@implementation UITextField (XJSecurity)

#pragma mark - Setter & Getter
- (void)setSecurityText:(NSString *)securityText {
    objc_setAssociatedObject(self, xjSecurityKey, securityText, OBJC_ASSOCIATION_COPY);
}

- (NSString *)securityText {
    
    NSString *string = objc_getAssociatedObject(self, xjSecurityKey);
    NSLog(@"securityText = %@", string);
    if (!string || string.length == 0) {
        
        return @"";
    }
    
    return  string;
}

- (void)setIsPlainText:(BOOL)isPlainText {
    objc_setAssociatedObject(self, xjIsPlainKey, @(isPlainText), OBJC_ASSOCIATION_ASSIGN);
    
    [self refreshTextField];
}

- (BOOL)isPlainText {
    
    NSNumber *num = objc_getAssociatedObject(self, xjIsPlainKey);
    
    return [num boolValue];
}

#pragma mark - 添加或删除之后，必须刷新一下，否则显示会有问题
- (void)refreshTextField {
    BOOL flag = self.isPlainText;
    if (flag) {
        self.text = self.securityText;
    } else {
        NSMutableString *string = [NSMutableString stringWithString:@""];
        for (NSInteger idx = 0 ; idx < self.securityText.length; idx++) {
            [string appendString:ASTERISK];
        }
        self.text = string;
    }
}

@end
