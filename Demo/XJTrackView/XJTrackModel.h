//
//  XJTrackModel.h
//  Demo
//
//  Created by APPLE on 2021/6/3.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XJTrackModel : NSObject <NSCopying>
//坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//正标题
@property (nonatomic, copy, nullable) NSString *title;
//副标题
@property (nonatomic, copy, nullable) NSString *subtitle;
//图标名称
@property (nonatomic, copy, nullable) NSString *icon;

@end

NS_ASSUME_NONNULL_END
