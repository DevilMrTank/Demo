//
//  ViewController.m
//  Demo
//
//  Created by APPLE on 2021/6/2.
//

#import "ViewController.h"
#import "XJTrackView.h"
#import "XJTrackModel.h"

#import "XJCustomKeyboardView.h"
#import "XJSafeTextField.h"
#import "UITextField+XJSecurity.h"

#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>

@interface ViewController ()<MKMapViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong)UITextField*destination;

@property(nonatomic,strong)MKMapView*mapView;

@property(nonatomic,strong)CLLocationManager *mgr;

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

@property (nonatomic,assign) CLLocationCoordinate2D coordinate2;

@property (nonatomic, strong) XJTrackView *trackView;

@property (nonatomic, strong) XJSafeTextField *safeTextField;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self safeKeyboard];
    return;
    
    XJTrackModel *originModel = [[XJTrackModel alloc] init];
    XJTrackModel *destModel = [[XJTrackModel alloc] init];
    self.coordinate = CLLocationCoordinate2DMake(26.10083, 119.288162);
    self.coordinate2 = CLLocationCoordinate2DMake(26.435790794674897, 119.65610907446289);

    originModel.coordinate = self.coordinate;
    destModel.coordinate = self.coordinate2;
    
    self.trackView = [[XJTrackView alloc] initWithOriginTrackModel:originModel destinationTrackModel:destModel];
    
    [self.view addSubview:self.trackView];
    
    [self.trackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(500);
    }];
    
    return;
}


- (void)safeKeyboard {
    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds);
    _safeTextField = [[XJSafeTextField alloc] initWithFrame:CGRectMake((w -200)/2, 250, 200, 40)];
    _safeTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_safeTextField];
    _safeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    XJCustomKeyboardView *keyboardView = [XJCustomKeyboardView configWithView:_safeTextField
                                                               keyboardType:XJCustomKeyboardTypeAll
                                                                     random:YES];
    _safeTextField.isPlainText = NO;
    keyboardView.cuKeyFont = [UIFont systemFontOfSize:16 weight:(UIFontWeightHeavy)];
    keyboardView.accessoryColor = [UIColor blackColor];
    keyboardView.accessoryFont = [UIFont systemFontOfSize:16 weight:(UIFontWeightRegular)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 300, 40, 40);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
}

-(void)click:(UIButton *)btn{
    [self.view endEditing:YES];
    btn.selected =!btn.selected;
    self.safeTextField.isPlainText = btn.selected;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}

//划线

