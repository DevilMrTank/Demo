//
//  UIView+AFKContext.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <UIKit/UIKit.h>

@protocol AFKContextProtocol <NSObject>

- (UIViewController *)controller;

- (instancetype)initWithViewController:(UIViewController *)controller;

@end

@interface UIView (AFKContext)

@property (nonatomic, strong) id<AFKContextProtocol> afk_context;

@end
