//
//  OriginalViewController.m
//  JSBridgeOCDemo
//
//  Created by Black on 2018/2/7.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "OriginalViewController.h"
#import "InfoViewController.h"

@interface OriginalViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *useWebView;
@end

@implementation OriginalViewController

- (void)viewDidLoad {
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
    NSString *jsActionStr = [NSString stringWithFormat:@"window.addPElement('%@');", message];
    NSString *make = [_useWebView stringByEvaluatingJavaScriptFromString:jsActionStr];
    NSLog(@"rightBarClick: %@", make);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark-  UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"urllink: %@", request.URL.absoluteString);
    if ([request.URL.absoluteString hasPrefix:@"jsbridgeocdemo://bridge.com/"]) {
        if ([request.URL.absoluteString containsString:@"info"]) {
            InfoViewController *infoCtl = [[InfoViewController alloc] init];
            [self.navigationController pushViewController:infoCtl animated:YES];
            return NO;
        }
    }
    return YES;
}
//webview加载完成。。。
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}
//webview开始加载。。。
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}
//webview加载失败。。。
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
}

@end
