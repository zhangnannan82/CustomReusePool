//
//  IndexedTableView.h
//  CategaryProject
//
//  Created by ZN on 2019/7/1.
//  Copyright © 2019年 binhe.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexedTableViewDataSource <NSObject>

// 获取一个tableView的字母索引条数据的方法
- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;

@end

@interface IndexedTableView : UITableView

@property (nonatomic, weak) id<IndexedTableViewDataSource> indexedDataSource;

@end
