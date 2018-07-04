//
//  JSWebModel.h
//  HLWebJSAction
//
//  Created by cainiu on 2018/7/4.
//  Copyright © 2018年 Len. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSWebModel : NSObject

@property (nonatomic, copy) NSURL *jsURl;

@property (nonatomic, copy) NSArray *jsResponseActionArray;

@property (nonatomic, copy) NSArray *jsActionArray;

@property (nonatomic, copy) NSArray *jsValueArray;


@end
