//
//  ViewController.m
//  JSBridgeOCDemo
//
//  Created by Black on 2018/2/1.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "ViewController.h"
#import "OriginalViewController.h"
#import "OrigiViewController.h"
#import "JSCoreViewController.h"
#import "JSBridgeViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSArray<NSString *> *> *actionList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
    [self configureData];
    [self configureWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTableView];
}

//配置View显示
- (void)configureView {
    self.title = @"首页";
    
    [self.view addSubview:self.tableView];
    
}
//初始化数据
- (void)configureData {
    self.actionList = [NSMutableArray array];
    [self.actionList addObject:@[@"使用传统上方法与JS交互WB", @"originalInteractiveAction"]];
    [self.actionList addObject:@[@"使用传统上方法与JS交互WK", @"originalInteractiveAction_WK"]];
    [self.actionList addObject:@[@"使用JavaScriptCore与JS交互", @"jscoreInteractiveAction"]];
    [self.actionList addObject:@[@"使用WebViewJavascriptBridge与JS交互", @"jsbridgeInteractiveAction"]];
}
//reload tableView
- (void)updateTableView {
    [self.tableView reloadData];
}

#pragma mark- handler Action
//使用传统上方法与JS交互
- (void)originalInteractiveAction {
    UIViewController *orginCtl = [[OriginalViewController alloc] init];
    [self.navigationController pushViewController:orginCtl animated:true];
}

- (void)originalInteractiveAction_WK {
    UIViewController *orginCtl = [[OrigiViewController alloc] init];
    [self.navigationController pushViewController:orginCtl animated:true];
}
//使用JavaScriptCore与JS交互
- (void)jscoreInteractiveAction {
    UIViewController *jscoreCtl = [[JSCoreViewController alloc] init];
    [self.navigationController pushViewController:jscoreCtl animated:true];
}
//使用WebViewJavascriptBridge与JS交互
- (void)jsbridgeInteractiveAction {
    UIViewController *jsbridgeCtl = [[JSBridgeViewController alloc] init];
    [self.navigationController pushViewController:jsbridgeCtl animated:true];
}

#pragma mark- UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *actions = self.actionList[indexPath.row];
    cell.textLabel.text = actions[0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SEL funSel = NSSelectorFromString(self.actionList[indexPath.row][1]);
    if (funSel) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:funSel];
#pragma clang diagnostic pop
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureWebView {
    UIWebView *useWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"html"];
    @try {
        NSURL *url = [[NSURL alloc] initWithString:filePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [useWebView loadRequest:request];
    } @catch (NSException *exception) {
        NSLog(@"exception: %@", exception.reason);
    } @finally {
        NSLog(@"KKfinally");
    }
}

#pragma mark- getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



@end
