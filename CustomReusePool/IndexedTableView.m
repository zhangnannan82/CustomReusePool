//
//  IndexedTableView.m
//  CategaryProject
//
//  Created by ZN on 2019/7/1.
//  Copyright © 2019年 binhe.org. All rights reserved.
//

#import "IndexedTableView.h"
#import "ViewReusePool.h"

@interface IndexedTableView ()
{
    UIView *containerView;
    ViewReusePool *reusePool;
}
@end

@implementation IndexedTableView

- (void)reloadData {
    [super reloadData];
    
    if (containerView == nil) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor redColor];
        
        // 避免索引条跟着table滚动
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    
    if (reusePool == nil) {
        reusePool = [[ViewReusePool alloc] init];
    }
    
    // 标记所有视图为可重用状态
    [reusePool reset];
    
    // reload字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar {
    
    // 判断字母索引条的显示内容
    NSArray <NSString *> *arrayTitles = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
        arrayTitles = [self.indexedDataSource indexTitlesForIndexTableView:self];
    }
    
    // 判断字母索引条是否为空
    if (!arrayTitles || arrayTitles.count <= 0) {
        [containerView setHidden:YES];
        return;
    }
    
    NSInteger count = arrayTitles.count;
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    
    for (NSInteger i = 0; i < count; i ++) {
        NSString *title = [arrayTitles objectAtIndex:i];
        
        // 从重用池中取一个
        UIButton *button = (UIButton *)[reusePool dequeueReusableView];
        // 若没有，创建一个
        if (!button) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor blueColor];
            
            // 注册button到重用池中
            [reusePool addUsingView:button];
            NSLog(@"新创建一个button");
        } else {
            NSLog(@"button复用了");
        }
        
        // 添加button到复视图控件
        [containerView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, i * buttonHeight , buttonWidth, buttonHeight)];
    }
    
    [containerView setHidden:NO];
    containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, buttonWidth, self.frame.size.height);
}

@end
