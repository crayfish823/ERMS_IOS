//
//  Main5ViewController.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//
#import "Main5ViewController.h"
#import "MyRelativeLayout.h"
#import "MyLinearLayout.h"
#import "TypeTableViewCell.h"
#import "Main5TableViewCell.h"
#import "ProjectTableViewCell.h"
#import "XHZTableViewCell.h"
#import "XHTableViewCell.h"
#import "Const.h"
#import "Colors.h"
#import "TTUtils.h"
#import "UIColor+Hex.h"
#import "UserDefaultUtil.h"
#import "DateTimePickerView.h"
#import "DeviceTableViewCell.h"
#import "MJRefresh.h"
@interface Main5ViewController ()
@property UIScrollView *scroll;
@property MyRelativeLayout *contentAll;
@property MyLinearLayout *content;

@property UITableView *dataList;
@property NSMutableArray *data;

@property UITableView *itemListView;
@property NSArray *projectDatas;
@property NSDictionary *projectData;

@property NSArray *xhDatas;
@property NSDictionary *xhData;
@property NSArray *xhzDatas;
@property NSDictionary *xhzData;



@property NSString *startDate,*endDate;
@property NSString *result;
@property MyRelativeLayout *deviceListContent;



@property UIButton *btnPro,*btnXH,*btnXHZ,*btnStartDate,*btnEndDate;

@property UITextView *textView;
//时间选择器
@property THDatePickerView *pickerView;
@property int tagDateClick;
@property UIControl *dateControl;
@property int page,size;
@end

