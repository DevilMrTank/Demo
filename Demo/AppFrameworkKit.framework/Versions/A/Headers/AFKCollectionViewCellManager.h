//
//  AFKCollectionViewCellManager.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFKCollectionViewCellCoordinatorProtocol.h"
#import "AFKCoordinatorProtocol.h"

@interface AFKCollectionViewCellManager : NSObject

/*
 根据cell的identifier 注册CollectionView的UICollectionViewCell类 与 对应的 coordinator 类
 @param viewClass
 @param coordinatorClass
 @param identifier
 */
- (void)registerCellClass:(Class)viewClass coordinatorClass:(Class)coordinatorClass identifier:(NSString *)identifier collectionView:(UICollectionView *)collectionView;

/*
 根据header的identifier 注册CollectionView的header类 与 对应的 coordinator 类
 @param viewClass
 @param coordinatorClass
 @param identifier
 */
- (void)registerHeaderClass:(Class)viewClass coordinatorClass:(Class)coordinatorClass identifier:(NSString *)identifier collectionView:(UICollectionView *)collectionView;

/*
 根据footer的identifier 注册CollectionView的footer类 与 对应的 coordinator 类
 @param viewClass
 @param coordinatorClass
 @param identifier
 */
- (void)registerFooterClass:(Class)viewClass coordinatorClass:(Class)coordinatorClass identifier:(NSString *)identifier collectionView:(UICollectionView *)collectionView;


/**
 获取cell实例对应的cellCoordinator实例
 @param cell cell实例
 @param identifier 复用标识(不同的HeaderView/FooterView/cell切勿重复)
 @return cellCoordinator实例
 */
- (id<AFKCollectionViewCellCoordinatorProtocol>)getCoordinatorWithCell:(UICollectionViewCell *)cell identifier:(NSString *)identifier;

/**
 获取HeaderView/FooterView实例对应的coordinator实例
 @param headerFooterView HeaderView/FooterView实例
 @param identifier 复用标识(不同的HeaderView/FooterView/cell切勿重复)
 @return cellCoordinator实例
 */
- (id<AFKCoordinatorProtocol>)getCoordinatorWithHeaderFooterView:(UIView *)headerFooterView identifier:(NSString *)identifier;


@end

