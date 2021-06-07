//
//  AFKTableViewCellCoordinatorProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>
#import "AFKTableViewCellViewModelProtocol.h"

/**
 TableViewCellCoordinator(包括Header/Footer)需要实现此协议
 */
@protocol AFKTableViewCellCoordinatorProtocol <NSObject>
@required

- (instancetype)initWithCellView:(id)cell;

- (void)bindData:(id<AFKTableViewCellViewModelProtocol>)cellViewModel;

- (void)didSelectCellView;

@end
