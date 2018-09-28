//
//  MainTableViewController.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "MainTabBarController.h"
#import "Main1ViewController.h"
#import "Main2ViewController.h"
#import "Main3ViewController.h"
#import "Main4ViewController.h"
#import "Main5ViewController.h"
#import "UIColor+Hex.h"
#import "TTUtils.h"
#import "Colors.h"
@interface MainTabBarController ()
@property NSMutableArray *btns;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    [self initView1];
    
    
    
    
}

-(void)initView0{
    UINavigationController *na1 = [[UINavigationController alloc] initWithRootViewController:[[Main1ViewController alloc] init]];
    UINavigationController *na2 = [[UINavigationController alloc] initWithRootViewController:[[Main2ViewController alloc] init]];
    UINavigationController *na3 = [[UINavigationController alloc] initWithRootViewController:[[Main3ViewController alloc] init]];
    UINavigationController *na4 = [[UINavigationController alloc] initWithRootViewController:[[Main4ViewController alloc] init]];
    UINavigationController *na5 = [[UINavigationController alloc] initWithRootViewController:[[Main5ViewController alloc] init]];
    
    na1.tabBarItem.tag = 0;
    na2.tabBarItem.tag = 1;
    na3.tabBarItem.tag = 2;
    na4.tabBarItem.tag = 3;
    na5.tabBarItem.tag = 4;
    
    
    NSArray *itemNas = @[na1,na2,na3,na4,na5];
    
    UIImage *bg = [TTUtils createImageWithColor:[UIColor colorWithHexString:app_style_color]];
    
    for(UINavigationController *nav in itemNas){
        [nav.navigationBar setBackgroundImage:bg forBarMetrics:UIBarMetricsDefault];
        //文字颜色
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        //按钮颜色
        nav.navigationBar.tintColor  = [UIColor whiteColor];
    }
    self.viewControllers = itemNas;
    
    NSArray *titles = @[@"首页",@"定位",@"冷机",@"传感器",@"报警"];
    NSArray *selImg = [[NSArray alloc]initWithObjects:@"main01",@"main02",@"main03",@"main04",@"main05", nil];
    NSArray *defImg = [[NSArray alloc]initWithObjects:@"main1",@"main2",@"main3",@"main4",@"main5", nil];
    
    for (int i = 0; i < titles.count; i++) {
        
        UINavigationController *na = [itemNas objectAtIndex:i];
        //设置图片
        na.tabBarItem.image = [UIImage imageNamed:defImg[i]];
        na.tabBarItem.selectedImage = [UIImage imageNamed:selImg[i]];
        na.tabBarItem.title = titles[i];
        // S未选中字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]} forState:UIControlStateNormal];
        
        // 选中字体颜色
        [na.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:app_style_color]} forState:UIControlStateSelected];
    }
    
    
    
    
}

-(void)initView1{
    
    UINavigationController *na1 = [[UINavigationController alloc] initWithRootViewController:[[Main1ViewController alloc] init]];
    UINavigationController *na2 = [[UINavigationController alloc] initWithRootViewController:[[Main2ViewController alloc] init]];
    UINavigationController *na3 = [[UINavigationController alloc] initWithRootViewController:[[Main3ViewController alloc] init]];
    UINavigationController *na4 = [[UINavigationController alloc] initWithRootViewController:[[Main4ViewController alloc] init]];
    UINavigationController *na5 = [[UINavigationController alloc] initWithRootViewController:[[Main5ViewController alloc] init]];
    
    na1.tabBarItem.tag = 0;
    na2.tabBarItem.tag = 1;
    na3.tabBarItem.tag = 2;
    na4.tabBarItem.tag = 3;
    na5.tabBarItem.tag = 4;
    
    
    NSArray *itemNas = @[na1,na2,na3,na4,na5];
    
    UIImage *bg = [TTUtils createImageWithColor:[UIColor colorWithHexString:app_style_color]];
    
    for(UINavigationController *nav in itemNas){
        [nav.navigationBar setBackgroundImage:bg forBarMetrics:UIBarMetricsDefault];
        //文字颜色
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        //按钮颜色
        nav.navigationBar.tintColor  = [UIColor whiteColor];
    }
    self.viewControllers = itemNas;
    
    
    
    CGRect rect = self.tabBar.frame;
    
    
    //  self.tabBar.hidden = YES;
    
    UIView *myview = [[UIView alloc]init];
    //myview.frame = rect;
    
    myview.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    myview.backgroundColor = [UIColor whiteColor];
    
    NSArray *defImg = [[NSArray alloc]initWithObjects:@"main1",@"main2",@"main3",@"main4",@"main5", nil];
    
    NSArray *selImg = [[NSArray alloc]initWithObjects:@"main01",@"main02",@"main03",@"main04",@"main05", nil];
    
    
    NSLog(@"height==%f",myview.frame.size.height);
    self.btns = [[NSMutableArray alloc]init];
    for (int i = 0; i < selImg.count; i++) {
        
        UIImage *img = [UIImage imageNamed:[defImg objectAtIndex:i]];
        UIImage *selectimg = [UIImage imageNamed:[selImg objectAtIndex:i]];
        
        CGFloat x = i * myview.frame.size.width / selImg.count;
        
        CGRect iRect = CGRectMake(x, 0, myview.frame.size.width / selImg.count, myview.frame.size.height);
        
        UIButton *button = [[UIButton alloc]initWithFrame:iRect];
        
        button.frame = iRect;
        
        
        
        //[button setBackgroundColor:[UIColor blueColor]];
        [button setImage:img forState:UIControlStateNormal];
        [button setImage:selectimg forState:UIControlStateSelected];
        //button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.layer.masksToBounds = YES;
        
        if (i == 0) {
            //[button setBackgroundImage:selectimg forState:UIControlStateNormal];
            button.selected = YES;
            self.selectButton = button;
        }
        
        [button setTag:i];
        
        [self.btns addObject:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [myview addSubview:button];
        
    };
    
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, myview.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:80];
    line.layer.masksToBounds = YES;
    
    [myview addSubview:line];
    [self.tabBar addSubview:myview];
    // self.tabBar.tintColor = [UIColor colorWithRed:255.0/255.0 green:124.0/255.0 blue:56.0/255.0 alpha:1];

}
-(void)initView2{
    
}

- (void)btnClick : (UIButton *)button{
    
    
    self.selectButton.selected  = NO;
    
    button.selected = YES;
    self.selectButton = button;
    
    
    self.selectedIndex = button.tag;
    
}

- (void)showIndex:(int) index{
    
    UIButton *btn = self.btns[index];
    self.selectButton.selected  = NO;
    
    btn.selected = YES;
    self.selectButton = btn;
    
    
    self.selectedIndex = index;
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"didSelectItem");
    if (self.selectButton.tag != item.tag) {
        UIButton * button = self.btns[item.tag];
        
        self.selectButton.selected  = NO;
        
        button.selected = YES;
        self.selectButton = button;
        
        
        self.selectedIndex = button.tag;
    }
    
}




@end
