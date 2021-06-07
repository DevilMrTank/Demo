//
//  AFKSectionTableViewModelProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>

@protocol AFKTableViewModelProtocol;

/**
 SectionTableViewModel需要实现此协议
 */
@protocol AFKSectionTableViewModelProtocol <NSObject>
@required

- (NSMutableArray<id<AFKTableViewModelProtocol>> *)sectionViewModelList;

- (void)fetchData;

@end
