//
//  ViewReusePool.m
//  CategaryProject
//
//  Created by ZN on 2019/7/1.
//  Copyright © 2019年 binhe.org. All rights reserved.
//

#import "ViewReusePool.h"

@interface ViewReusePool ()

// 等待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;
// 使用中的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation ViewReusePool

- (id)init {
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

// 从重用池中取出一个可重用的view
- (UIView *)dequeueReusableView {
    UIView *view = [_waitUsedQueue anyObject];
    if (view == nil) {
        return nil;
    }
    else {
        // 进行队列移动
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

// 向重用池中添加一个视图
- (void)addUsingView:(UIView *)view {
    if (view == nil) {
        return;
    }
    // 添加视图到使用中的队列
    [_usingQueue addObject:view];
}

// 重置方法，将当前使用中的视图移动到可重用队列当中
- (void)reset {
    while ([_usingQueue anyObject]) {
        UIView *view = [_usingQueue anyObject];
        // 丛使用中队列移除
        [_usingQueue removeObject:view];
        // 加入等待使用的队列
        [_waitUsedQueue addObject:view];
    }
}

@end
