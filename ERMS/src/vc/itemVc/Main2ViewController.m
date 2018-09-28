//
//  Main2ViewController.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//
#import "ProjectTableViewCell.h"
#import "XHTableViewCell.h"
#import "XHZTableViewCell.h"
#import "Main2ViewController.h"
#import "MyRelativeLayout.h"
#import "MyLinearLayout.h"
#import "DeviceTableViewCell.h"
#import "Main3TableViewCell.h"
#import "DateTimePickerView.h"
#import "Const.h"
#import "Colors.h"
#import "UIColor+Hex.h"
#import "UserDefaultUtil.h"
#import "TTUtils.h"
#import "MenuView.h"
#import "LeftMenuViewControll.h"
#import "ERMS-Bridging-Header.h"
#import "Main23TableViewCell.h"
#import "Main24TableViewCell.h"
#import "MJRefresh.h"
#import <Charts/Charts.h>
#import "XStringFormatter.h"
#import "AddViewController.h"
#import "BigTBViewController.h"
#import "AppDelegate.h"
@interface Main2ViewController ()<ChartViewDelegate>
@property UIScrollView *scroll;
@property MyRelativeLayout *contentAll;
@property MyLinearLayout *content;


@property UITableView *itemListView;
//项目
@property NSArray *projectDatas;
@property NSDictionary *projectData;
//设备
@property NSArray *deviceDatas;
@property NSDictionary *deviceData;
//信号
@property NSMutableArray *xhDatas;
@property NSDictionary *xhData;

//对比数据
@property NSMutableArray *typeData;



@property NSString *date,*dateStart,*dateEnd;
@property NSString *result;
@property MyRelativeLayout *deviceListContent;



@property UIButton *btnPro,*btnDevice,*btnXH,*btnDate,*btnStartDate,*btnEndDate,*btnDB;

@property UITextView *textView;
//时间选择器
@property THDatePickerView *pickerView;
@property int tagDateClick;
@property UIControl *dateControl;

@property LeftMenuViewControll *leftView;
@property MenuView *menuView;

@property int POS;

@property int page,size;

@property NSArray<UIView *> *btns;
@property NSArray<UIView *> *lines;

@property MyRelativeLayout *bottomContent1;
@property MyRelativeLayout *bottomContent3;

@property MyRelativeLayout *bottomContent4;

@property UITableView *dataList3;
@property NSArray *ListData3;

@property UITableView *dataList4;
@property NSArray *ListData4;
//图表
@property LineChartView *chartView;
@property ChartYAxis *leftAxis;
@property ChartYAxis *rightAxis;
@property ChartXAxis *xAxis;
@property NSMutableArray *xData;
@property NSArray *colors;
@property NSArray *data;

@property  AppDelegate *delegate;
@end

