//
//  HLHomeController.m
//  HLWebJSAction
//
//  Created by cainiu on 2018/7/4.
//  Copyright © 2018年 Len. All rights reserved.
//

#import "HLHomeController.h"
#import "JSWebModel.h"
#import "HLWebController.h"

@interface HLHomeController ()

@property (nonatomic, copy) NSArray *datas;

@end

@implementation HLHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self.tableView reloadData];
}

- (void)initDatas{
    JSWebModel *defaultModel = [[JSWebModel alloc] init];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *bundel=[[NSBundle mainBundle] resourcePath];
    NSString *path=[[bundel substringToIndex:[bundel rangeOfString:@"Library"].location] stringByAppendingFormat:@"Desktop/Web/index.html"];
    NSURL* url = [NSURL fileURLWithPath:path];//创建URL
    defaultModel.jsURl = url;
    defaultModel.jsResponseActionArray = @[@"ButtonTestAction1",@"ButtonTestAction2"];
    defaultModel.jsActionArray = @[@"webJsAction1('APP调用方法一')",@"webJsAction2('APP调用方法二')"];
    defaultModel.jsValueArray = @[@"sendInfoToApp1"];
    _datas = @[defaultModel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JSWebModel *model = self.datas[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jsCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jsCell"];
    }
    cell.textLabel.text = model.jsURl.absoluteString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HLWebController *webVc = [[HLWebController alloc] init];
    webVc.model = self.datas[indexPath.row];
    [self.navigationController pushViewController:webVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
