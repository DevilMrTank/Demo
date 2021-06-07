//
//  AFKCollectionViewCellViewModelProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 CollectionViewCellViewModel(包括Header/Footer)需要实现此协议
 */
@protocol AFKCollectionViewCellViewModelProtocol <NSObject>
@required

- (NSString *)identifier;

@end
