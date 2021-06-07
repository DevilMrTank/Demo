//
//  UIResponder+AFKRouter.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <UIKit/UIKit.h>

@protocol AFKResponderObserveEventProtocol <NSObject>

/**
 事件响应拦截
 */
- (void)observeRouteEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end

@interface UIResponder (AFKRouter)

/**
 CD事件响应拦截需要设置该代理
 */
@property (nonatomic, weak) id<AFKResponderObserveEventProtocol> afk_observeEventDelegate;

/**
 抛出事件给上层响应
 */
- (void)afk_postRouteEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
