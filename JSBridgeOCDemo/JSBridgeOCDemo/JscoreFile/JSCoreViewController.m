//
//  JSCoreViewController.m
//  JSBridgeOCDemo
//
//  Created by Black on 2018/2/7.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "JSCoreViewController.h"

@interface JSCoreViewController ()
@property (nonatomic, strong) UIWebView *useWebView;
@end

@implementation JSCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _useWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_useWebView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    //    NSURL *url = [[NSURL alloc] initWithString:@"https://www.cnblogs.com/wangyingblog/p/5583825.html"];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_useWebView loadRequest:request];
    
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
