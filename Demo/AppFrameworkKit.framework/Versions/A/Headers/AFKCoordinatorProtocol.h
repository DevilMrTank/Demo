//
//  AFKCoordinatorProtocol.h
//  AppFrameworkKit
//
//  Created by mac on 2021/5/1.
//

#import <Foundation/Foundation.h>

@protocol AFKCoordinatorProtocol <NSObject>
@required

- (instancetype)initWithView:(id)view;

- (void)bindData:(id)viewModel;

@end