@implementation Main2ViewController
static NSString *ID = @"ViewController";
static NSString *ID2 = @"ViewController2";
static NSString *ID3 = @"ViewController3";
static NSString *ID4 = @"ViewController4";
static NSString *ID5 = @"ViewController5";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"趋势";
    [self initNavigation];
    _delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

    
    _colors = @[@"#5FD79C",@"#F2953C",@"#16BBF1",@"#E9CA2C",@"#FF7E7E",@"#cccccc",@"15bbf1"];

    _POS = 0;
    //初始化数据s
    _contentAll = [MyRelativeLayout new];
    _contentAll.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    self.view = _contentAll;
    
    //左侧菜单
    _leftView= [[LeftMenuViewControll alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT)];
    _menuView = [MenuView MenuViewWithDependencyView:self.view MenuView:_leftView isShowCoverView:NO];
    
    _leftView.backBlock = ^(int indexPath){
       self.navigationItem.title = self.leftView.data[indexPath];
        [self.menuView hidenWithAnimation];
        if (self.POS != indexPath) {
            self.POS = indexPath;
            [self setView];
        }

        
    };
    
    UIFont *textFont = [UIFont systemFontOfSize:14];
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    int jg = 10;
    _content = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    _content.myWidth = SCREEN_WIDTH;
    
    
    _content.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    [_contentAll addSubview:_content];
    
    // [self.view addSubview:_content];
    
    int height = 50;
    
    //日期
    MyRelativeLayout *content0 = [MyRelativeLayout new];
    content0.myWidth = SCREEN_WIDTH;
    content0.myHeight = height;
    content0.wrapContentHeight = YES;
    content0.leftPadding = 10;
    content0.rightPadding = 10;
    [_content addSubview:content0];
    
    UILabel *lab0 = [UILabel new];
    lab0.text = @"日        期:";
    lab0.font = textFont;
    lab0.wrapContentWidth = YES;
    lab0.wrapContentHeight = YES;
    lab0.leftPos.equalTo(content0.leftPos).offset(jg);
    lab0.centerYPos.equalTo(content0.centerYPos);
    [content0 addSubview:lab0];
    
    
    _btnDate = [UIButton new];
    _btnDate.wrapContentHeight = YES;
    [_btnDate setTitle:@"选择日期" forState:UIControlStateNormal];
    _btnDate.titleLabel.font = textFont;
    [_btnDate setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnDate setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnDate.leftPos.equalTo(lab0.rightPos).offset(10);
    _btnDate.rightPos.equalTo(content0.rightPos).offset(jg);
    _btnDate.centerYPos.equalTo(content0.centerYPos);
    _btnDate.myWidth = SCREEN_WIDTH;
    _btnDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnDate.tag = 100;
    [_btnDate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content0 addSubview:_btnDate];
    
    UIImageView *image0 = [UIImageView new];
    image0.image = [UIImage imageNamed:@"down_image"];
    image0.myWidth = 20;
    image0.myHeight = 20;
    image0.rightPos.equalTo(_btnDate.rightPos);
    image0.centerYPos.equalTo(lab0.centerYPos);
    [content0 addSubview:image0];
    
    UIView *line0 = [UIView new];
    line0.myWidth = SCREEN_WIDTH;
    line0.myHeight = 3;
    line0.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line0];
    
    
    //项目
    MyRelativeLayout *content1 = [MyRelativeLayout new];
    content1.myWidth = SCREEN_WIDTH;
    content1.myHeight = height;
    content1.wrapContentHeight = YES;
    content1.leftPadding = 10;
    content1.rightPadding = 10;
    [_content addSubview:content1];
    
    UILabel *lab1 = [UILabel new];
    lab1.text = @"项        目:";
    lab1.font = textFont;
    lab1.wrapContentWidth = YES;
    lab1.wrapContentHeight = YES;
    lab1.leftPos.equalTo(content1.leftPos).offset(jg);
    lab1.centerYPos.equalTo(content1.centerYPos);
    [content1 addSubview:lab1];
    
    
    _btnPro = [UIButton new];
    _btnPro.wrapContentHeight = YES;
    [_btnPro setTitle:@"选择项目" forState:UIControlStateNormal];
    _btnPro.titleLabel.font = textFont;
    [_btnPro setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnPro setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnPro.leftPos.equalTo(lab1.rightPos).offset(10);
    _btnPro.rightPos.equalTo(content1.rightPos).offset(jg);
    _btnPro.centerYPos.equalTo(content1.centerYPos);
    _btnPro.myWidth = SCREEN_WIDTH;
    _btnPro.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnPro.tag = 101;
    [_btnPro addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content1 addSubview:_btnPro];
    
    UIImageView *image1 = [UIImageView new];
    image1.image = [UIImage imageNamed:@"down_image"];
    image1.myWidth = 20;
    image1.myHeight = 20;
    image1.rightPos.equalTo(_btnPro.rightPos);
    image1.centerYPos.equalTo(lab1.centerYPos);
    [content1 addSubview:image1];
    
    UIView *line1 = [UIView new];
    line1.myWidth = SCREEN_WIDTH;
    line1.myHeight = 3;
    line1.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line1];
    
    //设备
    MyRelativeLayout *content2 = [MyRelativeLayout new];
    content2.myWidth = SCREEN_WIDTH;
    content2.myHeight = height;
    content2.wrapContentHeight = YES;
    content2.leftPadding = 10;
    content2.rightPadding = 10;
    [_content addSubview:content2];
    
    UILabel *lab2 = [UILabel new];
    lab2.text = @"设  备  名:";
    lab2.font = textFont;
    lab2.wrapContentWidth = YES;
    lab2.wrapContentHeight = YES;
    lab2.leftPos.equalTo(content2.leftPos).offset(jg);
    lab2.centerYPos.equalTo(content2.centerYPos);
    [content2 addSubview:lab2];
    
    
    _btnDevice = [UIButton new];
    _btnDevice.wrapContentHeight = YES;
    [_btnDevice setTitle:@"选择设备" forState:UIControlStateNormal];
    _btnDevice.titleLabel.font = textFont;
    [_btnDevice setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnDevice setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnDevice.leftPos.equalTo(lab2.rightPos).offset(10);
    _btnDevice.rightPos.equalTo(content2.rightPos).offset(jg);
    _btnDevice.centerYPos.equalTo(content2.centerYPos);
    _btnDevice.myWidth = SCREEN_WIDTH;
    _btnDevice.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnDevice.tag = 102;
    [_btnDevice addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content2 addSubview:_btnDevice];
    
    UIImageView *image2 = [UIImageView new];
    image2.image = [UIImage imageNamed:@"down_image"];
    image2.myWidth = 20;
    image2.myHeight = 20;
    image2.rightPos.equalTo(_btnDevice.rightPos);
    image2.centerYPos.equalTo(lab2.centerYPos);
    [content2 addSubview:image2];
    
    UIView *line2 = [UIView new];
    line2.myWidth = SCREEN_WIDTH;
    line2.myHeight = 3;
    line2.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line2];
    
    
    //信号
    MyRelativeLayout *content3 = [MyRelativeLayout new];
    content3.myWidth = SCREEN_WIDTH;
    content3.myHeight = height;
    content3.wrapContentHeight = YES;
    content3.leftPadding = 10;
    content3.rightPadding = 10;
    [_content addSubview:content3];
    
    UILabel *lab3 = [UILabel new];
    lab3.text = @"信        号:";
    lab3.font = textFont;
    lab3.wrapContentWidth = YES;
    lab3.wrapContentHeight = YES;
    lab3.leftPos.equalTo(content3.leftPos).offset(jg);
    lab3.centerYPos.equalTo(content3.centerYPos);
    [content3 addSubview:lab3];
    
    
    _btnXH = [UIButton new];
    _btnXH.wrapContentHeight = YES;
    [_btnXH setTitle:@"选择信号" forState:UIControlStateNormal];
    _btnXH.titleLabel.font = textFont;
    [_btnXH setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnXH setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnXH.leftPos.equalTo(lab3.rightPos).offset(10);
    _btnXH.rightPos.equalTo(content3.rightPos).offset(jg);
    _btnXH.centerYPos.equalTo(content3.centerYPos);
    _btnXH.myWidth = SCREEN_WIDTH;
    _btnXH.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnXH.tag = 103;
    [_btnXH addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content3 addSubview:_btnXH];
    
    UIImageView *image3 = [UIImageView new];
    image3.image = [UIImage imageNamed:@"down_image"];
    image3.myWidth = 20;
    image3.myHeight = 20;
    image3.rightPos.equalTo(content3.rightPos).offset(jg);
    image3.centerYPos.equalTo(lab3.centerYPos);
    [content3 addSubview:image3];
    
    UIView *line3 = [UIView new];
    line3.myWidth = SCREEN_WIDTH;
    line3.myHeight = 3;
    line3.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line3];
    
    //开始日期
    MyRelativeLayout *content4 = [MyRelativeLayout new];
    content4.myWidth = SCREEN_WIDTH;
    content4.myHeight = height;
    content4.wrapContentHeight = YES;
    content4.leftPadding = 10;
    content4.rightPadding = 10;
    [_content addSubview:content4];
    
    UILabel *lab4 = [UILabel new];
    lab4.text = @"开始时间:";
    lab4.font = textFont;
    lab4.wrapContentWidth = YES;
    lab4.wrapContentHeight = YES;
    lab4.leftPos.equalTo(content4.leftPos).offset(jg);
    lab4.centerYPos.equalTo(content4.centerYPos);
    [content4 addSubview:lab4];
    
    
    _btnStartDate = [UIButton new];
    _btnStartDate.wrapContentHeight = YES;
    [_btnStartDate setTitle:@"选择时间" forState:UIControlStateNormal];
    _btnStartDate.titleLabel.font = textFont;
    [_btnStartDate setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnStartDate setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnStartDate.leftPos.equalTo(lab4.rightPos).offset(10);
    _btnStartDate.rightPos.equalTo(content4.rightPos).offset(jg);
    _btnStartDate.centerYPos.equalTo(content4.centerYPos);
    _btnStartDate.myWidth = SCREEN_WIDTH;
    _btnStartDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnStartDate.tag = 104;
    [_btnStartDate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content4 addSubview:_btnStartDate];
    
    UIImageView *image4 = [UIImageView new];
    image4.image = [UIImage imageNamed:@"down_image"];
    image4.myWidth = 20;
    image4.myHeight = 20;
    image4.rightPos.equalTo(_btnStartDate.rightPos);
    image4.centerYPos.equalTo(lab4.centerYPos);
    [content4 addSubview:image4];
    
    UIView *line4 = [UIView new];
    line4.myWidth = SCREEN_WIDTH;
    line4.myHeight = 3;
    line4.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line4];
    
    //结束日期
    MyRelativeLayout *content5 = [MyRelativeLayout new];
    content5.myWidth = SCREEN_WIDTH;
    content5.myHeight = height;
    content5.wrapContentHeight = YES;
    content5.leftPadding = 10;
    content5.rightPadding = 10;
    [_content addSubview:content5];
    
    UILabel *lab5 = [UILabel new];
    lab5.text = @"结束时间:";
    lab5.font = textFont;
    lab5.wrapContentWidth = YES;
    lab5.wrapContentHeight = YES;
    lab5.leftPos.equalTo(content5.leftPos).offset(jg);
    lab5.centerYPos.equalTo(content5.centerYPos);
    [content5 addSubview:lab5];
    
    
    _btnEndDate = [UIButton new];
    _btnEndDate.wrapContentHeight = YES;
    [_btnEndDate setTitle:@"选择时间" forState:UIControlStateNormal];
    _btnEndDate.titleLabel.font = textFont;
    [_btnEndDate setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnEndDate setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnEndDate.leftPos.equalTo(lab5.rightPos).offset(10);
    _btnEndDate.rightPos.equalTo(content5.rightPos).offset(jg);
    _btnEndDate.centerYPos.equalTo(content5.centerYPos);
    _btnEndDate.myWidth = SCREEN_WIDTH;
    _btnEndDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnEndDate.tag = 105;
    [_btnEndDate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content5 addSubview:_btnEndDate];
    
    UIImageView *image5 = [UIImageView new];
    image5.image = [UIImage imageNamed:@"down_image"];
    image5.myWidth = 20;
    image5.myHeight = 20;
    image5.rightPos.equalTo(_btnEndDate.rightPos);
    image5.centerYPos.equalTo(lab5.centerYPos);
    [content5 addSubview:image5];
    
    UIView *line5 = [UIView new];
    line5.myWidth = SCREEN_WIDTH;
    line5.myHeight = 3;
    line5.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line5];
    
    //设置对比
    MyRelativeLayout *content6 = [MyRelativeLayout new];
    content6.myWidth = SCREEN_WIDTH;
    content6.myHeight = 80;
    content6.wrapContentHeight = YES;
    content6.leftPadding = 10;
    content6.rightPadding = 10;
    [_content addSubview:content6];
    
    UILabel *lab6 = [UILabel new];
    lab6.text = @"设置对比:";
    lab6.font = textFont;
    lab6.wrapContentWidth = YES;
    lab6.wrapContentHeight = YES;
    lab6.leftPos.equalTo(content6.leftPos).offset(jg);
    lab6.centerYPos.equalTo(content6.centerYPos);
    [content6 addSubview:lab6];
    
    
    _btnDB = [UIButton new];
    _btnDB.myHeight = 80;
    [_btnDB setTitle:@"选择对比" forState:UIControlStateNormal];
    _btnDB.titleLabel.font = [UIFont systemFontOfSize:12];
    [_btnDB setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnDB setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnDB.leftPos.equalTo(lab6.rightPos).offset(10);
    _btnDB.rightPos.equalTo(content6.rightPos).offset(jg + 20);
    _btnDB.centerYPos.equalTo(content6.centerYPos);
    _btnDB.myWidth = SCREEN_WIDTH;
    _btnDB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnDB.tag = 106;
    _btnDB.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_btnDB addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content6 addSubview:_btnDB];
    
    UIButton *btn_delete = [UIButton new];
    [btn_delete setTitle:@"X" forState:UIControlStateNormal];
    [btn_delete setTitleColor:textColor forState:UIControlStateNormal];
    btn_delete.titleLabel.font = [UIFont systemFontOfSize:20];
    btn_delete.tag = 20;
    btn_delete.myWidth = 20;
    btn_delete.myHeight = 80;
    btn_delete.rightPos.equalTo(content6.rightPos).offset(jg);
    btn_delete.centerYPos.equalTo(lab6.centerYPos);
    [btn_delete addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [content6 addSubview:btn_delete];
    
    //查询
    
    UIButton *limitBtn = [UIButton new];
    limitBtn.myLeft = 30;
    limitBtn.myRight  = 30;
    limitBtn.tag = 107;
    limitBtn.myHeight = 46;
    limitBtn.myWidth = SCREEN_WIDTH - 60;
    limitBtn.myTop = 15;
    [limitBtn setTitle:@"查询" forState:UIControlStateNormal];
    [limitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    limitBtn.layer.cornerRadius = 23;
    limitBtn.layer.masksToBounds = YES;
    [limitBtn setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:login_btn_pressed_default]] forState:UIControlStateNormal];
    [limitBtn setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:login_btn_pressed]] forState:UIControlStateSelected];
    
    [limitBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:limitBtn];
    
    MyRelativeLayout *content = [MyRelativeLayout new ];
    content.leftPos.equalTo(_contentAll.leftPos);
    content.rightPos.equalTo(_contentAll.rightPos);
    content.bottomPos.equalTo(_contentAll.bottomPos);
    content.topPos.equalTo(_content.bottomPos).offset(10);
    [_contentAll addSubview:content];

    
    
    //图表
    
    _bottomContent1 = [MyRelativeLayout new];
    _bottomContent1.leftPos.equalTo(content.leftPos);
    _bottomContent1.rightPos.equalTo(content.rightPos);
    _bottomContent1.bottomPos.equalTo(content.bottomPos);
    _bottomContent1.topPos.equalTo(content.topPos);
    [content addSubview:_bottomContent1];
    
    UIScrollView *scroll = [UIScrollView new];
    scroll.leftPos.equalTo(_bottomContent1.leftPos);
    scroll.rightPos.equalTo(_bottomContent1.rightPos);
    scroll.bottomPos.equalTo(_bottomContent1.bottomPos);
    scroll.topPos.equalTo(_bottomContent1.topPos);
    scroll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, scroll.frame.size.height);
    [_bottomContent1 addSubview:scroll];
  
    
    
    _chartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 2, SCREEN_HEIGHT)];
    _chartView.leftPos.equalTo(scroll.leftPos);
    _chartView.rightPos.equalTo(scroll.rightPos);
    _chartView.bottomPos.equalTo(scroll.bottomPos);
    _chartView.topPos.equalTo(scroll.topPos);
    _chartView.myWidth = SCREEN_WIDTH * 2;
 //   _chartView.myHeight = 300;
    _chartView.backgroundColor = [UIColor blueColor];
    [_chartView sizeToFit];
    [scroll addSubview:_chartView];
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
    xAxis.labelFont = [UIFont systemFontOfSize:11.f];
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
    
    
    //3
    
    _bottomContent3 = [MyRelativeLayout new];
    _bottomContent3.leftPos.equalTo(content.leftPos);
    _bottomContent3.rightPos.equalTo(content.rightPos);
    _bottomContent3.bottomPos.equalTo(content.bottomPos);
    _bottomContent3.topPos.equalTo(content.topPos);
    [content addSubview:_bottomContent3];
    //表头3
    MyLinearLayout *headerContent = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    headerContent.myWidth = SCREEN_WIDTH;
    headerContent.myHeight = 30;
    headerContent.myTop = 10;
    headerContent.backgroundColor = [UIColor colorWithHexString:header_color];
    [_bottomContent3 addSubview:headerContent];
    
    NSArray *title = @[@"信号名称",@"信号组",@"采集时间"];
    for (int i = 0; i < title.count; i++) {
        UILabel *lab = [UILabel new];
        lab.text = title[i];
        lab.textColor = [UIColor whiteColor];
        lab.font = textFont;
        lab.textAlignment = UITextAlignmentCenter;
        lab.myHeight = headerContent.myHeight;
        lab.wrapContentWidth = YES;
        lab.weight = 1;
        [headerContent addSubview:lab];
        
        if (i == title.count - 1) {
            continue;
        }
        UIView *line = [UIView new];
        line.myHeight = headerContent.myHeight;
        line.myWidth = 1;
        line.backgroundColor = [UIColor colorWithHexString:list_line_color3];
        [headerContent addSubview:line];
    }
    [_bottomContent3 addSubview:headerContent];
    
    
    
    
    
    
    _dataList3 = [UITableView new];
    _dataList3.tag = 33;
    _dataList3.myWidth = SCREEN_WIDTH;
    _dataList3.myHeight = SCREEN_HEIGHT;
    _dataList3.leftPos.equalTo(_bottomContent3.leftPos);
    _dataList3.rightPos.equalTo(_bottomContent3.rightPos);
    _dataList3.bottomPos.equalTo(_bottomContent3.bottomPos);
    _dataList3.topPos.equalTo(headerContent.bottomPos);
    
    
    [_bottomContent3 addSubview:_dataList3];
    
    _dataList3.delegate = self;
    _dataList3.dataSource = self;
    
    [_dataList3 registerClass:[Main23TableViewCell class] forCellReuseIdentifier:ID4];
    
    
    if ([_dataList3 respondsToSelector:@selector(setSeparatorInset:)]) {
        [_dataList3 setSeparatorInset:UIEdgeInsetsZero];
    }
    _dataList3.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __unsafe_unretained UITableView *tableView3 = _dataList3;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _dataList3.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新数据");
        
        _page = 0;
        [self getData3];

        [_dataList3.mj_header endRefreshing];
        
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView3.mj_header.automaticallyChangeAlpha = YES;
    tableView3.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"加载更多");
        [self getData3];
        
        [tableView3.mj_footer endRefreshing];
        
    }];
    
    
    //4
    
    _bottomContent4 = [MyRelativeLayout new];
    _bottomContent4.leftPos.equalTo(content.leftPos);
    _bottomContent4.rightPos.equalTo(content.rightPos);
    _bottomContent4.bottomPos.equalTo(content.bottomPos);
    _bottomContent4.topPos.equalTo(content.topPos);
    [content addSubview:_bottomContent4];
    
    
    
    //表头4
    MyLinearLayout *headerContent2 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    headerContent2.myWidth = SCREEN_WIDTH;
    headerContent2.myHeight = 30;
    headerContent2.myTop = 10;
    headerContent2.backgroundColor = [UIColor colorWithHexString:header_color];
    [_bottomContent4 addSubview:headerContent2];
    
    NSArray *title4 = @[@"项目名称",@"信号名称",@"信号状态",@"采集时间"];
    for (int i = 0; i < title4.count; i++) {
        UILabel *lab = [UILabel new];
        lab.text = title4[i];
        lab.textColor = [UIColor whiteColor];
        lab.font = textFont;
        lab.textAlignment = UITextAlignmentCenter;
        lab.myHeight = headerContent.myHeight;
        lab.wrapContentWidth = YES;
        lab.weight = 1;
        [headerContent2 addSubview:lab];
        
        if (i == title4.count - 1) {
            continue;
        }
        UIView *line = [UIView new];
        line.myHeight = headerContent.myHeight;
        line.myWidth = 1;
        line.backgroundColor = [UIColor colorWithHexString:list_line_color3];
        [headerContent2 addSubview:line];
    }
    [_bottomContent4 addSubview:headerContent2];
    
    
    
    
    
    
    _dataList4 = [UITableView new];
    _dataList4.tag = 44;
    _dataList4.myWidth = SCREEN_WIDTH;
    _dataList4.myHeight = SCREEN_HEIGHT;
    _dataList4.leftPos.equalTo(_bottomContent4.leftPos);
    _dataList4.rightPos.equalTo(_bottomContent4.rightPos);
    _dataList4.bottomPos.equalTo(_bottomContent4.bottomPos);
    _dataList4.topPos.equalTo(headerContent2.bottomPos);
    
    
    [_bottomContent4 addSubview:_dataList4];
    
    _dataList4.delegate = self;
    _dataList4.dataSource = self;
    
    [_dataList4 registerClass:[Main24TableViewCell class] forCellReuseIdentifier:ID5];
    
    
    if ([_dataList4 respondsToSelector:@selector(setSeparatorInset:)]) {
        [_dataList4 setSeparatorInset:UIEdgeInsetsZero];
    }
    _dataList4.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __unsafe_unretained UITableView *tableView4 = _dataList4;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _dataList4.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新数据");
        
        _page = 0;
        [self getData4];
        
        [_dataList4.mj_header endRefreshing];
        
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView4.mj_header.automaticallyChangeAlpha = YES;
    tableView4.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"加载更多");
        [self getData4];
        
        [tableView4.mj_footer endRefreshing];
        
    }];
    
    
    
    //初始化deviceList
    [self initList];
    
    [self initDateView];
  
    _btns =  @[content0,content1,content2,content3,content4,content5,content6];

    _lines = @[line0,line1,line2,line3,line4,line5];
    
     [self setView];
    
    [_btnDate setTitle:[TTUtils getYYYYMMDD] forState:UIControlStateSelected];
    _btnDate.selected = YES;
    
