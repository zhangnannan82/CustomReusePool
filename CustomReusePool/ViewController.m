//
//  ViewController.m
//  CategaryProject
//
//  Created by ZN on 2019/6/16.
//  Copyright © 2019年 binhe.org. All rights reserved.
//

#import "ViewController.h"
#import "IndexedTableView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, IndexedTableViewDataSource>
{
    IndexedTableView *tableView;
    UIButton *button;
    NSMutableArray *dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self IndexedTableViewTest];
}

- (void)IndexedTableViewTest {
    tableView = [[IndexedTableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.indexedDataSource = self;
    [self.view addSubview:tableView];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 20, self.view.frame.size.width, 40);
    [button setTitle:@"reload Data" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    dataSource = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 1; i <= 100; i ++) {
        [dataSource addObject:@(i)];
    }
}

- (void)doAction {
    NSLog(@"reloadData");
    [tableView reloadData];
}

# pragma mark --- IndexedTableViewDataSource ---
- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView {
    // 奇数次调用返回6个字母，偶数次调用返回11个
    static BOOL change = NO;
    
    if (change) {
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
    } else {
        change = YES;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    }
}

#pragma mark --- UITableViewDataSource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"reuseId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [dataSource[indexPath.row] stringValue];
    cell.textLabel.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


@end
