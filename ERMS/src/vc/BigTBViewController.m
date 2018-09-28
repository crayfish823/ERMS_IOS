//
//  BigTBViewController.m
//  ERMS
//
//  Created by 堂堂 on 2018/9/13.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "BigTBViewController.h"
#import "Const.h"
#import "Colors.h"
#import "UIColor+Hex.h"
#import "TTUtils.h"
#import <Charts/Charts.h>
#import "MyLayout.h"
#import "XStringFormatter.h"
#import "AppDelegate.h"
@interface BigTBViewController ()<ChartViewDelegate>

@property MyRelativeLayout *contenView;
//图表
@property LineChartView *chartView;
@property ChartYAxis *leftAxis;
@property ChartYAxis *rightAxis;
@property ChartXAxis *xAxis;
@property NSMutableArray *xData;
@property NSArray *colors;

@end

@implementation BigTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.parentViewController.tabBarController.tabBar.hidden = YES;
    _colors = @[@"#5FD79C",@"#F2953C",@"#16BBF1",@"#E9CA2C",@"#FF7E7E",@"#cccccc",@"15bbf1"];

    MyRelativeLayout *_contentAll = [MyRelativeLayout new];
    _contentAll.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    self.view = _contentAll;
    
    MyRelativeLayout *titleContent = [MyRelativeLayout new];
    titleContent.myHeight = 50;
    titleContent.leftPos.equalTo(_contentAll.leftPos);
    titleContent.rightPos.equalTo(_contentAll.rightPos);

    titleContent.myWidth = SCREEN_HEIGHT;
    titleContent.backgroundColor = [UIColor colorWithHexString:app_style_color];
    [_contentAll addSubview:titleContent];
    
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"image_back"] forState:UIControlStateNormal];
    backBtn.myHeight = 40;
    backBtn.myWidth = 40;
    backBtn.tag = 10;
    backBtn.bottomPos.equalTo(titleContent.bottomPos).offset(5);
    backBtn.leftPos.equalTo(titleContent.leftPos);
    [backBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [titleContent addSubview:backBtn];
    
    
    _chartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH - 50)];
    _chartView.leftPos.equalTo(_contentAll.leftPos);
    _chartView.rightPos.equalTo(_contentAll.rightPos);
    _chartView.bottomPos.equalTo(_contentAll.bottomPos);
    _chartView.topPos.equalTo(titleContent.bottomPos);
    _chartView.myWidth = SCREEN_WIDTH;
    //   _chartView.myHeight = 300;
    _chartView.backgroundColor = [UIColor blueColor];
    [_chartView sizeToFit];
    [_contentAll addSubview:_chartView];
    //设置图表
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.pinchZoomEnabled = YES;
    
    
    ChartLegend *l = _chartView.legend;
    l.form = ChartLegendFormLine;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.textColor = UIColor.whiteColor;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:8.f];
    xAxis.labelTextColor = [UIColor whiteColor];
    xAxis.drawGridLinesEnabled = YES;
    xAxis.gridColor = [UIColor whiteColor];
    xAxis.axisLineColor = [UIColor whiteColor];
    xAxis.axisLineWidth = 2;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.granularityEnabled = YES;
    
    _xAxis = xAxis;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelTextColor = [UIColor whiteColor];
    leftAxis.axisLineColor = [UIColor whiteColor];
    leftAxis.zeroLineColor = [UIColor clearColor];
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO ;
    leftAxis.granularityEnabled = YES;
    _leftAxis = leftAxis;
    
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.labelTextColor = [UIColor whiteColor];
    rightAxis.drawZeroLineEnabled = NO;
    
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.granularityEnabled = YES;
    _rightAxis = rightAxis;
    
    
    [_chartView animateWithXAxisDuration:2.5];
    
    if(_pos == 0){
        [self setChars1:_data];
    }else{
        [self setChars2:_data];
    }
    
    _contenView = _contentAll;
    
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appdelegate.shouldRote=YES;
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationLandscapeRight] forKey:@"orientation"];
    
    [UIViewController attemptRotationToDeviceOrientation];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];


}
//- (void)viewDidLayoutSubviews{
//    
//        [super viewDidLayoutSubviews];
//    
//       //由于旋转后的origin偏差,修正contenView的origin
//    
//    //    [UIView animateWithDuration:0.3 animations:^{
//    
//           self.contenView.transform=CGAffineTransformRotate(CGAffineTransformIdentity,M_PI_2);
//    
//           self.contenView.frame=self.view.bounds;
//    
//    //    }];
//    
//}
// 允许自动旋转
-(BOOL)shouldAutorotate{
    return YES;
}