//    _date = [TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ 00:00:00",_btnDate.titleLabel.text] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd"];
    _date=_btnDate.titleLabel.text;
    
    
    
    UILongPressGestureRecognizer *longPress =
    
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
     
                                                  action:@selector(handleTableviewCellLongPressed:)];
    
    //代理
    
    longPress.delegate = self;
    
    longPress.minimumPressDuration = 1.0;
    
    //将长按手势添加到需要实现长按操作的视图里
    
    [_chartView addGestureRecognizer:longPress];

}

- (void) handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"UIGestureRecognizerStateBegan");
        
    }
    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        NSLog(@"UIGestureRecognizerStateChanged");
        
       
        
    }
    
    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        
        NSLog(@"UIGestureRecognizerStateEnded");
        
        
        [self showBig];
        
    }
    
    
}

-(void)showBig{
    
//    self.delegate.shouldRote=YES;
//    
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationLandscapeRight] forKey:@"orientation"];
     
     
     
     
     BigTBViewController *bigVc = [BigTBViewController new];
     bigVc.pos = _POS;
     bigVc.xhData = _xhData;
     bigVc.xhDatas= _xhDatas;
     bigVc.typeData = _typeData;
     bigVc.data = _data;
    
    [self.navigationController presentViewController:bigVc animated:YES completion:nil];
     //[self.navigationController pushViewController:bigVc animated:YES];
     }

