//
//  AFKTableViewCellManager.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.

//  cell协调器管理类，cellCoordinator的实例与cell实例绑定

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFKTableViewCellCoordinatorProtocol.h"
#import "AFKCoordinatorProtocol.h"

@interface AFKTableViewCellManager : NSObject
/*
 根据cell的identifier 注册TableView的UITableViewCell类 与 对应的 coordinator 类
 
或 根据header/footer的identifier 注册TableView的Section UIView类 与 对应的 coordinator 类
 
 @param viewClass
 @param coordinatorClass
 @param identifier
 */
- (void)registerClass:(Class)viewClass coordinatorClass:(Class)coordinatorClass identifier:(NSString *)identifier;

/*
 根据cell的identifier 获取Section HeaderView/FooterView实例
 @param tableView
 @param identifier
 @return UIView实例
 */
- (UIView *)getTableViewHeaderFooterView:(UITableView *)tableView identifier:(NSString *)identifier;

/*
 根据cell的identifier 获取UITableViewCell实例
 @param tableView
 @param identifier
 @return UITableViewCell实例
 */
- (UITableViewCell *)getTableViewCell:(UITableView *)tableView identifier:(NSString *)identifier;

/**
 获取cell实例对应的cellCoordinator实例
 @param cell cell实例
 @param identifier 复用标识(不同的HeaderView/FooterView/cell切勿重复)
 @return cellCoordinator实例
 */
- (id<AFKTableViewCellCoordinatorProtocol>)getCoordinatorWithCell:(UITableViewCell *)cell identifier:(NSString *)identifier;

/**
 获取HeaderView/FooterView实例对应的coordinator实例
 @param headerFooterView HeaderView/FooterView实例
 @param identifier 复用标识(不同的HeaderView/FooterView/cell切勿重复)
 @return cellCoordinator实例
 */
- (id<AFKCoordinatorProtocol>)getCoordinatorWithHeaderFooterView:(UIView *)headerFooterView identifier:(NSString *)identifier;
@end
