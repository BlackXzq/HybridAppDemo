//
//  JSBridgeViewController.m
//  JSBridgeOCDemo
//
//  Created by Black on 2018/2/7.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "JSBridgeViewController.h"
#import <WebViewJavascriptBridge.h>
#import "InfoViewController.h"

@interface JSBridgeViewController ()
@property (nonatomic, strong) UIWebView *useWebView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation JSBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _useWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_useWebView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"html"];
    //    NSURL *url = [[NSURL alloc] initWithString:@"https://www.cnblogs.com/wangyingblog/p/5583825.html"];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_useWebView loadRequest:request];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_useWebView];
    [self jS2NativeAction];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加文本" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
}

- (void)rightBarClick {
    //    // 如果不需要参数，不需要回调，使用这个
    //    [_webViewBridge callHandler:@"testJSFunction"];
    //    // 如果需要参数，不需要回调，使用这个
    //    [_webViewBridge callHandler:@"testJSFunction" data:@"一个字符串"];
    // 如果既需要参数，又需要回调，使用这个
    [self.bridge callHandler:@"testJSFunction" data:@"一个字符串" responseCallback:^(id responseData) {
        NSLog(@"调用完JS后的回调：%@",responseData);
    }];
    
}

- (void)jS2NativeAction {
    __weak typeof(self) weakSelf = self;
    [self.bridge registerHandler:@"registerJS2NativeAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"XXXX: %@", data);
        responseCallback(@"KKKKKKKKKK))))");
        dispatch_async(dispatch_get_main_queue(), ^{
            InfoViewController *infoCtl = [[InfoViewController alloc] init];
            [weakSelf.navigationController pushViewController:infoCtl animated:YES];
        });
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

@end