//-(void)drawLine
//
//{
//
//    [self.view endEditing:YES];
//
//    CLGeocoder *geo=[[CLGeocoder alloc]init];
//
//    [geo geocodeAddressString:self.destination.text completionHandler:^(NSArray *placemarks, NSError *error) {
//
//        if (placemarks.count==0||error) {
//
//            return ;
//
//        }
//
//        //获取目的地item 和当前的位置
//
//        CLPlacemark *pm=[placemarks firstObject];
//
//        MKPlacemark *mkp=[[MKPlacemark alloc]initWithPlacemark:pm];
//
////        MKMapItem *destinationItem=[[MKMapItem alloc]initWithPlacemark:mkp];
//
//
//
//        MKMapItem *userItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate2 addressDictionary:nil]];
//
//        MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
//
//
//
//
////        MKMapItem *userItem=[MKMapItem mapItemForCurrentLocation];
//
//
//
//        //1创建路线请求
//
//        MKDirectionsRequest*request=[[MKDirectionsRequest alloc]init];
//
//        //设置起点终点
//
//        request.source=userItem;
//
//        request.destination=destinationItem;
//
//        //创建路线管理器
//
//        MKDirections *direction=[[MKDirections alloc]initWithRequest:request];
//
//        //划线
//
//        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
//
//            for (MKRoute*route in response.routes) {
//
//                //拿到线
//
//                MKPolyline *line=route.polyline;
//
//                //添加到地图
//
//                [self.mapView addOverlay:line];
//
//                [self calculateZoomLevel];
//            }
//
//        }];
//
//    }];
//
//}
//
//
//-(MKOverlayRenderer*)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
//
//{
//
//    //创建渲染器
//
//    MKPolylineRenderer *render=[[MKPolylineRenderer alloc]initWithOverlay:overlay];
//
//    //设置线段的颜色
//
//    render.strokeColor=[UIColor redColor];
//
//    //设置线宽
//
//    render.lineWidth=5;
//
//    return render;
//
//}
//
//
//
////根据polyline设置地图范围
////- (void)mapViewFitPolyLine:(MKRoute *) route {
////    CGFloat ltX, ltY, rbX, rbY;
////    MKPolyline *polyLine=route.polyline;
////    if (polyLine.pointCount < 1) {
////        return;
////    }
////    MKPolyline *line = route.steps[0];
////    MKMapPoint *pt = line.;
////    ltX = pt->x, ltY = pt->y;
////    rbX = pt->x, rbY = pt->y;
////    for (int i = 1; i < polyLine.pointCount; i++) {
////        MKMapPoint pt = polyLine.points[i];
////        if (pt.x < ltX) {
////            ltX = pt.x;
////        }
////        if (pt.x > rbX) {
////            rbX = pt.x;
////        }
////        if (pt.y > ltY) {
////            ltY = pt.y;
////        }
////        if (pt.y < rbY) {
////            rbY = pt.y;
////        }
////    }
////    MKMapRect rect;
////    rect.origin = MKMapPointMake(ltX , ltY);
////    rect.size = MKMapSizeMake(rbX - ltX, rbY - ltY);
////    [_mapView setVisibleMapRect:rect];
////    [self calculateZoomLevel];
//////    _mapView.showsScale = _mapView.showsScale - 0.3;
////}
//
//
//
//- (void)calculateZoomLevel {
////    //清理坐标数据的视图和数据
////    [self.mapView removeAnnotations:_mapAnnotations];
////    [_mapAnnotations removeAllObjects];
////    [_carPointArray removeAllObjects];
//    //声明解析时对坐标数据的位置区域的筛选，包括经度和纬度的最小值和最大值
//    CLLocationDegrees minLat = self.coordinate.latitude >= self.coordinate2.latitude ? self.coordinate2.latitude : self.coordinate.latitude;
//    CLLocationDegrees maxLat = self.coordinate.latitude >= self.coordinate2.latitude ? self.coordinate.latitude : self.coordinate2.latitude;
//    CLLocationDegrees minLon = self.coordinate.longitude >= self.coordinate2.longitude ? self.coordinate2.longitude : self.coordinate.longitude;
//    CLLocationDegrees maxLon = self.coordinate.longitude >= self.coordinate2.longitude ? self.coordinate.longitude : self.coordinate2.longitude;
//    //计算中心点
//        CLLocationCoordinate2D centCoor;
//        centCoor.latitude = (CLLocationDegrees)((maxLat+minLat) * 0.5f);
//        centCoor.longitude = (CLLocationDegrees)((maxLon+minLon) * 0.5f);
//        MKCoordinateSpan span;
//        //计算地理位置的跨度
//        span.latitudeDelta = maxLat - minLat + 0.03;
//        span.longitudeDelta = maxLon - minLon + 0.03;
//        //得出数据的坐标区域
//        MKCoordinateRegion region = MKCoordinateRegionMake(centCoor, span);
//    [self.mapView setRegion:region];
////    [self.mapView setvi]
//        //百度地图的坐标范围转换成相对视图的位置
////        CGRect fitRect = [self.mapView convertRegion:region toRectToView:self.mapView];
////        //将地图视图的位置转换成地图的位置
////    [self.mapView conver]
////        MKMapRect fitMapRect = [self.mapView convertRect:fitRect toMapRectFromView:self.mapView];
////        //设置地图可视范围为数据所在的地图位置
////        [self.mapView  setVisibleMapRect:fitMapRect animated:YES];
//}
//
//#pragma mark - MKMapViewDelegate
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    //直接使用父类
//    static NSString * inden = @"anno";
//    MKAnnotationView * pin =[mapView dequeueReusableAnnotationViewWithIdentifier:inden];
//    if (pin == nil) {
//        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:inden];
//    }
//    pin.annotation = annotation;
//    //设置是否弹出标注
//    pin.canShowCallout = YES;
//    pin.image = [UIImage imageNamed:@"AppIcon"];
//
//    //标注左右视图
//    return pin;
//}
 

@end
