//
//  JSCoreViewController.h
//  JSBridgeOCDemo
//
//  Created by Black on 2018/2/7.
//  Copyright © 2018年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSExportTest <JSExport>
//用宏转换下，将JS函数名字指定为callJSToNative
JSExportAs(callJSToNative,
           - (void)showJStoNative:(NSString *)config
           );
@end

@interface AJSDKModule : NSObject<JSExportTest>

@end

extern NSString *const JSCONTEXTPATH;

@interface JSCoreViewController : UIViewController

@end

