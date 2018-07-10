//
//  HLDataDetailController.m
//  HLWebJSAction
//
//  Created by cainiu on 2018/7/5.
//  Copyright © 2018年 Len. All rights reserved.
//

#import "HLDataDetailController.h"
#import "JSWebModel.h"

@interface HLDataDetailController ()

@end

@implementation HLDataDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.urlName ? self.model.urlName : self.model.jsURl.absoluteString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}



@end
