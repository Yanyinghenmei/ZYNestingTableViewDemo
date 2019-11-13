//
//  ViewController.m
//  ZYNestingTableViewDemo
//
//  Created by Daniel Chuang on 2019/11/13.
//  Copyright © 2019 Daniel Chuang. All rights reserved.
//

#import "ViewController.h"
#import "ZYTableViewHeaderView.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()
@property (nonatomic,strong) ZYTableViewHeaderView *headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Nesting";
    
    self.isCanScroll = YES;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(updateAciton)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self.view addSubview:self.tableView];
}

- (void)updateAciton {
    [self.tableView updateControllers:@[self.ZYVCOne, self.ZYVCTwo]];
    _headerView.titles = @[@"A",@"B"];
}

#pragma mark - Get方法
-(ZYTableView *)tableView {
    if (!_tableView) {
        
        _headerView = [[ZYTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _headerView.titles = @[@"A",@"B",@"C"];
        UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        tableHeader.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.3];
        
        _tableView = [[ZYTableView alloc] initWithFrame:CGRectMake(0, 64.f, kScreenWidth, kScreenHeight - 64.f) style:UITableViewStylePlain currentViewController:self contentHeight:kScreenHeight-64-50 headerView:tableHeader tabView:_headerView viewControllers:@[self.ZYVCOne, self.ZYVCTwo, self.ZYVCThire]];
    }
    
    return _tableView;
}

- (SubViewController *)ZYVCOne {
    if (!_ZYVCOne) {
        _ZYVCOne = [[SubViewController alloc] init];
    }
    
    return _ZYVCOne;
}

- (SubViewController *)ZYVCTwo {
    if (!_ZYVCTwo) {
        _ZYVCTwo = [[SubViewController alloc] init];
    }
    
    return _ZYVCTwo;
}

- (SubViewController *)ZYVCThire {
    if (!_ZYVCThire) {
        _ZYVCThire = [[SubViewController alloc] init];
    }
    
    return _ZYVCThire;
}

@end