- (void)viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///// 当前的导航控制器是否可以旋转
//-(BOOL)shouldAutorotate{
//
//    return YES;
//}
//
////设置支持的屏幕旋转方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
//
////设置presentation方式展示的屏幕方向
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//
//    return UIInterfaceOrientationLandscapeRight;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)setChars1:(NSArray *)data{
   
    
    _chartView.backgroundColor = [UIColor colorWithHexString:@"#254e69"];
    _chartView.hidden = NO;
    _xData = [NSMutableArray new];
    
    NSMutableArray *xStrings = [NSMutableArray new];
    if ([@"全部" isEqualToString:_xhData[@"TagName"]]) {
        for (int i = 1; i < _xhDatas.count; i++) {
            [xStrings addObject:_xhDatas[i]];
        }
    }else{
        [xStrings addObject:_xhData];
    }
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    
    
    NSMutableArray *yValues = [NSMutableArray new];
    
    bool flag = YES;
    for (int i = 0 ; i < data.count;i++) {
        
        if (i != 0) {
            flag = NO;
        }
        NSArray *array = data[i];
        NSMutableArray *charData = [NSMutableArray new];
        for (int j = 0 ; j < array.count;j++) {
            NSDictionary *item = array[j] ;
            NSString *str = item[@"ItemValue"];
            NSString * Qualitie =item[@"Qualitie"];
            if ([str hasPrefix:@"'-'"] || [@"0" isEqualToString:Qualitie]) {
                
                ChartDataEntry *cd = [[ChartDataEntry alloc] initWithX:j y: 0];
                [cd setVisible:NO];
                [charData addObject:cd];
                
            }else{
                ChartDataEntry *cd = [[ChartDataEntry alloc] initWithX:j y: [item[@"ItemValue"] doubleValue] ];
                [cd setVisible:YES];
                [charData addObject:cd];
                [yValues addObject:item[@"ItemValue"]];
            }
            
            if (flag) {
                
                [_xData addObject:[TTUtils dateUTCToNow:item[@"TimeStamp"] oldSf:@"yyyy-MM-dd'T'HH:mm:ss'Z'" nowSf:@"HH:mm"]];
            }
        }
        //排序
        NSArray *result = [yValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            
            return [obj2 compare:obj1]; //降序
            
        }];
        
        int m = i % _colors.count;
        NSString *c = _colors[m];
        UIColor *lineColor = [UIColor colorWithHexString:c ];
        LineChartDataSet *lineDataSet = [[LineChartDataSet alloc] initWithValues:(NSArray<ChartDataEntry *> * _Nullable)charData label:xStrings[i][@"TagName"]];
        lineDataSet.axisDependency = AxisDependencyRight;
        [lineDataSet setColor:lineColor];
        [lineDataSet setCircleColor:lineColor];
        lineDataSet.mode = LineChartModeCubicBezier;
        lineDataSet.lineWidth = 1.0;
        lineDataSet.circleRadius = 3.0;
        lineDataSet.fillAlpha = 65/255.0;
        lineDataSet.fillColor = lineColor;
        lineDataSet.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        lineDataSet.drawCircleHoleEnabled = NO;
        
        
        //        _leftAxis.axisMaximum = result.count == 0 ? 20 : [[result firstObject] doubleValue] + 20;
        //        _leftAxis.axisMinimum = result.count == 0 ? -20 : [[result lastObject] doubleValue] - 20;
        //        _rightAxis.axisMaximum = result.count == 0 ? 20 : [[result firstObject] doubleValue] + 20;
        //        _rightAxis.axisMinimum = result.count == 0 ? -20 : [[result lastObject] doubleValue] - 20;
        
        [_leftAxis setLabelCount:10];
        [_rightAxis setLabelCount:10];
        _xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        [_xAxis setLabelCount:_xData.count];
        XStringFormatter *xf = [[XStringFormatter alloc] init];
        xf.data = _xData;
        [_xAxis setValueFormatter:xf];
        [dataSets addObject:lineDataSet];
    }
    
    
    LineChartData *lines = [[LineChartData alloc] initWithDataSets:dataSets];
    [lines setValueTextColor:[UIColor whiteColor]];
    [lines setValueFont:[UIFont systemFontOfSize:9.f]];
    
    _chartView.data = lines;
    
    [_chartView.data notifyDataChanged];
    [_chartView notifyDataSetChanged];
}

