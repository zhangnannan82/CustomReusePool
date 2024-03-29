//
//  ViewReusePool.h
//  CategaryProject
//
//  Created by ZN on 2019/7/1.
//  Copyright © 2019年 binhe.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewReusePool : NSObject

// 从重用池中取出一个可重用的view
- (UIView *)dequeueReusableView;

// 向重用池中添加一个视图
- (void)addUsingView:(UIView *)view;

// 重置方法，将当前使用中的视图移动到可重用队列当中
- (void)reset;

@end
