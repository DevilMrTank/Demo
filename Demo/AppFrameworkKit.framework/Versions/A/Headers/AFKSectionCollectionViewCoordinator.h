//
//  AFKSectionCollectionViewCoordinator.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.

//  CollectionView协调器的抽象基类，不能单独使用

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFKSectionCollectionViewModelProtocol.h"
#import "AFKCollectionViewCellManager.h"

/**
 SectionCollectionViewCoordinator (需要Section Footer/Header 情况下使用)
 */
@interface AFKSectionCollectionViewCoordinator : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

/**
 子类使用该类注册cell类型
 //cell
 [self.cellManager registerCellClass:[CellView class] coordinatorClass:[CellCoordinator class] identifier:@"cellIdentifier" collectionView: self.collectionView];
 //header
 [self.cellManager registerHeaderClass:[CellView class] coordinatorClass:[CellCoordinator class] identifier:@"cellIdentifier" collectionView: self.collectionView];
 //footer
 [self.cellManager registerFooterClass:[CellView class] coordinatorClass:[CellCoordinator class] identifier:@"cellIdentifier" collectionView: self.collectionView];
 */
@property (nonatomic, strong, readonly) AFKCollectionViewCellManager *cellManager;

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/**
 CollectionView协调器，设置CollectionView的代理为该协调器，外部只需要创建无需设置代理

 @param CollectionView 实例化的CollectionView
 @return 实例
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

/**
 子类需要重写该接口，自定义ViewModel

 @return ViewModel实例
 */
- (id<AFKSectionCollectionViewModelProtocol>)createViewModel;

@end
