//
//  HLWebController.m
//  HLWebJSAction
//
//  Created by cainiu on 2018/7/4.
//  Copyright © 2018年 Len. All rights reserved.
//

#import "HLWebController.h"
#import "JSWebModel.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface HLWebController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

#define kWeakSelf __weak typeof(self) weakSelf = self;
@implementation HLWebController

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    if (self.model.jsURl) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.model.jsURl];
        [self.webView loadRequest:request];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    kWeakSelf
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //JS错误捕获
    [context setExceptionHandler:^(JSContext *context, JSValue *exception) {
        NSLog(@"exception--%@", exception);
    }];
    if (self.model.jsResponseActionArray && self.model.jsResponseActionArray.count > 0) {
        for (NSString *jsResponseStr in self.model.jsResponseActionArray) {
            if (jsResponseStr && jsResponseStr.length > 0) {
                context[jsResponseStr] = ^{
                    [weakSelf showJsResponseActionWithName:jsResponseStr];
                };
            }
        }
    }
    if (self.model.jsValueArray && self.model.jsValueArray.count > 0) {
        for (NSString *jsValueStr in self.model.jsValueArray) {
            if (jsValueStr && jsValueStr.length > 0) {
                context[jsValueStr] = ^{
                    NSArray *result = [JSContext currentArguments];
                    [weakSelf showJsResultWithArray:result];
                };
            }
        }
    }
    if (self.model.jsActionArray && self.model.jsActionArray.count > 0) {
        for (NSString *jsActionStr in self.model.jsActionArray) {
            if (jsActionStr && jsActionStr.length > 0) {
                [context evaluateScript:jsActionStr];
            }
        }
    }
}



- (void)showJsResponseActionWithName:(NSString *)actionName{
    [self showAlertWithMessage:[NSString stringWithFormat:@"JsResponseAction-%@",actionName]];
}

- (void)showJsResultWithArray:(NSArray *)array{
    [self showAlertWithMessage:[NSString stringWithFormat:@"JsResult-%@",array]];
}


- (void)showAlertWithMessage:(NSString *)message{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
