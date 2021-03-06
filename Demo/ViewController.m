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

//??????

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
//        //???????????????item ??????????????????
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
//        //1??????????????????
//
//        MKDirectionsRequest*request=[[MKDirectionsRequest alloc]init];
//
//        //??????????????????
//
//        request.source=userItem;
//
//        request.destination=destinationItem;
//
//        //?????????????????????
//
//        MKDirections *direction=[[MKDirections alloc]initWithRequest:request];
//
//        //??????
//
//        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
//
//            for (MKRoute*route in response.routes) {
//
//                //?????????
//
//                MKPolyline *line=route.polyline;
//
//                //???????????????
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
//    //???????????????
//
//    MKPolylineRenderer *render=[[MKPolylineRenderer alloc]initWithOverlay:overlay];
//
//    //?????????????????????
//
//    render.strokeColor=[UIColor redColor];
//
//    //????????????
//
//    render.lineWidth=5;
//
//    return render;
//
//}
//
//
//
////??????polyline??????????????????
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
////    //????????????????????????????????????
////    [self.mapView removeAnnotations:_mapAnnotations];
////    [_mapAnnotations removeAllObjects];
////    [_carPointArray removeAllObjects];
//    //??????????????????????????????????????????????????????????????????????????????????????????????????????
//    CLLocationDegrees minLat = self.coordinate.latitude >= self.coordinate2.latitude ? self.coordinate2.latitude : self.coordinate.latitude;
//    CLLocationDegrees maxLat = self.coordinate.latitude >= self.coordinate2.latitude ? self.coordinate.latitude : self.coordinate2.latitude;
//    CLLocationDegrees minLon = self.coordinate.longitude >= self.coordinate2.longitude ? self.coordinate2.longitude : self.coordinate.longitude;
//    CLLocationDegrees maxLon = self.coordinate.longitude >= self.coordinate2.longitude ? self.coordinate.longitude : self.coordinate2.longitude;
//    //???????????????
//        CLLocationCoordinate2D centCoor;
//        centCoor.latitude = (CLLocationDegrees)((maxLat+minLat) * 0.5f);
//        centCoor.longitude = (CLLocationDegrees)((maxLon+minLon) * 0.5f);
//        MKCoordinateSpan span;
//        //???????????????????????????
//        span.latitudeDelta = maxLat - minLat + 0.03;
//        span.longitudeDelta = maxLon - minLon + 0.03;
//        //???????????????????????????
//        MKCoordinateRegion region = MKCoordinateRegionMake(centCoor, span);
//    [self.mapView setRegion:region];
////    [self.mapView setvi]
//        //?????????????????????????????????????????????????????????
////        CGRect fitRect = [self.mapView convertRegion:region toRectToView:self.mapView];
////        //????????????????????????????????????????????????
////    [self.mapView conver]
////        MKMapRect fitMapRect = [self.mapView convertRect:fitRect toMapRectFromView:self.mapView];
////        //??????????????????????????????????????????????????????
////        [self.mapView  setVisibleMapRect:fitMapRect animated:YES];
//}
//
//#pragma mark - MKMapViewDelegate
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    //??????????????????
//    static NSString * inden = @"anno";
//    MKAnnotationView * pin =[mapView dequeueReusableAnnotationViewWithIdentifier:inden];
//    if (pin == nil) {
//        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:inden];
//    }
//    pin.annotation = annotation;
//    //????????????????????????
//    pin.canShowCallout = YES;
//    pin.image = [UIImage imageNamed:@"AppIcon"];
//
//    //??????????????????
//    return pin;
//}
 

@end
