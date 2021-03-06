//
//  ViewController.m
//  CustomTableViewRowActions
//
//  Created by Mac2 on 2018/11/14.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "ViewController.h"
#import "DataTableViewCell.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allDatas;
@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index

@property (nonatomic, strong) UIImageView *deleteImageView;
@property (nonatomic, strong) UILabel *deleteLabel;
@property (nonatomic, strong) UIImageView *collectImageView;
@property (nonatomic, strong) UILabel *collectLabel;

@end

@implementation ViewController

- (NSMutableArray *)allDatas {
    if (!_allDatas) {
        _allDatas = [NSMutableArray array];
    }
    return _allDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"自定义左滑按钮";
    
    self.deleteImageView = [[UIImageView alloc] init];
    self.deleteImageView.image = [UIImage imageNamed:@"delete"];
    self.deleteImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.deleteLabel = [[UILabel alloc] init];
    self.deleteLabel.text = @"删除";
    self.deleteLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    self.deleteLabel.textColor = [UIColor whiteColor];
    self.deleteLabel.textAlignment = NSTextAlignmentCenter;
    
    self.collectImageView = [[UIImageView alloc] init];
    self.collectImageView.image = [UIImage imageNamed:@"collect"];
    self.collectImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.collectLabel = [[UILabel alloc] init];
    self.collectLabel.text = @"收藏";
    self.collectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    self.collectLabel.textColor = [UIColor whiteColor];
    self.collectLabel.textAlignment = NSTextAlignmentCenter;
    
    for (int i=0; i<30; i++) {
        DataModel *model = [[DataModel alloc] init];
        model.number = [NSString stringWithFormat:@"%d", i];
        [self.allDatas addObject:model];
    }
    
    [self setUpTableView];
}

//X-CODE8下编译
- (void)configSwipeButton {
    // 获取选项按钮的reference
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
        // iOS 11层级 (Xcode 8编译): UITableView -> UITableViewWrapperView -> UISwipeActionPullView
        for (UIView *subview in self.tableView.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
                for (UIView *subsubview in subview.subviews) {
                    if ([subsubview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subsubview.subviews count] >= 2) {
                        // 和iOS 10的按钮顺序相反
                        UIButton *deleteButton = subsubview.subviews[1];
                        UIButton *collectButton = subsubview.subviews[0];
                        [self configDeleteButton:deleteButton];
                        [self configCollectButton:collectButton];
                    }
                }
            }
        }
    }else {
        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        DataTableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 2) {
                UIButton *deleteButton = subview.subviews[0];
                UIButton *collectButton = subview.subviews[1];
                [self configDeleteButton:deleteButton];
                [self configCollectButton:collectButton];
                [subview setBackgroundColor:[UIColor clearColor]];
            }
        }
    }
}

//X-CODE9下编译
- (void)configSwipeButtons {
    // 获取选项按钮的reference
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.tableView.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] >= 2) {
                // 和iOS 10的按钮顺序相反
                UIButton *deleteButton = subview.subviews[1];
                UIButton *collectButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
                [self configCollectButton:collectButton];
            }
        }
    }else {
        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        DataTableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 2) {
                UIButton *deleteButton = subview.subviews[0];
                UIButton *collectButton = subview.subviews[1];
                [self configDeleteButton:deleteButton];
                [self configCollectButton:collectButton];
                [subview setBackgroundColor:[UIColor clearColor]];
            }
        }
    }
}

- (void)configDeleteButton:(UIButton*)deleteButton {
    if (deleteButton) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
            for (UIView *deleteView in deleteButton.subviews) {
                self.deleteImageView.frame = CGRectMake(deleteView.frame.size.width/2-15, 10, 30, 40);
                [deleteView addSubview:self.deleteImageView];
                
                self.deleteLabel.frame = CGRectMake(0, deleteView.frame.size.height / 2.0 + 10, deleteView.frame.size.width, 20);
                [deleteView addSubview:self.deleteLabel];
            }
        }else {
            self.deleteImageView.frame = CGRectMake(deleteButton.frame.size.width/2-15, 10, 30, 40);
            [deleteButton addSubview:self.deleteImageView];
            
            self.deleteLabel.frame = CGRectMake(0, deleteButton.frame.size.height / 2.0 + 10, deleteButton.frame.size.width, 20);
            [deleteButton addSubview:self.deleteLabel];
        }
        [deleteButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
    }
}

- (void)configCollectButton:(UIButton*)collectButton {
    if (collectButton) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
            for (UIView *collectView in collectButton.subviews) {
                self.collectImageView.frame = CGRectMake(collectView.frame.size.width/2-15, 10, 30, 40);
                [collectView addSubview:self.collectImageView];
                
                self.collectLabel.frame = CGRectMake(0, collectView.frame.size.height / 2.0 + 10, collectView.frame.size.width, 20);
                [collectView addSubview:self.collectLabel];
            }
        }else {
            self.collectImageView.frame = CGRectMake(collectButton.frame.size.width/2-15, 10, 30, 40);
            [collectButton addSubview:self.collectImageView];
            
            self.collectLabel.frame = CGRectMake(0, collectButton.frame.size.height / 2.0 + 10, collectButton.frame.size.width, 20);
            [collectButton addSubview:self.collectLabel];
        }
        [collectButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [collectButton setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
    }
}

- (void)setUpTableView {
    CGFloat naviHeight = (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - naviHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[DataTableViewCell class] forCellReuseIdentifier:@"dataCell"];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    DataModel *model = self.allDatas[indexPath.row];
    cell.model = model;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout]; // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.editingIndexPath = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.editingIndexPath) {
        [self configSwipeButtons];
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除");
        [self.tableView setEditing:NO animated:YES];
    }];
    
    UITableViewRowAction *collect = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"收藏");
        [self.tableView setEditing:NO animated:YES];
    }];
    collect.backgroundColor = [UIColor orangeColor];
    return @[delete, collect];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
