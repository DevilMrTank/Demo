//
//  AFKCollectionViewCellCoordinatorProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>
#import "AFKCollectionViewCellViewModelProtocol.h"

/**
 CollectionViewCellCoordinator(包括Header/Footer)需要实现此协议
 */
@protocol AFKCollectionViewCellCoordinatorProtocol <NSObject>
@required

- (instancetype)initWithCellView:(id)cell;

- (void)bindData:(id<AFKCollectionViewCellViewModelProtocol>)cellViewModel;

- (void)didSelectCellView;

@end
