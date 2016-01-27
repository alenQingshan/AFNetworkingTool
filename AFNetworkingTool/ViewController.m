//
//  ViewController.m
//  AFNetworkingTool
//
//  Created by Alen on 15/10/9.
//  Copyright (c) 2015年 Alen. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkingTool.h"

@interface ViewController ()

@property(nonatomic,weak)UIButton *button;
@property(nonatomic,weak)UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
// 全局检测网络状态(可通过关闭/链接mac的网络检测  可以放在AppDelegate中,全局检测app网络状态)
    [AFNetworkingTool netWorkStatus];
    
    self.button=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame=CGRectMake(50, 60, self.view.frame.size.width-100, 40);
    self.button.backgroundColor=[UIColor colorWithRed:64/255.0 green:207/255.0 blue:255/255.0 alpha:1];
    [self.button setTitle:@"进行网络请求" forState:UIControlStateNormal];
    [self.button setTitle:@"加载中..." forState:UIControlStateSelected];
    [self.button addTarget:self action:@selector(netRequestAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
}
-(void)netRequestAction{
    self.button.selected=YES;
    NSString *url = @"https://alpha-api.app.net/stream/0/posts/stream/global";
    [AFNetworkingTool JSONDataWithUrl:url success:^(id json) {
        self.button.selected=NO;
        NSLog(@"%@", json);
// 提示:NSURLConnection异步方法回调,是在子线程
// 得到回调之后,通常更新UI,是在主线程
//        NSLog(@"%@", [NSThread currentThread]);
    } fail:^{
        self.button.selected=NO;
        NSLog(@"请求失败");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