@implementation Main5ViewController
static NSString *ID = @"ViewController";
static NSString *ID2 = @"ViewController2";
static NSString *ID3 = @"ViewController3";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"报警";
    
    

    //初始化数据
    
    
    _contentAll = [MyRelativeLayout new];
    _contentAll.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    self.view = _contentAll;
    
    UIFont *textFont = [UIFont systemFontOfSize:14];
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    int jg = 10;
    int height = 45;
    _content = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    _content.myWidth = SCREEN_WIDTH;
    
    
    _content.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    [_contentAll addSubview:_content];
    
    // [self.view addSubview:_content];
    
    //项目
    MyRelativeLayout *content1 = [MyRelativeLayout new];
    content1.myWidth = SCREEN_WIDTH;
    content1.myHeight = height;
    content1.wrapContentHeight = YES;
    
    content1.leftPadding = 10;
    content1.rightPadding = 10;
    [_content addSubview:content1];
    
    UILabel *lab1 = [UILabel new];
    lab1.text = @"项目名称:";
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
    
    
    _btnXHZ = [UIButton new];
    _btnXHZ.wrapContentHeight = YES;
    [_btnXHZ setTitle:@"选择设备" forState:UIControlStateNormal];
    _btnXHZ.titleLabel.font = textFont;
    [_btnXHZ setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnXHZ setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnXHZ.leftPos.equalTo(lab2.rightPos).offset(10);
    _btnXHZ.rightPos.equalTo(content2.rightPos).offset(jg);
    _btnXHZ.centerYPos.equalTo(content2.centerYPos);
    _btnXHZ.myWidth = SCREEN_WIDTH;
    _btnXHZ.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnXHZ.tag = 102;
    [_btnXHZ addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content2 addSubview:_btnXHZ];
    
    UIImageView *image2 = [UIImageView new];
    image2.image = [UIImage imageNamed:@"down_image"];
    image2.myWidth = 20;
    image2.myHeight = 20;
    image2.rightPos.equalTo(_btnXHZ.rightPos);
    image2.centerYPos.equalTo(lab2.centerYPos);
    [content2 addSubview:image2];
    
    UIView *line2 = [UIView new];
    line2.myWidth = SCREEN_WIDTH;
    line2.myHeight = 3;
    line2.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line2];
    
    
    //开始时间
    MyRelativeLayout *content3 = [MyRelativeLayout new];
    content3.myWidth = SCREEN_WIDTH;
    content3.myHeight = height;
    content3.wrapContentHeight = YES;
    content3.leftPadding = 10;
    content3.rightPadding = 10;
    [_content addSubview:content3];
    
    UILabel *lab3 = [UILabel new];
    lab3.text = @"开始时间:";
    lab3.font = textFont;
    lab3.wrapContentWidth = YES;
    lab3.wrapContentHeight = YES;
    lab3.leftPos.equalTo(content3.leftPos).offset(jg);
    lab3.centerYPos.equalTo(content3.centerYPos);
    [content3 addSubview:lab3];
    
    
    _btnStartDate = [UIButton new];
    _btnStartDate.wrapContentHeight = YES;
    [_btnStartDate setTitle:@"选择开始时间" forState:UIControlStateNormal];
    _btnStartDate.titleLabel.font = textFont;
    [_btnStartDate setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnStartDate setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnStartDate.leftPos.equalTo(lab3.rightPos).offset(10);
    _btnStartDate.rightPos.equalTo(content3.rightPos).offset(jg);
    _btnStartDate.centerYPos.equalTo(content3.centerYPos);
    _btnStartDate.myWidth = SCREEN_WIDTH;
    _btnStartDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnStartDate.tag = 103;
    [_btnStartDate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content3 addSubview:_btnStartDate];
    
    UIImageView *image3 = [UIImageView new];
    image3.image = [UIImage imageNamed:@"down_image"];
    image3.myWidth = 20;
    image3.myHeight = 20;
    image3.rightPos.equalTo(_btnStartDate.rightPos);
    image3.centerYPos.equalTo(lab3.centerYPos);
    [content3 addSubview:image3];
    
    UIView *line3 = [UIView new];
    line3.myWidth = SCREEN_WIDTH;
    line3.myHeight = 3;
    line3.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line3];
    
    //结束时间
    MyRelativeLayout *content4 = [MyRelativeLayout new];
    content4.myWidth = SCREEN_WIDTH;
    content4.myHeight = height;
    content4.wrapContentHeight = YES;
    content4.leftPadding = 10;
    content4.rightPadding = 10;
    [_content addSubview:content4];
    
    UILabel *lab4 = [UILabel new];
    lab4.text = @"结束时间:";
    lab4.font = textFont;
    lab4.wrapContentWidth = YES;
    lab4.wrapContentHeight = YES;
    lab4.leftPos.equalTo(content4.leftPos).offset(jg);
    lab4.centerYPos.equalTo(content4.centerYPos);
    [content4 addSubview:lab4];
    
    
    _btnEndDate = [UIButton new];
    _btnEndDate.wrapContentHeight = YES;
    [_btnEndDate setTitle:@"选择维保结果" forState:UIControlStateNormal];
    _btnEndDate.titleLabel.font = textFont;
    [_btnEndDate setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnEndDate setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnEndDate.leftPos.equalTo(lab4.rightPos).offset(10);
    _btnEndDate.rightPos.equalTo(content4.rightPos).offset(jg);
    _btnEndDate.centerYPos.equalTo(content4.centerYPos);
    _btnEndDate.myWidth = SCREEN_WIDTH;
    _btnEndDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnEndDate.tag = 104;
    [_btnEndDate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content4 addSubview:_btnEndDate];
    
    UIImageView *image4 = [UIImageView new];
    image4.image = [UIImage imageNamed:@"down_image"];
    image4.myWidth = 20;
    image4.myHeight = 20;
    image4.rightPos.equalTo(_btnEndDate.rightPos);
    image4.centerYPos.equalTo(lab4.centerYPos);
    [content4 addSubview:image4];
    
    UIView *line4 = [UIView new];
    line4.myWidth = SCREEN_WIDTH;
    line4.myHeight = 3;
    line4.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line4];
    
    
    
    
    UIView *line6 = [UIView new];
    line6.myWidth = SCREEN_WIDTH;
    line6.myHeight = 3;
    line6.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line6];
    
    
    UIButton *limitBtn = [UIButton new];
    limitBtn.myLeft = 30;
    limitBtn.myRight  = 30;
    limitBtn.tag = 105;
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
    
    
    //表头哦
    MyLinearLayout *headerContent = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    headerContent.myWidth = SCREEN_WIDTH;
    headerContent.myHeight = 30;
    headerContent.myTop = 10;
    headerContent.backgroundColor = [UIColor colorWithHexString:header_color];
    [_content addSubview:headerContent];
    
    NSArray *title = @[@"项目名称",@"故障名称",@"发生时间",@"处理状态"];
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
    
    
  
    
    
   
    
    _dataList = [UITableView new];
    _dataList.tag = 11;
    _dataList.myWidth = SCREEN_WIDTH;
    _dataList.myHeight = SCREEN_HEIGHT;
    _dataList.leftPos.equalTo(_contentAll.leftPos);
    _dataList.rightPos.equalTo(_contentAll.rightPos);
    _dataList.bottomPos.equalTo(_contentAll.bottomPos);
    _dataList.topPos.equalTo(_content.bottomPos);


    [_contentAll addSubview:_dataList];
    
    _dataList.delegate = self;
    _dataList.dataSource = self;
    
    [_dataList registerClass:[Main5TableViewCell class] forCellReuseIdentifier:ID];
    
    
    if ([_dataList respondsToSelector:@selector(setSeparatorInset:)]) {
        [_dataList setSeparatorInset:UIEdgeInsetsZero];
    }
    _dataList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __unsafe_unretained UITableView *tableView = _dataList;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _dataList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新数据");
        
        [self initData];
        [tableView.mj_header endRefreshing];
        
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"加载更多");
        [self getData];
        
        [tableView.mj_footer endRefreshing];
        
    }];
    // 马上进入刷新状态
   // [tableView.mj_header beginRefreshing];
    
    
   
    
    //初始化deviceList
    [self initList];
    
    [self initDateView];
    
    [_btnStartDate setTitle:[TTUtils getYYYYMMDD] forState:UIControlStateSelected];
    _btnStartDate.selected = YES;
    
