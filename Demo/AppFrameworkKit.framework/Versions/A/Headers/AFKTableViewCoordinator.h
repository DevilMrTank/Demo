//
//  AFKTableViewCoordinator.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.

//  tableView协调器的抽象基类，不能单独使用

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFKTableViewModelProtocol.h"
#import "AFKTableViewCellManager.h"

/**
 TableViewCoordinator (不需要Section Footer/Header 情况下使用)
 */
@interface AFKTableViewCoordinator : NSObject <UITableViewDelegate, UITableViewDataSource>

/**
 子类使用该类注册cell类型
 [self.cellManager registerClass:[CellView class] coordinatorClass:[CellCoordinator class] identifier:@"cellIdentifier"];
 */
@property (nonatomic, strong, readonly) AFKTableViewCellManager *cellManager;

@property (nonatomic, strong, readonly) UITableView *tableView;

/**
 tableView协调器，设置tableView的代理为该协调器，外部只需要创建无需设置代理

 @param tableView 实例化的tableView
 @return 实例
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 子类需要重写该接口，自定义ViewModel

 @return ViewModel实例
 */
- (id<AFKTableViewModelProtocol>)createViewModel;

@end
