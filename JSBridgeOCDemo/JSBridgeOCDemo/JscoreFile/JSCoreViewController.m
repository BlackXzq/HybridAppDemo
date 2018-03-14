//
//  JSCoreViewController.m
//  JSBridgeOCDemo
//
//  Created by Black on 2018/2/7.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "JSCoreViewController.h"
#import "InfoViewController.h"

NSString *const JSCONTEXTPATH = @"documentView.webView.mainFrame.javaScriptContext";

@interface JSCoreViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *useWebView;
@property (nonatomic, strong) AJSDKModule *module;
@end

@implementation JSCoreViewController

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
    
    self.module = [AJSDKModule new];
    JSContext *context = [self.useWebView valueForKeyPath:JSCONTEXTPATH];
    context[@"AJSDKModule"] = self.module;
    
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
    //拿到当前WebView的JS上下文
    JSContext *context = [self.useWebView valueForKeyPath:JSCONTEXTPATH];
    //给这个上下文注入callNativeFunction函数当做JS对象
    context[@"callNativeFunction"] = ^(JSValue *paramData) {
        NSLog(@"paramData: %@", paramData.toObject);
        //1 解读JS传过来的JSValue  data数据
        //2 取出指令参数，确认要发起的native调用的指令是什么
        //3 取出数据参数，拿到JS传过来的数据
        //4 根据指令调用对应的native方法，传递数据
        //5 此时还可以将客户端的数据同步返回！
    };
}


@end


@implementation AJSDKModule

- (void)showJStoNative:(NSString *)config {
    NSLog(@"config: %@", config);
}
@end
