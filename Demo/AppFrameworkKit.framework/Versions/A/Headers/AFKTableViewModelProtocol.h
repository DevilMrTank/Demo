//
//  AFKTableViewModelProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AFKTableViewCellViewModelProtocol;

/**
 TableViewModel需要实现此协议
 */
@protocol AFKTableViewModelProtocol <NSObject>
@required

- (NSMutableArray <id<AFKTableViewCellViewModelProtocol>> *)cellViewModelList;

- (void)fetchData;

@optional

//不需要Section的header则无需实现
- (id<AFKTableViewCellViewModelProtocol>)headerCellViewModel;

//不需要Section的footer则无需实现
- (id<AFKTableViewCellViewModelProtocol>)footerCellViewModel;

@end
