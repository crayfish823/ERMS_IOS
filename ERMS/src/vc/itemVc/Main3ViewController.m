//
//  Main3ViewController.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "Main3ViewController.h"
#import "MessageDetailViewController.h"
#import "MyRelativeLayout.h"
#import "MyLinearLayout.h"
#import "ProjectTableViewCell.h"
#import "XHZTableViewCell.h"
#import "XHTableViewCell.h"
#import "Main3TableViewCell.h"
#import "Const.h"
#import "Colors.h"
#import "UIColor+Hex.h"
#import "UserDefaultUtil.h"
#import "TTUtils.h"
#import "DateTimePickerView.h"
#import "CDZPicker.h"
@interface Main3ViewController ()
@property UIScrollView *scroll;
@property MyRelativeLayout *contentAll;
@property MyLinearLayout *content;

@property UITableView *dataList;

@property UITableView *itemListView;
@property NSArray *projectDatas;
@property NSDictionary *projectData;
@property NSArray *deviceDatas;
@property NSDictionary *deviceData;

@property NSArray *xhDatas;
@property NSDictionary *xhData;
@property NSArray *xhzDatas;
@property NSDictionary *xhzData;



@property NSString *date;
@property NSString *result;
@property MyRelativeLayout *deviceListContent;



@property UIButton *btnPro,*btnDevice,*btnDate,*btnResult;

@property UITextView *textView;
//时间选择器
@property THDatePickerView *pickerView;
@property int tagDateClick;
@property UIControl *dateControl;
@end

