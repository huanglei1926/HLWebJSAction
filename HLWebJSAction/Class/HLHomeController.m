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
#import "HLAddDataController.h"

@interface HLHomeController ()

@property (nonatomic, copy) NSArray *datas;

@end

@implementation HLHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self initDatas];
    [self.tableView reloadData];
}

- (void)setNav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCustomAction)];
}

- (void)initDatas{
    JSWebModel *defaultModel = [self getDefaultModel];
    _datas = @[defaultModel];
}

- (JSWebModel *)getDefaultModel{
    JSWebModel *defaultModel = [[JSWebModel alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HLWebJsAction" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];//创建URL
    defaultModel.urlName = @"默认测试页面";
    defaultModel.jsURl = url;
    [defaultModel.responseJsActionArray addObjectsFromArray:@[@"closePage",@"payResult"]];
    [defaultModel.callJsActionArray addObjectsFromArray:@[@"queryOrder()"]];
    return defaultModel;
}

- (void)addCustomAction{
    HLAddDataController *addDataVc = [[HLAddDataController alloc] init];
    [self.navigationController pushViewController:addDataVc animated:YES];
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
    cell.textLabel.text = model.urlName ? model.urlName : model.jsURl.absoluteString;
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
