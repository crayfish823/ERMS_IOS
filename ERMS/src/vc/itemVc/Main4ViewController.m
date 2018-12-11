//
//  Main3ViewController.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "Main4ViewController.h"
#import "MessageDetailViewController.h"
#import "MyRelativeLayout.h"
#import "MyLinearLayout.h"
#import "DeviceTableViewCell.h"
#import "Main4TableViewCell.h"
#import "MJRefresh.h"
#import "Const.h"
#import "Colors.h"
#import "UIColor+Hex.h"
#import "UserDefaultUtil.h"
#import "TTUtils.h"
@interface Main4ViewController ()


@property MyRelativeLayout *content;

@property UITableView *dataList;

@property NSMutableArray *data;

@property int page,size;



@end

@implementation Main4ViewController
static NSString *ID = @"ViewController";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    
    //初始化数据
   
    _data = [NSMutableArray new];
    

    _content = [MyRelativeLayout new];
    _content.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    self.view = _content;
   
    
    
    //数据列表
    _dataList = [UITableView new];
    
    _dataList.topPos.equalTo(_content.topPos);
    _dataList.leftPos.equalTo(_content.leftPos);
    _dataList.rightPos.equalTo(_content.rightPos);
    _dataList.bottomPos.equalTo(_content.bottomPos);
    _dataList.tag = 11;
    _dataList.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _dataList.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    _dataList.delegate = self;
    _dataList.dataSource = self;
    
    [_dataList registerClass:[Main4TableViewCell class] forCellReuseIdentifier:ID];
   
    
    [_content addSubview:_dataList];
    
    
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
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    [self initData];

}


-(void)initData{
    _page = 0;
    _size = 20;
    
    [self getData];
}


-(void)getData{
    

    
   
    NSMutableDictionary *param = [NSMutableDictionary new];
    
  
    
    [param setObject:[NSString stringWithFormat:@"%i",_page] forKey:@"Page"];
    [param setObject:[NSString stringWithFormat:@"%i",_size] forKey:@"ResultsPerPage"];
    
    [param setObject:[UserDefaultUtil getData:USER_ID] forKey:@"UserId"];
    
    
    [self showPrograssMessage:@"加载"];
    [self httpRequest:param methord:HTTP_MESSAGE httpResponsBack:^(NSDictionary *httpBack) {
        
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

-(void) onKeyBack:(UIView *)view{
    
   
    
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
    

    return self.data.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Main4TableViewCell *cell = [[Main4TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    [cell setData:_data[indexPath.row] index:indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MessageDetailViewController *msgDetail = [MessageDetailViewController new];
    msgDetail.data = _data[indexPath.row];
    [self.navigationController pushViewController:msgDetail animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 84;
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
