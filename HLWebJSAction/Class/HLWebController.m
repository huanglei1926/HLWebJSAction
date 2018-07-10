//
//  HLWebController.m
//  HLWebJSAction
//
//  Created by cainiu on 2018/7/4.
//  Copyright © 2018年 Len. All rights reserved.
//

#import "HLWebController.h"
#import "JSWebModel.h"
#import "HLDataDetailController.h"
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
    [self setNav];
    [self.view addSubview:self.webView];
    if (self.model.jsURl) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.model.jsURl];
        [self.webView loadRequest:request];
    }
}

- (void)setNav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Detail" style:UIBarButtonItemStylePlain target:self action:@selector(detailAction)];
    
}

- (void)detailAction{
    HLDataDetailController *detailVc = [[HLDataDetailController alloc] init];
    detailVc.model = self.model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    kWeakSelf
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //JS错误捕获
    [context setExceptionHandler:^(JSContext *context, JSValue *exception) {
        NSLog(@"exception--%@", exception);
    }];
    if (self.model.responseJsActionArray && self.model.responseJsActionArray.count > 0) {
        for (NSString *jsResponseStr in self.model.responseJsActionArray) {
            if (jsResponseStr && jsResponseStr.length > 0) {
                context[jsResponseStr] = ^{
                    NSArray *result = [JSContext currentArguments];
                    [weakSelf showJsResponseActionWithName:jsResponseStr result:result];
                };
            }
        }
    }

    if (self.model.callJsActionArray && self.model.callJsActionArray.count > 0) {
        for (NSString *jsActionStr in self.model.callJsActionArray) {
            if (jsActionStr && jsActionStr.length > 0) {
                id object = [[context evaluateScript:jsActionStr] toObject];
                if (object) {
                    NSLog(@"object---%@",object);
                }
                [self showCallJsWithName:jsActionStr result:object];
            }
        }
    }
}



- (void)showJsResponseActionWithName:(NSString *)actionName result:(NSArray *)result{
    if (actionName && actionName.length > 0) {
        SEL action = NSSelectorFromString(actionName);
        if ([self canPerformAction:action withSender:nil]) {
            [self performSelector:action withObject:nil];
            return;
        }
    }
    NSMutableString *mutableStr = [NSMutableString string];
    for (JSValue *value in result) {
        NSString *string = [NSString stringWithFormat:@"%@\n",value];
        [mutableStr appendString:string];
    }
    [self showAlertWithTitle:@"responseJsAction" Message:[NSString stringWithFormat:@"actionName-%@\nresult:%@",actionName,mutableStr]];
}

- (void)showCallJsWithName:(NSString *)actionName result:(id)result{
    [self showAlertWithTitle:@"CallJsAction" Message:[NSString stringWithFormat:@"actionName:%@\nresult:%@",actionName,result]];
}

- (void)closePage{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}


- (void)showAlertWithTitle:(NSString *)title Message:(NSString *)message{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
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
