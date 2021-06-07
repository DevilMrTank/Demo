//
//  AFKCollectionViewCoordinator.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFKCollectionViewCellManager.h"
#import "AFKCollectionViewModelProtocol.h"

@interface AFKCollectionViewCoordinator : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

/**
 子类使用该类注册cell类型
 [self.cellManager registerClass:[CellView class] coordinatorClass:[CellCoordinator class] identifier:@"cellIdentifier"];
 */
@property (nonatomic, strong, readonly) AFKCollectionViewCellManager *cellManager;

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/**
 collectionView协调器，设置collectionView的代理为该协调器，外部只需要创建无需设置代理
 
 @param collectionView 实例化的collectionView
 @return 实例
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

/**
 子类需要重写该接口，注册cell
  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
 */
- (void)registerClass;

/**
 子类需要重写该接口，自定义ViewModel
 
 @return ViewModel实例
 */
- (id<AFKCollectionViewModelProtocol>)createViewModel;

@end