- (NSString *)dateWithString:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss zz:z"];
    
    // 先将"+"替换成@" "
    NSDate *date = [dateFormatter dateFromString:[str stringByReplacingOccurrencesOfString:@"+" withString:@" "]];
    
    // 解决差8小时的问题
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSDate *newDate = [date dateByAddingTimeInterval:2*[timeZone secondsFromGMTForDate:date]];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:newDate];
}
-(void)setChars2:(NSArray *)data{

    
    _chartView.backgroundColor = [UIColor colorWithHexString:@"#254e69"];
    _chartView.hidden = NO;
    _xData = [NSMutableArray new];
    
    NSMutableArray *xStrings = [NSMutableArray new];
    for (int i = 0; i < _typeData.count; i++) {
        NSString *text = [NSString stringWithFormat:@"%@-%@",_typeData[i][@"ProjectInfoName"],_typeData[i][@"TagName"]];
        [xStrings addObject:text];
    }
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    
    
    NSMutableArray *yValues = [NSMutableArray new];
    
    bool flag = YES;
    for (int i = 0 ; i < data.count;i++) {
        
        if (i != 0) {
            flag = NO;
        }
        NSArray *array = data[i];
        NSMutableArray *charData = [NSMutableArray new];
        for (int j = 0 ; j < array.count;j++) {
            NSDictionary *item = array[j] ;
            NSString *str = item[@"ItemValue"];
            NSString * Qualitie =item[@"Qualitie"];
            if ([str hasPrefix:@"'-'"] || [@"0" isEqualToString:Qualitie] || [str hasPrefix:@"*"]) {
                
                [charData addObject:[[ChartDataEntry alloc] initWithX:j y: 0]];
                
            }else{
                [charData addObject:[[ChartDataEntry alloc] initWithX:j y:[item[@"ItemValue"] doubleValue] ]];
                [yValues addObject:item[@"ItemValue"]];
            }
            
            if (flag) {
                [_xData addObject:[TTUtils dateUTCToNow:item[@"TimeStamp"] oldSf:@"yyyy-MM-dd'T'HH:mm:ss'Z'" nowSf:@"HH:mm"]];
            }
        }
        //排序
        NSArray *result = [yValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            
            return [obj2 compare:obj1]; //降序
            
        }];
        
        int m = i % _colors.count;
        NSString *c = _colors[m];
        UIColor *lineColor = [UIColor colorWithHexString:c ];
        LineChartDataSet *lineDataSet = [[LineChartDataSet alloc] initWithValues:(NSArray<ChartDataEntry *> * _Nullable)charData label:xStrings[i]];
        lineDataSet.axisDependency = AxisDependencyRight;
        [lineDataSet setColor:lineColor];
        [lineDataSet setCircleColor:lineColor];
        lineDataSet.lineWidth = 1.0;
        lineDataSet.mode = LineChartModeCubicBezier;
        lineDataSet.circleRadius = 3.0;
        lineDataSet.fillAlpha = 65/255.0;
        lineDataSet.fillColor = lineColor;
        lineDataSet.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        lineDataSet.drawCircleHoleEnabled = NO;
        
        
        //        _leftAxis.axisMaximum = result.count == 0 ? 20 : [[result firstObject] doubleValue] + 20;
        //        _leftAxis.axisMinimum = result.count == 0 ? -20 : [[result lastObject] doubleValue] - 20;
        //        _rightAxis.axisMaximum = result.count == 0 ? 20 : [[result firstObject] doubleValue] + 20;
        //        _rightAxis.axisMinimum = result.count == 0 ? -20 : [[result lastObject] doubleValue] - 20;
        
        [_leftAxis setLabelCount:10];
        [_rightAxis setLabelCount:10];
        _xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        [_xAxis setLabelCount:_xData.count];
        XStringFormatter *xf = [[XStringFormatter alloc] init];
        xf.data = _xData;
        [_xAxis setValueFormatter:xf];
        [dataSets addObject:lineDataSet];
    }
    
    
    LineChartData *lines = [[LineChartData alloc] initWithDataSets:dataSets];
    [lines setValueTextColor:[UIColor whiteColor]];
    [lines setValueFont:[UIFont systemFontOfSize:9.f]];
    
    _chartView.data = lines;
    
    [_chartView.data notifyDataChanged];
    [_chartView notifyDataSetChanged];
}

-(void)save:(UIView *)view{
    
    int tag = view.tag;
    
    if (tag == 10) {
        
        AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        
        appdelegate.shouldRote=NO;
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait] forKey:@"orientation"];
        [UIViewController attemptRotationToDeviceOrientation];
        
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
@end