@implementation Main3ViewController
static NSString *ID = @"ViewController";
static NSString *ID2 = @"ViewController2";
static NSString *ID3 = @"ViewController3";
static NSString *ID4 = @"ViewController4";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"售后";
    
    
    //初始化数据

    
    _contentAll = [MyRelativeLayout new];
    _contentAll.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    self.view = _contentAll;
    
    UIFont *textFont = [UIFont systemFontOfSize:14];
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    int jg = 10;
    _content = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    _content.myWidth = SCREEN_WIDTH;


    _content.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    [_contentAll addSubview:_content];
    
    // [self.view addSubview:_content];
    
    //项目
    MyRelativeLayout *content1 = [MyRelativeLayout new];
    content1.myWidth = SCREEN_WIDTH;
    content1.myHeight = 50;
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
    content2.myHeight = 50;
    content2.wrapContentHeight = YES;
    content2.leftPadding = 10;
    content2.rightPadding = 10;
    [_content addSubview:content2];
    
    UILabel *lab2 = [UILabel new];
    lab2.text = @"设备名称:";
    lab2.font = textFont;
    lab2.wrapContentWidth = YES;
    lab2.wrapContentHeight = YES;
    lab2.leftPos.equalTo(content2.leftPos).offset(jg);
    lab2.centerYPos.equalTo(content2.centerYPos);
    [content2 addSubview:lab2];
    
    
    _btnDevice = [UIButton new];
    _btnDevice.wrapContentHeight = YES;
    [_btnDevice setTitle:@"选择设备名称" forState:UIControlStateNormal];
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
    
    
    //维保时间
    MyRelativeLayout *content3 = [MyRelativeLayout new];
    content3.myWidth = SCREEN_WIDTH;
    content3.myHeight = 50;
    content3.wrapContentHeight = YES;
    content3.leftPadding = 10;
    content3.rightPadding = 10;
    [_content addSubview:content3];
    
    UILabel *lab3 = [UILabel new];
    lab3.text = @"维保时间:";
    lab3.font = textFont;
    lab3.wrapContentWidth = YES;
    lab3.wrapContentHeight = YES;
    lab3.leftPos.equalTo(content3.leftPos).offset(jg);
    lab3.centerYPos.equalTo(content3.centerYPos);
    [content3 addSubview:lab3];
    
    
    _btnDate = [UIButton new];
    _btnDate.wrapContentHeight = YES;
    [_btnDate setTitle:@"选择维保时间" forState:UIControlStateNormal];
    _btnDate.titleLabel.font = textFont;
    [_btnDate setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnDate setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnDate.leftPos.equalTo(lab3.rightPos).offset(10);
    _btnDate.rightPos.equalTo(content3.rightPos).offset(jg);
    _btnDate.centerYPos.equalTo(content3.centerYPos);
    _btnDate.myWidth = SCREEN_WIDTH;
    _btnDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnDate.tag = 103;
    [_btnDate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content3 addSubview:_btnDate];
    
    UIImageView *image3 = [UIImageView new];
    image3.image = [UIImage imageNamed:@"down_image"];
    image3.myWidth = 20;
    image3.myHeight = 20;
    image3.rightPos.equalTo(_btnDate.rightPos);
    image3.centerYPos.equalTo(lab3.centerYPos);
    [content3 addSubview:image3];
    
    UIView *line3 = [UIView new];
    line3.myWidth = SCREEN_WIDTH;
    line3.myHeight = 3;
    line3.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line3];
    
    //维保结果
    MyRelativeLayout *content4 = [MyRelativeLayout new];
    content4.myWidth = SCREEN_WIDTH;
    content4.myHeight = 50;
    content4.wrapContentHeight = YES;
    content4.leftPadding = 10;
    content4.rightPadding = 10;
    [_content addSubview:content4];
    
    UILabel *lab4 = [UILabel new];
    lab4.text = @"维保结果:";
    lab4.font = textFont;
    lab4.wrapContentWidth = YES;
    lab4.wrapContentHeight = YES;
    lab4.leftPos.equalTo(content4.leftPos).offset(jg);
    lab4.centerYPos.equalTo(content4.centerYPos);
    [content4 addSubview:lab4];
    
    
    _btnResult = [UIButton new];
    _btnResult.wrapContentHeight = YES;
    [_btnResult setTitle:@"选择维保结果" forState:UIControlStateNormal];
    _btnResult.titleLabel.font = textFont;
    [_btnResult setTitleColor:[UIColor colorWithHexString:app_line_color] forState:UIControlStateNormal];
    [_btnResult setTitleColor:[UIColor colorWithHexString:app_text_color] forState:UIControlStateSelected];
    _btnResult.leftPos.equalTo(lab4.rightPos).offset(10);
    _btnResult.rightPos.equalTo(content4.rightPos).offset(jg);
    _btnResult.centerYPos.equalTo(content4.centerYPos);
    _btnResult.myWidth = SCREEN_WIDTH;
    _btnResult.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnResult.tag = 104;
    [_btnResult addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [content4 addSubview:_btnResult];
    
    UIImageView *image4 = [UIImageView new];
    image4.image = [UIImage imageNamed:@"down_image"];
    image4.myWidth = 20;
    image4.myHeight = 20;
    image4.rightPos.equalTo(_btnResult.rightPos);
    image4.centerYPos.equalTo(lab4.centerYPos);
    [content4 addSubview:image4];
    
    UIView *line4 = [UIView new];
    line4.myWidth = SCREEN_WIDTH;
    line4.myHeight = 3;
    line4.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line4];
    
    
    //描述
    MyRelativeLayout *content5 = [MyRelativeLayout new];
    content5.myWidth = SCREEN_WIDTH;
    content5.myHeight = 50;
    content5.wrapContentHeight = YES;
    content5.leftPadding = 10;
    content5.rightPadding = 10;
    [_content addSubview:content5];
    
    UILabel *lab5 = [UILabel new];
    lab5.text = @"描        述:";
    lab5.font = textFont;
    lab5.wrapContentWidth = YES;
    lab5.wrapContentHeight = YES;
    lab5.leftPos.equalTo(content5.leftPos).offset(jg);
    lab5.centerYPos.equalTo(content5.centerYPos);
    [content5 addSubview:lab5];
    
  
    
    UIView *line5 = [UIView new];
    line5.myWidth = SCREEN_WIDTH;
    line5.myHeight = 3;
    line5.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [_content addSubview:line5];
    
    //描述
    UITextView *textView = [UITextView new];
    textView.myLeft = 10;
    textView.myRight = 10;
    textView.myTop = 10;
    [textView sizeToFit];
    textView.font = textFont;
    textView.textColor = textColor;
    textView.myWidth = SCREEN_WIDTH - 20;
    textView.myHeight = 100;
    [_content addSubview:textView];
    
    _textView = textView;
    
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
    [limitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [limitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    limitBtn.layer.cornerRadius = 23;
    limitBtn.layer.masksToBounds = YES;
    [limitBtn setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:login_btn_pressed_default]] forState:UIControlStateNormal];
     [limitBtn setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:login_btn_pressed]] forState:UIControlStateSelected];
    
    [limitBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:limitBtn];
    
    
    //初始化deviceList
    [self initList];
    
    [self initDateView];
    
    
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
    //设备
    if (tag == 102) {
        if (_projectData == nil) {
            [self showMessage:@"请先选择项目"];
            return;
        }
        _itemListView.tag = 14;
        [self doDevice];
    }
    //维保时间
    if (tag == 103) {
       
        //装入数间
        DateTimePickerView *dateView = [[DateTimePickerView alloc] initWithFrame:self.view.bounds];
        dateView.pickerViewMode = DatePickerViewDateMode;
        
        [dateView setCompletionWithBlock:^(NSString *resultDate) {
          
            _date = resultDate;
            self.btnDate.selected = YES;
            [self.btnDate setTitle:resultDate forState:UIControlStateSelected];
        }];
        
        [self.view addSubview:dateView];
        [dateView showDateTimePickerView];
    }
    //完成情况
    if (tag == 104) {
        CDZPickerBuilder *builder = [CDZPickerBuilder new];
        builder.showMask = YES;
        builder.cancelTextColor = UIColor.redColor;
        [CDZPicker showSinglePickerInView:self.view withBuilder:builder strings:@[@"完成",@"未完成"] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
            
            _result = [strings firstObject];
            [self.btnResult setTitle:[strings firstObject] forState:UIControlStateSelected];
            self.btnResult.selected = YES;
            
        }cancel:^{
            //your code
        }];
    }
    
    //保存
    if (tag == 105) {
        
       
        if(_projectData == nil){
            [self showMessage:@"请选择项目"];
            return;
        }
        if(_xhzData == nil){
            [self showMessage:@"请选择设备"];
            return;
        }
        if([TTUtils isEmpty:_date]){
            [self showMessage:@"请选择维保时间"];
            return;
        }
        if([TTUtils isEmpty:_result]){
            [self showMessage:@"请选择维保结果"];
            return;
        }
        
       
        NSMutableDictionary * param = [NSMutableDictionary new];
        
        [param setObject:_xhzData[@"TagGroupInfoId"] forKey:@"TagGroupInfoId"];
        [param setObject:[NSString stringWithFormat:@"%@",[TTUtils getTime]] forKey:@"MachineMaintenanceRecId"];
        [param setObject:[@"未完成" isEqualToString:_result] ? @"0" : @"1" forKey:@"MaintenanceResult"];
        [param setObject:[NSString stringWithFormat:@"%@",[UserDefaultUtil getData:LOGIN_NAME]] forKey:@"MaintenanceMan"];
        [param setObject:[NSString stringWithFormat:@"%@",_date] forKey:@"MaintenanceTime"];
        [param setObject:[NSString stringWithFormat:@"%@",_textView.text] forKey:@"MaintenanceDes"];
        
         [self showPrograssMessage:@"提交"];
        [self httpRequest:param methord:HTTP_WB httpResponsBack:^(NSDictionary *httpBack) {
            
            [self closePrograssMessage];
            if ([self httpIsSuccess:httpBack]) {
               
                [self.btnPro setTitle:@"选择项目" forState:UIControlStateNormal];
                [self.btnPro setTitle:@"选择项目" forState:UIControlStateSelected];
                
                [self.btnDevice setTitle:@"选择设备名称" forState:UIControlStateNormal];
                [self.btnDevice setTitle:@"选择设备名称" forState:UIControlStateSelected];
                
                [self.btnDate setTitle:@"选择维保时间" forState:UIControlStateNormal];
                [self.btnDate setTitle:@"选择维保时间" forState:UIControlStateSelected];
                [self.btnResult setTitle:@"选择维保结果" forState:UIControlStateNormal];
                [self.btnResult setTitle:@"选择维保结果" forState:UIControlStateSelected];

                self.textView.text = @"";
                
                self.btnPro.selected = NO;
                self.btnResult.selected = NO;
                self.btnDate.selected = NO;
                self.btnDevice.selected = NO;
            }else{
                [self showMessage:[self httpErrorMessage:httpBack]];
            }
        }];
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
            self.xhzDatas = httpBack[@"Entitys"];
            self.itemListView.tag = 14;
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
        _pickerView.frame = CGRectMake(0, self.view.frame.size.height - 300 - 64 +15, self.view.frame.size.width, 300);
        
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
    
    
    
    if (tableView.tag == 12) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        ProjectTableViewCell *cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setData:_projectDatas[indexPath.row]];
        
        
        return cell;
    }
    if (tableView.tag == 13) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        XHTableViewCell *cell = [[XHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
        [cell setData:_xhDatas[indexPath.row]];
        
        
        return cell;
    }
    if (tableView.tag == 14) {
        //DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        XHTableViewCell *cell = [[XHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
        [cell setData:_xhzDatas[indexPath.row]];
        
        
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
//    if (tableView.tag == 13) {
//        _xhData = _xhDatas[indexPath.row];
//        [_btnPro setTitle:_projectData[@""] forState:UIControlStateNormal];
//    }
    if (tableView.tag == 14) {
        _xhzData = _xhzDatas[indexPath.row];
        _btnDevice.selected = YES;
        [_btnDevice setTitle:_xhzData[@"TagGroupName"] forState:UIControlStateSelected];
        [_btnDevice setTitle:_xhzData[@"TagGroupName"] forState:UIControlStateNormal];
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
    return 46;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textChangeEvent:(id)sender{
    
    
    
}

//时间选择器
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer{
    
    [self closeDatePciker];
   
    if (_tagDateClick == 2) {
        [UserDefaultUtil saveData:timer key:DATE_START];
        [_btnDate setTitle:timer forState:UIControlStateNormal];
    }
    
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate{
    [self closeDatePciker];


}



@end
