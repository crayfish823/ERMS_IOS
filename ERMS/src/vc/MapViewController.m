//
//  MapViewController.m
//  ERMS
//
//  Created by tangtang on 2018/8/5.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "MapViewController.h"
#import "DeviceViewController.h"
#import "DocumentViewController.h"
#import "MyLayout.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import "TTUtils.h"
#import "Colors.h"
#import "Const.h"
#import "UIColor+Hex.h"
#import "UserDefaultUtil.h"
@interface MapViewController ()

@property NSArray *data;
@property int count;
@property BMKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 0;
    self.navigationItem.title = @"地图";
    self.tabBarController.tabBar.hidden = YES;
    
    // Do any additional setup after loading the view.
    MyRelativeLayout *contentAll = [MyRelativeLayout new];
    contentAll.backgroundColor  = [UIColor whiteColor];
    self.view = contentAll;
    
    _mapView = [BMKMapView new];
    _mapView.backgroundColor = [UIColor greenColor];
    _mapView.myWidth = SCREEN_WIDTH;
    _mapView.myHeight = SCREEN_HEIGHT;
    _mapView.leftPos.equalTo(contentAll.leftPos);
    _mapView.rightPos.equalTo(contentAll.rightPos);
    _mapView.topPos.equalTo(contentAll.topPos);
    _mapView.bottomPos.equalTo(contentAll.bottomPos);
    _mapView.delegate = self;
    [contentAll addSubview:_mapView];
    
    _mapView.zoomLevel = 8;
    [self getData];
   
}
-(void)getData{
    
    
    NSArray *array = [TTUtils stringToJSON:[UserDefaultUtil getData:LOGIN_ROLES]];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:array forKey:@"ids"];
    
    [self httpRequest:param methord:HTTP_PROJECTS httpResponsBack:^(NSArray *httpBack) {
        
        if (httpBack != nil) {
            self.data = httpBack;
            
            for (NSDictionary *dic in self.data) {
                BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake([dic[@"latitude"] doubleValue], [dic[@"Iongitude"] doubleValue]);
      
                [self.mapView addAnnotation:pointAnnotation];
                [self.mapView selectAnnotation:pointAnnotation animated:YES];
            }
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//地图自定义图标
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
//    {
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//        BMKAnnotationView *annotationView = (BMKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation
//                                                           reuseIdentifier:reuseIndetifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"image_map_point"];
//        return annotationView;
//    }
//    return nil;
    
    
    //
    NSString *AnnotationViewID = [NSString stringWithFormat:@"renameMark"];
    
    BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    // 设置颜色
    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
    // 设置可拖拽
    ((BMKPinAnnotationView*)newAnnotation).draggable = YES;
    //设置大头针图标
    ((BMKPinAnnotationView*)newAnnotation).image = [UIImage imageNamed:@"image_map_point"];
    
    
    MyRelativeLayout *popView = [MyRelativeLayout new];
    popView.myWidth = SCREEN_WIDTH - 100;
    popView.myHeight = 180;
    popView.backgroundColor = [UIColor whiteColor];
    popView.layer.borderWidth = 1;
    popView.layer.borderColor = [UIColor colorWithHexString:app_style_color].CGColor;
    
    
   
    //项目名称
    UILabel *lab1 = [UILabel new];
    lab1.text = [NSString stringWithFormat:@"项目名称:%@",_data[_count][@"ProjectInfoName"]];
    lab1.font = [UIFont systemFontOfSize:14];
    lab1.textColor = [UIColor colorWithHexString:app_text_color];
    lab1.wrapContentWidth = YES;
    lab1.leftPos.equalTo(popView.leftPos).offset(12);
    lab1.topPos.equalTo(popView.topPos);
    lab1.rightPos.equalTo(popView.rightPos).offset(5);
    [popView addSubview:lab1];
    //客户名称
    UILabel *lab2 = [UILabel new];
    lab2.text = [NSString stringWithFormat:@"客户名称:%@",_data[_count][@"PersonInCharge"]];
    lab2.font = [UIFont systemFontOfSize:14];
    lab2.textColor = [UIColor colorWithHexString:app_text_color];
    lab2.wrapContentWidth = YES;
    lab2.leftPos.equalTo(popView.leftPos).offset(12);
    lab2.topPos.equalTo(lab1.bottomPos);
    lab2.rightPos.equalTo(popView.rightPos).offset(5);
    [popView addSubview:lab2];
    //地址
    UILabel *lab3 = [UILabel new];
    lab3.text = [NSString stringWithFormat:@"地址:%@",_data[_count][@"ProjectAddress"]];
    lab3.font = [UIFont systemFontOfSize:14];
    lab3.textColor = [UIColor colorWithHexString:app_text_color];
    lab3.wrapContentWidth = YES;
    lab3.leftPos.equalTo(popView.leftPos).offset(12);
    lab3.topPos.equalTo(lab2.bottomPos);
    lab3.rightPos.equalTo(popView.rightPos).offset(5);
    [popView addSubview:lab3];
    //电话
    UIButton *lab4 = [UIButton new];
    lab4.tag = _count;
    
    lab4.titleLabel.font = [UIFont systemFontOfSize:14];
    [lab4 setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateNormal];
    lab4.wrapContentWidth = YES;
    lab4.leftPos.equalTo(popView.leftPos).offset(12);
    lab4.topPos.equalTo(lab3.bottomPos);
    lab4.rightPos.equalTo(popView.rightPos).offset(5);
    [lab4 addTarget:self action:@selector(doMobile:) forControlEvents:UIControlEventTouchUpInside];
    
    //下划线
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"电话:%@",_data[_count][@"PersonInChargeTel"]]];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    //此时如果设置字体颜色要这样
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:app_style_color]  range:NSMakeRange(0,[str length])];
    
    //设置下划线颜色...
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:app_style_color] range:(NSRange){0,[str length]}];
    [lab4 setAttributedTitle: str forState:UIControlStateNormal];
    [popView addSubview:lab4];
   
    
    MyRelativeLayout *bottomContent = [MyRelativeLayout new];
    bottomContent.leftPos.equalTo(popView.leftPos).offset(5);
    bottomContent.topPos.equalTo(lab4.bottomPos);
    bottomContent.bottomPos.equalTo(popView.bottomPos);
    bottomContent.rightPos.equalTo(popView.rightPos).offset(5);
    [popView addSubview:bottomContent];
    
    //项目资料
    UIButton *btn1 = [UIButton new];
    
    btn1.myHeight = 20;
    btn1.myWidth = 80;
    [btn1 setTitle:@"项目资料" forState:UIControlStateNormal];
    btn1.rightPos.equalTo(bottomContent.rightPos);
    btn1.centerYPos.equalTo(bottomContent.centerYPos);
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.layer.cornerRadius = 10;
    btn1.layer.masksToBounds = YES;
    [btn1 setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:@"2ba246"]] forState:UIControlStateNormal];
    
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
  
    [bottomContent addSubview:btn1];
    
    //设备一览
    UIButton *btn2 = [UIButton new];
    
    btn2.myHeight = 20;
    btn2.myWidth = 80;
    [btn2 setTitle:@"设备一览" forState:UIControlStateNormal];
    btn2.rightPos.equalTo(btn1.leftPos).offset(10);
    btn2.centerYPos.equalTo(bottomContent.centerYPos);
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 10;
    btn2.layer.masksToBounds = YES;
    [btn2 setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:app_style_color]] forState:UIControlStateNormal];
    
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [bottomContent addSubview:btn2];
 lab1.heightSize.equalTo(@[lab2.heightSize,lab3.heightSize,lab4.heightSize,bottomContent.heightSize]);
    
    
    btn1.tag = _count;
    btn2.tag = _count;
    
    [btn1 addTarget:self action:@selector(doDocument:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(doDevice:) forControlEvents:UIControlEventTouchUpInside];
    
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
    pView.frame = CGRectMake(0, 0, popView.myWidth, popView.myHeight);
    ((BMKPinAnnotationView*)newAnnotation).paopaoView = nil;
    ((BMKPinAnnotationView*)newAnnotation).paopaoView = pView;
    
    _count++;
    return newAnnotation;

}
-(void)doMobile:(UIView *) v{
    long tag = v.tag;
    
    NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",_data[tag][@"PersonInChargeTel"]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
    [self.view addSubview:callWebview];
    
    
}
-(void)doDevice:(UIView *) v{
    long tag = v.tag;
    DeviceViewController *deviceVc = [DeviceViewController new];
    deviceVc.ProjectInfoCode = _data[tag][@"ProjectInfoCode"];
    [self.navigationController pushViewController:deviceVc animated:YES];
}
-(void)doDocument:(UIView *) v{
    long tag = v.tag;
    DocumentViewController *documentVc = [DocumentViewController new];
    documentVc.ProjectInfoId = _data[tag][@"ProjectInfoId"];
    [self.navigationController pushViewController:documentVc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi{
    [_mapView setCenterCoordinate:mapPoi.pt animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.parentViewController.tabBarController.tabBar.hidden = NO;
    
}

@end
