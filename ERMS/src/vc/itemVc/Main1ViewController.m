//
//  Main2ViewController.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "Main1ViewController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
#import "Main1TableViewCell.h"
#import "MyRelativeLayout.h"
#import "Const.h"
#import "TTUtils.h"
#import "UserDefaultUtil.h"
#import "DeviceViewController.h"
#import "DocumentViewController.h"
#import "MapViewController.h"
@interface Main1ViewController ()

@property NSArray *data;
@property UITableView *tableView;
@property int page,size;
@end

@implementation Main1ViewController

static NSString *ID = @"ViewController";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"首页";
    [self initNavigationBar];
    
    _data = [NSArray new];
    _page = 1;
    _size = 20;
  
    self.view.backgroundColor = [UIColor whiteColor] ;

    MyRelativeLayout * content = [MyRelativeLayout new];
    content.frame = self.view.frame;
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.topPos.equalTo(content.topPos);
    _tableView.leftPos.equalTo(content.leftPos);
    _tableView.rightPos.equalTo(content.rightPos);
    _tableView.bottomPos.equalTo(content.bottomPos).offset(64);
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [content addSubview:_tableView];
    [self.view addSubview:content];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[Main1TableViewCell class] forCellReuseIdentifier:ID];
    
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __unsafe_unretained UITableView *tableView = _tableView;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新数据");
        
        _page = 1;
        [self getData];
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
    [tableView.mj_header beginRefreshing];
    
    
    
    
}

-(void)initNavigationBar{
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStyleBordered target:self action:@selector(rightClick)];
    [rightBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)rightClick{
    MapViewController *mapVc = [MapViewController new];
    [self.navigationController pushViewController:mapVc animated:YES];
}

-(void)getData{
    
    
    NSArray *array = [TTUtils stringToJSON:[UserDefaultUtil getData:LOGIN_ROLES]];
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:array forKey:@"ids"];
    
    [self httpRequest:param methord:HTTP_PROJECTS httpResponsBack:^(NSArray *httpBack) {
        
        if (httpBack != nil) {
            self.data = httpBack;
            [self.tableView reloadData];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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
    
    return _data.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Main1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
   // Main1TableViewCell *cell = [[Main1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    [cell setData:_data[indexPath.row] index:indexPath.row];
    
    [cell.rightBtn addTarget:self action:@selector(cellDocumentClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.leftBtn addTarget:self action:@selector(cellDeviceClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)cellDeviceClick:(UIView *)v{
    long tag = v.tag;
    
    DeviceViewController *deviceVc = [DeviceViewController new];
    deviceVc.ProjectInfoCode = [NSString stringWithFormat:@"%@",_data[tag][@"ProjectInfoCode"]];
    [self.navigationController pushViewController:deviceVc animated:YES];
    
}
-(void)cellDocumentClick:(UIView *)v{
    long tag = v.tag;
    
    DocumentViewController *doicumentVc = [DocumentViewController new];
    doicumentVc.ProjectInfoId = _data[tag][@"ProjectInfoId"];
    [self.navigationController pushViewController:doicumentVc animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

@end
