//
//  AFKCollectionViewModelProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AFKCollectionViewCellViewModelProtocol;

/**
 CollectionViewModel需要实现此协议
 */
@protocol AFKCollectionViewModelProtocol <NSObject>
@required

- (NSMutableArray <id<AFKCollectionViewCellViewModelProtocol>> *)cellViewModelList;

- (void)fetchData;

@optional

//不需要Section的header则无需实现
- (id<AFKCollectionViewCellViewModelProtocol>)headerCellViewModel;

//不需要Section的footer则无需实现
- (id<AFKCollectionViewCellViewModelProtocol>)footerCellViewModel;

@end
