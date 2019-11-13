//
//  ZYCollectionView.m
//  ZYTableViewList
//
//  Created by Daniel on 2018/11/23.
//  Copyright © 2018 Daniel. All rights reserved.
//

#import "ZYCollectionView.h"
//#import "ZYViewController.h"
#import "ViewController.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


@interface ZYPageCell : UICollectionViewCell

@property (weak, nonatomic) UIViewController * pageViewController;

@property (weak, nonatomic) UIView * pageView;

@end

@implementation ZYPageCell

@end


@interface ZYCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate>
@end

static NSString *collectionViewCell = @"ZYPageCell";
@implementation ZYCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = UIColor.whiteColor;
        self.dataSource = self;
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
        [self registerClass:[ZYPageCell class] forCellWithReuseIdentifier:collectionViewCell];
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource / UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    /// 假设说只有两个控制器左右滑动
    if (self.pageDelegate != nil) {
        return [self.pageDelegate totalCount];
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    if (self.pageDelegate != nil) {
        UIViewController *vc = [self.pageDelegate viewControllerAtIndex:indexPath.row];
        cell.pageViewController = vc;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYPageCell * pageCell = (ZYPageCell *)cell;
    pageCell.pageView = pageCell.pageViewController.view;
    pageCell.pageView.frame = cell.bounds;
    [pageCell.contentView addSubview:pageCell.pageView];
    [self.viewController addChildViewController:pageCell.pageViewController];
    [pageCell.pageViewController didMoveToParentViewController:self.viewController];
    
    // addChildViewController: will call [child willMoveToParentViewController:self] before adding the child. However, it will not call didMoveToParentViewController
    
    // childViewController viewDidApear 会被调用两次, 参考这里
    // https://blog.csdn.net/zhaoxy_thu/article/details/50826190
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYPageCell * pageCell = (ZYPageCell *)cell;
    [pageCell.pageViewController willMoveToParentViewController:nil];
    [pageCell.pageView removeFromSuperview];
    [pageCell.pageViewController removeFromParentViewController];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollAction) {
        self.scrollAction(scrollView.contentOffset.x / self.frame.size.width);
    }
}

@end
