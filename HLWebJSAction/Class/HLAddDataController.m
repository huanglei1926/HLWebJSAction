//
//  HLAddDataController.m
//  HLWebJSAction
//
//  Created by cainiu on 2018/7/5.
//  Copyright © 2018年 Len. All rights reserved.
//

#import "HLAddDataController.h"

@interface HLAddDataController ()

@property (nonatomic, strong) JSWebModel *addModel;

@end

@implementation HLAddDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加";
    self.addModel = [[JSWebModel alloc] init];
    if (self.model) {
        self.addModel.urlName = self.model.urlName;
        self.addModel.jsURl = self.model.jsURl;
        [self.addModel.responseJsActionArray addObjectsFromArray:self.model.responseJsActionArray];
        [self.addModel.callJsActionArray addObjectsFromArray:self.model.callJsActionArray];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.addModel.responseJsActionArray.count;
    }else if(section == 3){
        return self.addModel.callJsActionArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


@end
