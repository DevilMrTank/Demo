//
//  AFKSectionCollectionViewModelProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>

@protocol AFKCollectionViewModelProtocol;

/**
 SectionCollectionViewModel需要实现此协议
 */
@protocol AFKSectionCollectionViewModelProtocol <NSObject>
@required

- (NSMutableArray<id<AFKCollectionViewModelProtocol>> *)sectionViewModelList;

- (void)fetchData;

@end