//    _startDate = [TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ 00:00:00",_btnStartDate.titleLabel.text] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd"];
    _startDate=_btnStartDate.titleLabel.text;
    
    NSLog(@"%@",[TTUtils getYYYYMMDD]);
    [_btnEndDate setTitle:[TTUtils getYYYYMMDD] forState:UIControlStateSelected];
    _btnEndDate.selected = YES;
    
//    _endDate = [TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ 23:59:59",_btnEndDate.titleLabel.text] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd"];
    _endDate=_btnEndDate.titleLabel.text;
    _projectData= @{@"ProjectInfoCode":@""};
    
    _page = 0;
    _size = 20;
    [self getData];
}

-(void)initData{
    if(_projectData == nil){
        [self showMessage:@"请选择项目"];
        return;
    }
    if(_xhzData == nil){
        [self showMessage:@"请选择设备"];
        return;
    }
    if([TTUtils isEmpty:_startDate]){
        [self showMessage:@"请选择开始时间"];
        return;
    }
    if([TTUtils isEmpty:_endDate]){
        [self showMessage:@"请选择结束时间"];
        return;
    }
    
    _page = 0;
    _size = 20;
    
    [self getData];
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
-(void)btnClick:(UIView *) view{
    
    NSInteger tag = view.tag;
    
    //项目
    if (tag == 101) {
        
        _itemListView.tag = 12;
        [self doProject];
    }
    //信号组
    if (tag == 102) {
        if (_projectData == nil) {
            [self showMessage:@"请先选择项目"];
            return;
        }
        _itemListView.tag = 14;
        [self doXHZ];
    }
    //开始时间
    if (tag == 103) {
        
        DateTimePickerView *dateView = [[DateTimePickerView alloc] initWithFrame:self.view.bounds];
        dateView.pickerViewMode = DatePickerViewDateMode;
        
        [dateView setCompletionWithBlock:^(NSString *resultDate) {
            
            
            self.btnStartDate.selected = YES;
            [self.btnStartDate setTitle:resultDate forState:UIControlStateSelected];
            
            self.startDate = [TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ 00:00:00",resultDate] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd"];
        }];
        
        [self.view addSubview:dateView];
        [dateView showDateTimePickerView];
    }
    //结束时间
    if (tag == 104) {
        DateTimePickerView *dateView = [[DateTimePickerView alloc] initWithFrame:self.view.bounds];
        dateView.pickerViewMode = DatePickerViewDateMode;
        
        [dateView setCompletionWithBlock:^(NSString *resultDate) {
            
            self.btnEndDate.selected = YES;
            [self.btnEndDate setTitle:resultDate forState:UIControlStateSelected];
       
            self.endDate = [TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ 23:59:59",resultDate] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd"];
        }];
        
        [self.view addSubview:dateView];
        [dateView showDateTimePickerView];
    }
    
    //保存
    if (tag == 105) {
        
        [self initData];
    }
    
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
            self.itemListView.tag = 12;
            [self.itemListView reloadData];
        }else{
            [self showMessage:@"获取失败"];
        }
    }];
}

