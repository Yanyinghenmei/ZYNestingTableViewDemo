//
//  ZYTableView.m
//  ZYTableViewList
//
//  Created by Daniel on 2018/11/23.
//  Copyright © 2018 Daniel. All rights reserved.
//

#import "ZYTableView.h"
#import "ZYCollectionView.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


@interface ZYTableView() <UITableViewDelegate, UITableViewDataSource, ZYPageCardControllerDelegate>

/// 控制器
@property (nonatomic, weak) UIViewController<ZYCurrentViewControllerDelegate> *viewController;
/// 横向的滚动视图
@property (nonatomic, strong) ZYCollectionView *collectionView;
@property (nonatomic, strong) UIView <LFYTabViewDelegate> *tabView;
@property (nonatomic, copy) NSArray <UIViewController<LFYSubControllerDelegate> *> *controllers;

@end

static NSString *tableViewCell = @"UITableViewCell";
static NSString *tableViewHeaderView = @"ZYTableViewHeaderView";

@implementation ZYTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
       currentViewController:(UIViewController<ZYCurrentViewControllerDelegate> *)viewController
               contentHeight:(CGFloat)contentHeight 
                  headerView:(UIView *)headerView
                     tabView:(UIView<LFYTabViewDelegate>  *)tabView
             viewControllers:(NSArray<UIViewController<LFYSubControllerDelegate> *> *)controllers {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        
        self.viewController = viewController;
        self.rowHeight = contentHeight;
        self.tableHeaderView = headerView;
        self.tabView = tabView;
        
        [self updateControllers:controllers];
    }
    
    return self;
}

- (void)updateControllers:(NSArray<UIViewController<LFYSubControllerDelegate> *> *)controllers {
    
    for (UIViewController *childVC in self.viewController.childViewControllers) {
        [childVC willMoveToParentViewController:nil];
        [childVC.view removeFromSuperview];
        [childVC removeFromParentViewController];
    }
    
    self.controllers = controllers;
    
    __weak typeof(self) weakSelf = self;
    for (UIViewController<LFYSubControllerDelegate> *controller in self.controllers) {
        controller.noScrollAction = ^{
            weakSelf.viewController.isCanScroll = true;
            for (UIViewController<LFYSubControllerDelegate> *otherController in self.controllers) {
                if (controller != otherController) {
                    otherController.isCanScroll = false;
                    otherController.tableView.contentOffset = CGPointZero;
                }
            }
        };
    }
    
    [self.collectionView reloadData];
}

#pragma mark - 允许接受多个手势 (这个方法很重要，不要遗漏)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - UITableViewDelegate / UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
        
        /// 在tableViewCell中添加控制器
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.collectionView];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __weak typeof(self) weakSelf = self;
    self.tabView.clickAction = ^(NSInteger index) {
        [weakSelf.collectionView setContentOffset:CGPointMake(weakSelf.frame.size.width*index, 0) animated:YES];
    };

    return _tabView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollY = [self rectForSection:0].origin.y;
    if (self.contentOffset.y >= scrollY) {
        if (self.viewController.isCanScroll == YES) {
            self.viewController.isCanScroll = NO;
            for (UIViewController<LFYSubControllerDelegate> *controller in self.controllers) {
                controller.isCanScroll = true;
                controller.tableView.contentOffset = CGPointZero;
            }
        }
        
        self.contentOffset = CGPointMake(0, scrollY);
    }else{
        if (self.viewController.isCanScroll == NO) {
            self.contentOffset = CGPointMake(0, scrollY);
        }
    }
}

#pragma mark - Get方法
-(ZYCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 64.f - 50.f);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        /// 64.f 是导航控制器的高度    50.f是列表的section头的高度
        _collectionView = [[ZYCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50.f) collectionViewLayout:flowLayout];
        _collectionView.viewController = self.viewController;
        _collectionView.pageDelegate = self;
        
        __weak typeof(self) weakSelf = self;
        _collectionView.scrollAction = ^(CGFloat proportion) {
            weakSelf.tabView.proportion = proportion;
        };
    }
    
    return _collectionView;
}

#pragma mark -- ZYPageCardControllerDelegate
- (NSInteger)totalCount {
    return self.controllers.count;
}
- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    return self.controllers[index];
}

@end
