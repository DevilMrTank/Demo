//
//  AFKTableViewCellViewModelProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 TableViewCellViewModel(包括Header/Footer)需要实现此协议
 */
@protocol AFKTableViewCellViewModelProtocol <NSObject>
@required

- (NSString *)identifier;

- (CGFloat)cellHeight;

@end
