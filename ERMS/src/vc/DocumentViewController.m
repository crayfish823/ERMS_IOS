//
//  DocumentViewController.m
//  ERMS
//
//  Created by tangtang on 2018/8/5.
//  Copyright © 2018年 tangtang. All rights reserved.
//
#import "Main1ViewController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
#import "DocumentTableViewCell.h"
#import "MyRelativeLayout.h"
#import "Const.h"
#import "TTUtils.h"
#import "UserDefaultUtil.h"
#import "DeviceViewController.h"
#import "DocumentViewController.h"
#import "AFNetworking.h"
#import "PDFViewController.h"

@interface DocumentViewController ()

@property NSMutableArray *data;
@property UITableView *tableView;
@property int page,size;
@property NSString * filePath;
@end

@implementation DocumentViewController

static NSString *ID = @"ViewController";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"资料";
    [self initNavigationBar];
    self.parentViewController.tabBarController.tabBar.hidden = YES;

    _page = 0;
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
    
    [_tableView registerClass:[DocumentTableViewCell class] forCellReuseIdentifier:ID];
    
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __unsafe_unretained UITableView *tableView = _tableView;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新数据");
        
        _page = 0;
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
    
    
    
}

-(void)rightClick{
    
}

-(void)getData{
    
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:_ProjectInfoId forKey:@"ProjectInfoId"];
    [param setObject:[NSString stringWithFormat:@"%i",_page] forKey:@"Page"];
    [param setObject:[NSString stringWithFormat:@"%i",_size] forKey:@"ResultsPerPage"];
    
    [self httpRequest:param methord:HTTP_DOCUMENT httpResponsBack:^(NSDictionary *httpBack) {
        
        if ([self httpIsSuccess:httpBack]) {
            if (self.page == 0) {
                self.data = [NSMutableArray new];
            }
            self.page++;
            [self.data addObjectsFromArray:httpBack[@"Entitys"]];
            [self.tableView reloadData];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}
-(void)downPdf:(NSString *) ID fileName:(NSString *)fileName{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* _filePath = [paths objectAtIndex:0];
    
    NSString *serviceURL = [UserDefaultUtil getData:URL];
    if([TTUtils isEmpty:serviceURL]){
        serviceURL = SERVICE_URL;
    }
        
    //File Url
    NSString* fileUrl = [NSString stringWithFormat:@"%@%@",serviceURL,fileName];
    
    //Encode Url 如果Url 中含有空格，一定要先 Encode
    fileUrl = [fileUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString* filePath = [_filePath stringByAppendingPathComponent:fileName];

    NSString *urlStr = [NSString stringWithFormat:@"%@%@",serviceURL,HTTP_DOWNLOAD];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求方法为 HEAD 方法，这里只是头，数据量少，用同步请求也可以，不过最好还是用异步请求
    request.HTTPMethod = @"HEAD";
    // 无论是否会引起循环引用，block里面都使用弱引用
    __weak typeof(self) weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 出错则返回
        if (connectionError != nil) {
            NSLog(@"connectionError = %@",connectionError);
            return ;
        }
        // 记录需要下载的文件总长度
        long long serverFileLength = response.expectedContentLength;
        // 初始化已下载文件大小
        
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL];
        
        long long  localFileLength = [dict[NSFileSize] longLongValue];
        
        // 如果没有本地文件,直接下载!
        if (!localFileLength) {
            // 下载新文件
        } else if (localFileLength == serverFileLength) {
            NSLog(@"文件已经下载完毕");
        } else if (localFileLength && localFileLength < serverFileLength) {
          
        }
    }];
    
}

/// 2. 接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //data当前接收到的网络数据;
    // 如果这个文件不存在,响应的文件句柄就不会创建!
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
    
    // 第一次调用这个方法的时候,在本地还没有文件路径(没有这个文件)!
    [data writeToFile:self.filePath atomically:YES];
    // 在这个路径下已经有文件了!
//    if (fileHandle) {
//        // 将文件句柄移动到文件的末尾
//        [fileHandle seekToEndOfFile];
//        // 写入文件的意思(会将data写入到文件句柄所操纵的文件!)
//        [fileHandle writeData:data];
//        
//        [fileHandle closeFile];
//        
//    } else {
//        
//    }
}
/// 3. 接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"下载完成");
}
/// 4. 网络错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"下载错误 %@", error);
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
    
    return _data.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DocumentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // Main1TableViewCell *cell = [[Main1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    [cell setData:_data[indexPath.row] index:indexPath.row];
    
    [cell.downBtn addTarget:self action:@selector(DownClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)DownClick:(UIView *)v{
    long tag = v.tag;
    
    
    
    [self showPrograssMessage:@"下载"];
    NSDictionary * param = @{@"DocumentId":_data[tag][@"DocumentId"],@"guid":_data[tag][@"DocumentId"],@"ResultsPerPage":@"20",@"Page":@"0"};
    
    //_data[tag][@"DocumentName"]
    NSString *token = [UserDefaultUtil getData:LOGIN_TOKEN];
    
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",[UserDefaultUtil getData:URL],@"Document/DownLoadSingleFile"];
    
    NSLog(@"requestUrl==%@",requestUrl);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    [manager POST:requestUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            [self closePrograssMessage];
            NSData *fileDate = operation.responseData;
            NSLog(@"size==%i",fileDate.length);
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString* filePath = [paths objectAtIndex:0];
            
            NSString *path = [filePath stringByAppendingPathComponent:_data[tag][@"DocumentName"]];
            NSFileManager *fm = [NSFileManager defaultManager];
            BOOL fileExists = [fm fileExistsAtPath:path];
            if (fileExists) {
                [fm removeItemAtPath:path error:nil];
            }
            BOOL flag0 = [fm createFileAtPath:path contents:nil attributes:nil];
            
           BOOL flag =  [fileDate writeToFile:path atomically:NO];
            if (flag) {
                PDFViewController *pdfVc = [PDFViewController new];
                pdfVc.filePath = path;
                [self.navigationController pushViewController:pdfVc animated:YES];
            }else{
                [self showMessage:@"下载失败"];
            }
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
            
        }
        @finally {

            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showMessage:@"下载失败"];
        [self closePrograssMessage];

    }];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