-(void)initDateView{
    
    _pickerView =  [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    _pickerView.delegate =self;
    _pickerView.title = @"请选择时间";
    _pickerView.leftPos.equalTo(_content.leftPos);
    _pickerView.rightPos.equalTo(_content.rightPos);
    _pickerView.bottomPos.equalTo(_content.bottomPos);
    _pickerView.myHeight = 300;
    _pickerView.hidden = YES;
    
    _dateControl = [UIControl new];
    _dateControl.frame = self.view.frame;
    _dateControl.hidden = YES;
    _dateControl.leftPos.equalTo(_content.leftPos);
    _dateControl.rightPos.equalTo(_content.rightPos);
    _dateControl.topPos.equalTo(_content.topPos);
    _dateControl.bottomPos.equalTo(_content.bottomPos);
    
    _dateControl.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
    [_dateControl addTarget:self action:@selector(closeDatePciker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dateControl];
    [self.view addSubview:_pickerView];
    
}

-(void)initList{
    _deviceListContent = [MyRelativeLayout new];
    _deviceListContent.leftPos.equalTo(_contentAll.leftPos);
    _deviceListContent.topPos.equalTo(_contentAll.topPos);
    _deviceListContent.rightPos.equalTo(_contentAll.rightPos);
    _deviceListContent.bottomPos.equalTo(_contentAll.bottomPos);
    [_deviceListContent sizeToFit];
    
    UIControl * control = [UIControl new];
    control.leftPos.equalTo(_deviceListContent.leftPos);
    control.topPos.equalTo(_deviceListContent.topPos);
    control.rightPos.equalTo(_deviceListContent.rightPos);
    control.bottomPos.equalTo(_deviceListContent.bottomPos);
    [control addTarget:self action:@selector(onKeyBack:) forControlEvents:UIControlEventTouchUpInside];
    [_deviceListContent addSubview:control];
    
    //_deviceListContent.wrapContentHeight = YES;
    //_deviceListContent.wrapContentWidth = YES;
    _deviceListContent.hidden = YES;
    control.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.3];
    
    
    UILabel *title = [UILabel new];
    title.myHeight = SCREEN_WIDTH;
    title.text = @"    选择";
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor colorWithHexString:app_style_color];
    title.myHeight = 40;
    title.topPos.equalTo(_deviceListContent.topPos).offset(60);
    title.leftPos.equalTo(_deviceListContent.leftPos).offset(30);
    title.rightPos.equalTo(_deviceListContent.rightPos).offset(30);
    
    [_deviceListContent addSubview:title];
    
    
    UIView *view = [UIView new];
    view.myHeight = 50;
    view.backgroundColor = [UIColor whiteColor];
    view.widthSize.equalTo(title.widthSize);
    view.topPos.equalTo(title.bottomPos);
    view.leftPos.equalTo(_deviceListContent.leftPos).offset(30);
    view.rightPos.equalTo(_deviceListContent.rightPos).offset(30);
    [_deviceListContent addSubview:view];
    
    
    _itemListView = [UITableView new];
    
    _itemListView.backgroundColor = [UIColor whiteColor];
    _itemListView.topPos.equalTo(title.bottomPos);
    _itemListView.leftPos.equalTo(_deviceListContent.leftPos).offset(30);
    _itemListView.rightPos.equalTo(_deviceListContent.rightPos).offset(30);
    _itemListView.myHeight = SCREEN_HEIGHT/ 2;
    _itemListView.tag = 12;
    _itemListView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    _itemListView.delegate = self;
    _itemListView.dataSource = self;
    
    [_itemListView registerClass:[ProjectTableViewCell class] forCellReuseIdentifier:ID];
    
    _itemListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_deviceListContent addSubview:_itemListView];
    
    [_contentAll addSubview:_deviceListContent];
    
    
}