-(void)doXHZ{
    [self showPrograssMessage:@"信号组"];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:_projectData[@"ProjectInfoCode"] forKey:@"ProjectInfoCode"];
    [param setObject:@"100" forKey:@"ResultsPerPage"];
    [param setObject:@"0" forKey:@"Page"];
    
    
    [self httpRequest:param methord:HTTP_HXZ httpResponsBack:^(NSDictionary *httpBack) {
        
        [self closePrograssMessage];
        if ([self httpIsSuccess:httpBack]) {
            self.deviceListContent.hidden = NO;
            self.xhzDatas = httpBack[@"Entitys"];
            self.itemListView.tag = 14;
            [self.itemListView reloadData];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}
-(void)getData{
    
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    
//    [param setObject:_startDate forKey:@"StartTime"];
//    [param setObject:_endDate forKey:@"EndTime"];
    
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ 00:00:00",_startDate] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"StartTime"];
    [param setObject:[TTUtils dateNowToUTC:[NSString stringWithFormat:@"%@ 23:59:59",_endDate] oldSf:@"yyyy-MM-dd HH:mm:ss" nowSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] forKey:@"EndTime"];
    
    [param setObject:_projectData[@"ProjectInfoCode"] forKey:@"ProjectInfoCode"];
    
    [param setObject:[NSString stringWithFormat:@"%i",_page] forKey:@"Page"];
    [param setObject:[NSString stringWithFormat:@"%i",_size] forKey:@"ResultsPerPage"];
    
    [param setObject:[UserDefaultUtil getData:USER_ID] forKey:@"UserId"];
    [param setObject:@"-1" forKey:@"IsRead"];

    
    [self showPrograssMessage:@"加载"];
    [self httpRequest:param methord:HTTP_BJ httpResponsBack:^(NSDictionary *httpBack) {
        
        [self closePrograssMessage];
        
        if ([self httpIsSuccess:httpBack]) {
            if (self.page == 0) {
                self.data = [NSMutableArray new];
            }
            self.page++;
            
            [self.data addObjectsFromArray:httpBack[@"Entitys"]];
           
            [self.dataList reloadData];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}


-(void) onItemEvent:(UIView *)view{
    
    //    int tag = view.tag;
    //    NSLog(@"tag = = %i",tag);
}

-(void) onKeyBack:(UIView *)view{
    
    _deviceListContent.hidden = YES;

    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 11) {
        return _data.count;
    }
    
    if (tableView.tag == 12) {
        return _projectDatas.count;
    }
    if (tableView.tag == 13) {
        return _xhDatas.count;
    }
    if (tableView.tag == 14) {
        return _xhzDatas.count;
    }
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 11) {
        Main5TableViewCell *cell = [[Main5TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setData:_data[indexPath.row] index:indexPath.row];
        
        
        return cell;
    }
    
    if (tableView.tag == 12) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        ProjectTableViewCell *cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setData:_projectDatas[indexPath.row]];
        
        
        return cell;
    }
//    if (tableView.tag == 13) {
//        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        
//        XHTableViewCell *cell = [[XHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
//        [cell setData:_xhDatas[indexPath.row]];
//        
//        
//        return cell;
//    }
    if (tableView.tag == 14) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        XHTableViewCell *cell = [[XHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID3];

        [cell setData:_xhzDatas[indexPath.row] ];
        
        
        return cell;
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (tableView.tag == 12) {
        _projectData = _projectDatas[indexPath.row];
        _btnPro.selected = YES;
        [_btnPro setTitle:_projectData[@"ProjectInfoName"] forState:UIControlStateSelected];
        [_btnPro setTitle:_projectData[@"ProjectInfoName"] forState:UIControlStateNormal];
    }
    //    if (tableView.tag == 13) {
    //        _xhData = _xhDatas[indexPath.row];
    //        [_btnPro setTitle:_projectData[@""] forState:UIControlStateNormal];
    //    }
    if (tableView.tag == 14) {
        _xhzData = _xhzDatas[indexPath.row];
        _btnXHZ.selected = YES;
        [_btnXHZ setTitle:_xhzData[@"TagGroupName"] forState:UIControlStateSelected];
        [_btnXHZ setTitle:_xhzData[@"TagGroupName"] forState:UIControlStateNormal];
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
    
    
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate{
    
    
}



@end
