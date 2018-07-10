//
//  JSWebModel.h
//  HLWebJSAction
//
//  Created by cainiu on 2018/7/4.
//  Copyright © 2018年 Len. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSWebModel : NSObject

/**
 地址名称
 */
@property (nonatomic, copy) NSString *urlName;

/**
 访问地址
 */
@property (nonatomic, copy) NSURL *jsURl;

/**
 响应JS方法
 */
@property (nonatomic, strong) NSMutableArray *responseJsActionArray;

/**
 调用JS方法
 */
@property (nonatomic, strong) NSMutableArray *callJsActionArray;


@end