-(void)initNavigation{

    
    MyRelativeLayout *leftView = [[MyRelativeLayout alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    UIButton *leftbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.myWidth = leftbtn.myHeight = 30;
    leftbtn.centerYPos.equalTo(leftView.centerYPos);
    leftbtn.leftPos.equalTo(leftView.leftPos).offset(-10);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"icon_menu.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    
   
    [leftView addSubview:leftbtn];
    [self.view addSubview:leftView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];

}

-(void)showLeftView{
    [_menuView show];
}


-(void)btnClick:(UIView *) view{
    
    NSInteger tag = view.tag;
    if (tag == 100) {
        
        //日期
        DateTimePickerView *dateView = [[DateTimePickerView alloc] initWithFrame:self.view.bounds];
        dateView.pickerViewMode = DatePickerViewDateMode;
        
        [dateView setCompletionWithBlock:^(NSString *resultDate) {
            
            self.date = resultDate;
            self.btnDate.selected = YES;
            [self.btnDate setTitle:resultDate forState:UIControlStateSelected];
        }];
        
        [self.view addSubview:dateView];
        [dateView showDateTimePickerView];
    }
    //项目
    if (tag == 101) {
        
        _itemListView.tag = 12;
        [self doProject];
    }
    //设备
    if (tag == 102) {
        if (_projectData == nil) {
            [self showMessage:@"请先选择项目"];
            return;
        }
        _itemListView.tag = 13;
        [self doDevice];
    }
    //信号
    if (tag == 103) {
        if (_deviceData == nil) {
            [self showMessage:@"请先选择设备"];
            return;
        }
        _itemListView.tag = 14;
        [self doXH];
      
    }
    //开始日期
    if (tag == 104) {

        DateTimePickerView *dateView = [[DateTimePickerView alloc] initWithFrame:self.view.bounds];
        dateView.pickerViewMode = DatePickerViewDateMode;
        
        [dateView setCompletionWithBlock:^(NSString *resultDate) {
            
        self.dateStart = resultDate;
            self.btnStartDate.selected = YES;
            [self.btnStartDate setTitle:resultDate forState:UIControlStateSelected];
        }];
        
        [self.view addSubview:dateView];
        [dateView showDateTimePickerView];
    }
    
    //结束日期
    if (tag == 105) {
        
        DateTimePickerView *dateView = [[DateTimePickerView alloc] initWithFrame:self.view.bounds];
        dateView.pickerViewMode = DatePickerViewDateMode;
        
        [dateView setCompletionWithBlock:^(NSString *resultDate) {
            
            self.dateEnd = resultDate;
            self.btnEndDate.selected = YES;
            [self.btnEndDate setTitle:resultDate forState:UIControlStateSelected];
        }];
        
        [self.view addSubview:dateView];
        [dateView showDateTimePickerView];
    }
    //设置对比
    if (tag == 106) {
        AddViewController *addVC = [AddViewController new];
        addVC.otherData = _typeData;
        addVC.dataBack = ^(NSArray *data) {
            _typeData = [NSMutableArray arrayWithArray:data];
            NSString *text = @"";
            for (int i = 0 ; i < _typeData.count; i++) {
                if (i != 0) {
                    text = [NSString stringWithFormat:@"%@\n%@-%@",text,_typeData[i][@"ProjectInfoName"],_typeData[i][@"TagName"]];
                }else{
                    text = [NSString stringWithFormat:@"%@%@-%@",text,_typeData[i][@"ProjectInfoName"],_typeData[i][@"TagName"]];
                }
            }
            
            self.btnDB.selected = YES;
            [self.btnDB setTitle:text forState:UIControlStateNormal];
            [self.btnDB setTitle:text forState:UIControlStateSelected];
        };
        [self.navigationController pushViewController:addVC animated:YES];
        
    }
    if (tag == 20) {
        //删除对比
        _typeData = nil;
        _btnDB.selected = NO;
        [_btnDB setTitle:@"选择对比" forState:UIControlStateNormal];
        [_btnDB setTitle:@"选择对比" forState:UIControlStateSelected];
    }
    //查询
    if (tag == 107) {
        
        if(_POS == 0){
            [self getData];
        }
        if(_POS == 1){
            [self getData2];
        }
        if(_POS == 2){
            [self getData3];
        }
        if(_POS == 3){
            [self getData4];
        }
       
    }
    
}

-(void) onKeyBack:(UIView *)view{
    
    _deviceListContent.hidden = YES;
    
}
-(void)doProject{
    [self showPrograssMessage:@"项目"];
    NSArray *array = [TTUtils stringToJSON:[UserDefaultUtil getData:LOGIN_ROLES]];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:array forKey:@"ids"];
    
    [self httpRequest:param methord:HTTP_PROJECTS httpResponsBack:^(NSArray *httpBack) {
        
        [self closePrograssMessage];
        if (httpBack != nil) {
            self.deviceListContent.hidden = NO;
            self.projectDatas = httpBack;
            [self.itemListView reloadData];
        }else{
            [self showMessage:@"获取失败"];
        }
    }];
}

-(void)setChars1:(NSArray *)data{
        _chartView.frame = CGRectMake(0, 0, SCREEN_WIDTH * 2, _bottomContent1.frame.size.height);
    
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
        [lineDataSet setMode:LineChartModeCubicBezier];
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
    _chartView.frame = CGRectMake(0, 0, SCREEN_WIDTH * 2, _bottomContent1.frame.size.height);
    
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
        
        [lineDataSet setMode:LineChartModeCubicBezier];
        [lineDataSet setColor:lineColor];
        [lineDataSet setCircleColor:lineColor];
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
-(void)doDevice{
    [self showPrograssMessage:@"设备"];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:_projectData[@"ProjectInfoCode"] forKey:@"ProjectInfoCode"];
    [param setObject:@"100" forKey:@"ResultsPerPage"];
    [param setObject:@"0" forKey:@"Page"];
    
    
    [self httpRequest:param methord:HTTP_HXZ httpResponsBack:^(NSDictionary *httpBack) {
        
        [self closePrograssMessage];
        if ([self httpIsSuccess:httpBack]) {
            self.deviceListContent.hidden = NO;
            self.deviceDatas = httpBack[@"Entitys"];
        
            
            [self.itemListView reloadData];
            
            _xData = nil;
            _btnXH.selected = NO;
            [_btnXH setTitle:@"选择信号" forState:UIControlStateSelected];
            [_btnXH setTitle:@"选择信号" forState:UIControlStateNormal];
            
            
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}

-(void)doXH{
    [self showPrograssMessage:@"信号"];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:_deviceData[@"TagGroupInfoId"] forKey:@"TagGroupInfoId"];
    [param setObject:@"100" forKey:@"ResultsPerPage"];
    [param setObject:@"0" forKey:@"Page"];
    
    
    [self httpRequest:param methord:HTTP_HX httpResponsBack:^(NSDictionary *httpBack) {
        
        [self closePrograssMessage];
        if ([self httpIsSuccess:httpBack]) {
            self.deviceListContent.hidden = NO;
            
            self.xhDatas = [NSMutableArray new];
            if (self.POS ==0) {
                NSDictionary *dic = @{@"TagName":@"全部",@"TagCode":@""};
                [self.xhDatas addObject:dic];
                for (NSDictionary *dic in httpBack[@"Entitys"]) {
                    if ([dic[@"TagType"] intValue] == 0) {
                        [self.xhDatas addObject:dic];
                    }
                }
            }
            
            if (self.POS ==2) {
                NSDictionary *dic = @{@"TagName":@"全部",@"TagCode":@""};
                [self.xhDatas addObject:dic];
                for (NSDictionary *dic in httpBack[@"Entitys"]) {
                    if ([dic[@"TagType"] intValue] == 0) {
                        [self.xhDatas addObject:dic];
                    }
                }
            }
            
            if (self.POS ==3) {
                NSDictionary *dic = @{@"TagName":@"全部"};
                [self.xhDatas addObject:dic];
                for (NSDictionary *dic in httpBack[@"Entitys"]) {
                    if ([dic[@"TagType"] intValue] == 3 && [dic[@"TagAlarmType"] intValue] == 1) {
                        [self.xhDatas addObject:dic];
                    }
                }
            }
            
            [self.itemListView reloadData];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}

-(void)showDatePciker{
    
    _pickerView.hidden = NO;
    _dateControl.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        
        [_pickerView show];
    }];
}

-(void)closeDatePciker{
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        
        _pickerView.hidden = YES;
        _dateControl.hidden = YES;
    }];
}
-(void)getData{
    if ([TTUtils isEmpty:_date]) {
        [self showMessage:@"请选择日期"];
        return;
    }
    if (_projectData == nil) {
        [self showMessage:@"请选择项目"];
        return;
    }
    if (_deviceData == nil) {
        [self showMessage:@"请选择设备"];
        return;
    }
    if (_xhData == nil) {
        [self showMessage:@"请选择信号"];
        return;
    }
    
    
    NSMutableArray *codes = [NSMutableArray new];
    if ([@"全部" isEqualToString:_xhData[@"TagName"]]) {
        for (int i = 1; i < _xhDatas.count; i++) {
            [codes addObject:_xhDatas[i][@"TagCode"]];
        }
    }else{
        [codes addObject:_xhData[@"TagCode"]];
    }
    
    [self showPrograssMessage:@"查询"];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:_projectData[@"ProjectInfoCode"] forKey:@"ProjectInfoCode"];
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ %@",_date,@"00:00:00"] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"StartTime"];
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ %@",_date,@"23:59:59"] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"EndTime"];
    [param setObject:@"60" forKey:@"interval"];
    [param setObject:codes forKey:@"tagCodes"];

    
    
    [self httpRequest:param methord:HTTP_MAIN2_SEARCH1 httpResponsBack:^(NSDictionary *httpBack) {
        
        [self closePrograssMessage];
        if ([self httpIsSuccess:httpBack]) {
            
            [self setChars1:httpBack[@"Entitys"]];
            self.data = httpBack[@"Entitys"];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
    
    
    
}
-(void)getData2{
    if ([TTUtils isEmpty:_date]) {
        [self showMessage:@"请选择日期"];
        return;
    }
    if (_typeData == nil || _typeData.count == 0) {
        [self showMessage:@"请设置对比"];
        return;
    }
  
    
    
    NSMutableArray *codes = [NSMutableArray new];
    for (int i = 0; i < _typeData.count; i++) {

        NSString *tagCode = _typeData[i][@"TagCode"];
        NSString *ProjectInfoCode = _typeData[i][@"ProjectInfoCode"];
        NSMutableDictionary *item = [NSMutableDictionary new];
        [item setValue:[NSString stringWithFormat:@"%@",tagCode] forKey:@"TagCode"];
        [item setValue:[NSString stringWithFormat:@"%@",ProjectInfoCode] forKey:@"ProjectInfoCode"];
        [codes addObject:item];
    }
    
    
    [self showPrograssMessage:@"查询"];
    NSMutableDictionary * param = [NSMutableDictionary new];
    

    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ %@",_date,@"00:00:00"] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"startTime"];
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ %@",_date,@"23:59:59"] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"endTime"];
    [param setObject:@"60" forKey:@"interval"];
    [param setObject:codes forKey:@"tagList"];

    [self httpRequest:param methord:HTTP_MAIN2_SEARCH2 httpResponsBack:^(NSDictionary *httpBack) {
        
        [self closePrograssMessage];
        if ([self httpIsSuccess:httpBack]) {
            
            [self setChars2:httpBack[@"Entitys"]];
            self.data = httpBack[@"Entitys"];

        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
    
}
-(void)getData3{
   
    if (_projectData == nil) {
        [self showMessage:@"请选择项目"];
        return;
    }
    if (_deviceData == nil) {
        [self showMessage:@"请选择设备"];
        return;
    }
    if (_xhData == nil) {
        [self showMessage:@"请选择信号"];
        return;
    }
    if ([TTUtils isEmpty:_dateStart]) {
        [self showMessage:@"请选择开始时间"];
        return;
    }
    if ([TTUtils isEmpty:_dateEnd]) {
        [self showMessage:@"请选择结束时间"];
        return;
    }
    
   
    NSMutableArray *codes = [NSMutableArray new];
    if ([@"全部" isEqualToString:_xhData[@"TagName"]]) {
        for (int i = 1; i < _xhDatas.count; i++) {
            [codes addObject:_xhDatas[i][@"TagCode"]];
        }
    }else{
        [codes addObject:_xhData[@"TagCode"]];
    }
    
    [self showPrograssMessage:@"查询"];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:[NSString stringWithFormat:@"%@",_projectData[@"ProjectInfoCode"]] forKey:@"ProjectInfoCode"];
    [param setObject:[NSString stringWithFormat:@"%@",_deviceData[@"TagGroupInfoId"]] forKey:@"tagGroupInfoId"];
  //  [param setObject:_xhData[@"TagCode"] forKey:@"ProjectInfoCode"];

    
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ %@",_dateStart,@"00:00:00"] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"startTime"];
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ %@",_dateEnd,@"23:59:59"] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"endTime"];
    [param setObject:[NSString stringWithFormat:@"%@",@"1"] forKey:@"Page"];
    [param setObject:[NSString stringWithFormat:@"%@",@"2000"]  forKey:@"ResultsPerPage"];
    [param setObject:codes forKey:@"tagCodes"];
    
    
    [self httpRequest:param methord:HTTP_MAIN2_SEARCH3 httpResponsBack:^(NSDictionary *httpBack) {
        
        [self closePrograssMessage];
        if ([self httpIsSuccess:httpBack]) {
            
            _ListData3 = httpBack[@"Entitys"];
            [_dataList3 reloadData];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
    
}
-(void)getData4{
    
    if (_projectData == nil) {
        [self showMessage:@"请选择项目"];
        return;
    }
    if (_deviceData == nil) {
        [self showMessage:@"请选择设备"];
        return;
    }
    if (_xhData == nil) {
        [self showMessage:@"请选择信号"];
        return;
    }
    if ([TTUtils isEmpty:_dateStart]) {
        [self showMessage:@"请选择开始时间"];
        return;
    }
    if ([TTUtils isEmpty:_dateEnd]) {
        [self showMessage:@"请选择结束时间"];
        return;
    }
    
    
    NSMutableArray *codes = [NSMutableArray new];
    if ([@"全部" isEqualToString:_xhData[@"TagName"]]) {
        for (int i = 1; i < _xhDatas.count; i++) {
            [codes addObject:_xhDatas[i][@"TagCode"]];
        }
    }else{
        [codes addObject:_xhData[@"TagCode"]];
    }
    
    [self showPrograssMessage:@"查询"];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:[NSString stringWithFormat:@"%@",_projectData[@"ProjectInfoCode"]] forKey:@"ProjectInfoCode"];
    [param setObject:[NSString stringWithFormat:@"%@",_deviceData[@"TagGroupInfoId"]] forKey:@"tagGroupInfoId"];
    //  [param setObject:_xhData[@"TagCode"] forKey:@"ProjectInfoCode"];
    
    
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ %@",_dateStart,@"00:00:00"] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"startTime"];
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ %@",_dateEnd,@"23:59:59"] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"endTime"];
    [param setObject:[NSString stringWithFormat:@"%@",@"1"] forKey:@"Page"];
    [param setObject:[NSString stringWithFormat:@"%@",@"2000"]  forKey:@"ResultsPerPage"];
    [param setObject:codes forKey:@"tagCodes"];
    
    
    [self httpRequest:param methord:HTTP_MAIN2_SEARCH4 httpResponsBack:^(NSDictionary *httpBack) {
        
        [self closePrograssMessage];
        if ([self httpIsSuccess:httpBack]) {
            
            _ListData4 = httpBack[@"Entitys"];
            [_dataList4 reloadData];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 12) {
        return _projectDatas.count;
    }
    if (tableView.tag == 13) {
        return _deviceDatas.count;
    }
    if (tableView.tag == 14) {
        return _xhDatas.count;
    }
    
    if (tableView.tag == 33) {
        return _ListData3.count;
    }
    if (tableView.tag == 44) {
        return _ListData4.count;
    }
    return 0;
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView.tag == 12) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        ProjectTableViewCell *cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setData:_projectDatas[indexPath.row]];
        
        
        return cell;
    }
    if (tableView.tag == 13) {
        
        XHTableViewCell *cell = [[XHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
        [cell setData:_deviceDatas[indexPath.row]];
        
        return cell;
    }
    if (tableView.tag == 14) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        XHZTableViewCell *cell = [[XHZTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID3];
       
        [cell setData:_xhDatas[indexPath.row]];
        
        
        return cell;
    }
    
    if (tableView.tag == 33) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        Main23TableViewCell *cell = [[Main23TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID4];
        
        [cell setData:_ListData3[indexPath.row] index:indexPath.row];
        
        
        return cell;
    }
    if (tableView.tag == 44) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        Main24TableViewCell *cell = [[Main24TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID5];
        
        [cell setData:_ListData4[indexPath.row] index:indexPath.row];
        
        
        return cell;
    }
   
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 12) {
        _projectData = _projectDatas[indexPath.row];
        _btnPro.selected = YES;
        [_btnPro setTitle:_projectData[@"ProjectInfoName"] forState:UIControlStateSelected];
        [_btnPro setTitle:_projectData[@"ProjectInfoName"] forState:UIControlStateNormal];
    }
    if (tableView.tag == 13) {
        _deviceData = _deviceDatas[indexPath.row];
        _btnDevice.selected = YES;
        [_btnDevice setTitle:_deviceData[@"TagGroupName"] forState:UIControlStateSelected];
        [_btnDevice setTitle:_deviceData[@"TagGroupName"] forState:UIControlStateNormal];
        }
    if (tableView.tag == 14) {
        _xhData = _xhDatas[indexPath.row];
        _btnXH.selected = YES;
        [_btnXH setTitle:_xhData[@"TagName"] forState:UIControlStateSelected];
        [_btnXH setTitle:_xhData[@"TagName"] forState:UIControlStateNormal];
    }
    _deviceListContent.hidden = YES;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 12) {
        return 42;
    }
    if (tableView.tag == 13) {
        return 42;
    }
    if (tableView.tag == 14) {
        return 42;
    }
    return 40;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textChangeEvent:(id)sender{
    
    UITextField *field = (UITextField *)sender;
    
    
}

//时间选择器
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer{
    
    [self closeDatePciker];
   
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate{
    [self closeDatePciker];
    
    
}

-(void)setView{
    _xData = nil;
    _btnXH.selected = NO;
    [_btnXH setTitle:@"选择信号" forState:UIControlStateNormal];
    
    _ListData3 = @[];
    [_dataList3 reloadData];
    
    _ListData4 = @[];
    [_dataList4 reloadData];
    
    _chartView.backgroundColor = [UIColor clearColor];
    _chartView.hidden = YES;
    
    if (_POS ==0) {
        _btns[0].hidden = NO;
        _lines[0].hidden = NO;
        _btns[1].hidden = NO;
        _lines[1].hidden = NO;
        _btns[2].hidden = NO;
        _lines[2].hidden = NO;
        _btns[3].hidden = NO;
        _lines[3].hidden = NO;
        _btns[4].hidden = YES;
        _lines[4].hidden = YES;
        _btns[5].hidden = YES;
        _lines[5].hidden = YES;
        _btns[6].hidden = YES;

        
        _bottomContent1.hidden = NO;
        _bottomContent3.hidden = YES;
        _bottomContent4.hidden = YES;
    }
    
    if (_POS == 1) {
        _btns[0].hidden = NO;
        _lines[0].hidden = NO;
        _btns[1].hidden = YES;
        _lines[1].hidden = YES;
        _btns[2].hidden = YES;
        _lines[2].hidden = YES;
        _btns[3].hidden = YES;
        _lines[3].hidden = YES;
        _btns[4].hidden = YES;
        _lines[4].hidden = YES;
        _btns[5].hidden = YES;
        _lines[5].hidden = YES;
        _btns[6].hidden = NO;
        
        _bottomContent1.hidden = NO;
        _bottomContent3.hidden = YES;
        _bottomContent4.hidden = YES;
    }
    
    if (_POS == 2) {
        _btns[0].hidden = YES;
        _lines[0].hidden = YES;
        _btns[1].hidden = NO;
        _lines[1].hidden = NO;
        _btns[2].hidden = NO;
        _lines[2].hidden = NO;
        _btns[3].hidden = NO;
        _lines[3].hidden = NO;
        _btns[4].hidden = NO;
        _lines[4].hidden = NO;
        _btns[5].hidden = NO;
        _lines[5].hidden = NO;
        _btns[6].hidden = YES;
        
        _bottomContent1.hidden = YES;
        _bottomContent3.hidden = NO;
        _bottomContent4.hidden = YES;
    }
    if (_POS == 3) {
        _btns[0].hidden = YES;
        _lines[0].hidden = YES;
        _btns[1].hidden = NO;
        _lines[1].hidden = NO;
        _btns[2].hidden = NO;
        _lines[2].hidden = NO;
        _btns[3].hidden = NO;
        _lines[3].hidden = NO;
        _btns[4].hidden = NO;
        _lines[4].hidden = NO;
        _btns[5].hidden = NO;
        _lines[5].hidden = NO;
        _btns[6].hidden = YES;
        
        _bottomContent1.hidden = YES;
        _bottomContent3.hidden = YES;
        _bottomContent4.hidden = NO;
    }
}

@end



