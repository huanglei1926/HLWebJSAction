//
//  JSWebModel.m
//  HLWebJSAction
//
//  Created by cainiu on 2018/7/4.
//  Copyright © 2018年 Len. All rights reserved.
//

#import "JSWebModel.h"

@implementation JSWebModel

- (NSMutableArray *)responseJsActionArray{
    if (!_responseJsActionArray) {
        _responseJsActionArray = [NSMutableArray array];
    }
    return _responseJsActionArray;
}

- (NSMutableArray *)callJsActionArray{
    if (!_callJsActionArray) {
        _callJsActionArray = [NSMutableArray array];
    }
    return _callJsActionArray;
}

@end
