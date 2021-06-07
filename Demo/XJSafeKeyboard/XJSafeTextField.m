//
//  XJSafeTextField.m
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#import "XJSafeTextField.h"

@interface XJSafeTextField ()

@end

@implementation XJSafeTextField

- (instancetype)init {
    if (self = [super init]) {
       
    }
    
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    return NO;
}

@end
