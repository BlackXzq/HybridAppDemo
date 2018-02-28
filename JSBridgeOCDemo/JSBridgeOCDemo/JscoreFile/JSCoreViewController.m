//
//  JSCoreViewController.m
//  JSBridgeOCDemo
//
//  Created by Black on 2018/2/7.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "JSCoreViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "InfoViewController.h"

NSString *const JSCONTEXTPATH = @"documentView.webView.mainFrame.javaScriptContext";

@interface JSCoreViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *useWebView;
@end

@implementation JSCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    _useWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _useWebView.scrollView.bounces = false;
    _useWebView.delegate = self;
    [self.view addSubview:_useWebView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"html"];
    //    NSURL *url = [[NSURL alloc] initWithString:@"https://www.cnblogs.com/wangyingblog/p/5583825.html"];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_useWebView loadRequest:request];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加文本" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
}

- (void)rightBarClick {
    NSString *message = @"messagemessage";
    NSString *jsActionStr = [NSString stringWithFormat:@"addPElement('%@');", message];
    JSContext *context = [self.useWebView valueForKeyPath:JSCONTEXTPATH];
    [context evaluateScript:jsActionStr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-  UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    [self addCustomActions];
}

#pragma mark- add jscontext
#pragma mark - private method
- (void)addCustomActions
{
    JSContext *context = [self.useWebView valueForKeyPath:JSCONTEXTPATH];
    __weak typeof(self) weakSelf = self;
    context[@"pushInfo"] = ^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            InfoViewController *infoCtl = [[InfoViewController alloc] init];
            [weakSelf.navigationController pushViewController:infoCtl animated:YES];
        });
    };
}




@end
