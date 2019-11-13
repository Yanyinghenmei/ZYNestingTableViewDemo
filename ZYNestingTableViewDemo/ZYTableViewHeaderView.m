//
//  ZYTableViewHeaderView.m
//  ZYTableViewList
//
//  Created by Daniel on 2018/11/23.
//  Copyright © 2018 Daniel. All rights reserved.
//

#import "ZYTableViewHeaderView.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ZYTableViewHeaderView()
@property (nonatomic,strong) UIButton *selectedBtn;
@end

@implementation ZYTableViewHeaderView

#pragma mark - 设置section头部视图

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat btnW = self.frame.size.width/titles.count;
    CGFloat btnH = self.frame.size.height;
    
    for (int i = 0; i<titles.count; i++) {
        NSString *title = titles[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnW * i, 0, btnW, btnH)];
        
        btn.tag = i+100;
        
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        if (i == 0) {
            _selectedBtn = btn;
            _selectedBtn.selected = true;
        }
    }
}

#pragma mark - 点击事件
-(void)clickAction:(UIButton *)button {
    _selectedBtn.selected = false;
    _selectedBtn = button;
    _selectedBtn.selected = true;
    
    if (self.clickAction) {
        self.clickAction(button.tag-100);
    }
}

#pragma mark - Set方法
-(void)setProportion:(CGFloat)proportion {
    _proportion = proportion;
    NSLog(@"--------- %lf", proportion);
    
    NSInteger index = floor(_proportion);
    UIButton *btn = (UIButton *)[self viewWithTag:index+100];
    
    if (_selectedBtn != btn) {
        _selectedBtn.selected = false;
        _selectedBtn = btn;
        _selectedBtn.selected = true;
    }
    
//    CGFloat max = 0.4;
//    self.oneButton.transform = CGAffineTransformMakeScale(1 + (1 - proportion) * max, 1 + (1 - proportion) * max);
//    self.twoButton.transform = CGAffineTransformMakeScale(1 + proportion * max, 1 + proportion * max);
//
//    self.oneButton.alpha = (1 - proportion * max);
//    self.twoButton.alpha = 0.8 + proportion * max;
}

@end
