//
//  DataTableViewCell.m
//  AAAA
//
//  Created by Mac2 on 2018/11/8.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "DataTableViewCell.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface DataTableViewCell ()

@property (nonatomic, strong) UIImageView *deleteImageView;
@property (nonatomic, strong) UILabel *deleteLabel;
@property (nonatomic, strong) UIImageView *collectImageView;
@property (nonatomic, strong) UILabel *collectLabel;

@end

@implementation DataTableViewCell

- (void)setModel:(DataModel *)model {
    self.textLabel.text = [NSString stringWithFormat:@"line: %@", model.number];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpCell];
    }
    return self;
}

- (void)setUpCell {
    //去除选中时cell的蓝色背景
    UIView *backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = backGroundView;
    
    self.deleteImageView = [[UIImageView alloc] init];
    self.deleteImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.deleteLabel = [[UILabel alloc] init];
    self.deleteLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    self.deleteLabel.textColor = [UIColor whiteColor];
    self.deleteLabel.textAlignment = NSTextAlignmentCenter;
    
    self.collectImageView = [[UIImageView alloc] init];
    self.collectImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.collectLabel = [[UILabel alloc] init];
    self.collectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    self.collectLabel.textColor = [UIColor whiteColor];
    self.collectLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//
//#pragma mark---自定义左滑按钮相关的方法
////X-CODE8编译
////- (void)configSwipeButtons {
////    // 获取选项按钮的reference
////    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
////        // iOS 11层级 (Xcode 8编译): UITableView -> UITableViewWrapperView -> UISwipeActionPullView
////        for (UIView *subview in self.tableView.subviews) {
////            if ([subview isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
////                for (UIView *subsubview in subview.subviews) {
////                    if ([subsubview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subsubview.subviews count] >= 2) {
////                        // 和iOS 10的按钮顺序相反
////                        UIButton *deleteButton = subsubview.subviews[1];
////                        UIButton *collectButton = subsubview.subviews[0];
////                        [self configDeleteButton:deleteButton];
////                        [self configCollectButton:collectButton];
////                    }
////                }
////            }
////        }
////    }else {
////        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
////        for (UIView *subview in self.subviews) {
////            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 2) {
////                UIButton *deleteButton = subview.subviews[0];
////                UIButton *collectButton = subview.subviews[1];
////                [self configDeleteButton:deleteButton];
////                [self configCollectButton:collectButton];
////                [subview setBackgroundColor:[UIColor clearColor]];
////            }
////        }
////    }
////}
//
////X-CODE9编译
//- (void)configSwipeButtons {
//    // 获取选项按钮的reference
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
//        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
//        for (UIView *subview in self.tableView.subviews) {
//            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subview.subviews count] >= 2) {
//                // 和iOS 10的按钮顺序相反
//                UIButton *deleteButton = subview.subviews[1];
//                UIButton *collectButton = subview.subviews[0];
//                [self configDeleteButton:deleteButton];
//                [self configCollectButton:collectButton];
//            }
//        }
//    }else {
//        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
//        for (UIView *subview in self.subviews) {
//            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subview.subviews count] >= 2) {
//                UIButton *deleteButton = subview.subviews[0];
//                UIButton *collectButton = subview.subviews[1];
//                [self configDeleteButton:deleteButton];
//                [self configCollectButton:collectButton];
//                [subview setBackgroundColor:[UIColor clearColor]];
//            }
//        }
//    }
//}
//
//- (void)configDeleteButton:(UIButton*)deleteButton {
//    if (deleteButton) {
//        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
//            for (UIView *deleteView in deleteButton.subviews) {
//                self.deleteImageView.image = [UIImage imageNamed:@"delete"];
//                self.deleteImageView.frame = CGRectMake(deleteView.frame.size.width/2-15, 10, 30, 40);
//                [deleteView addSubview:self.deleteImageView];
//
//                self.deleteLabel.frame = CGRectMake(0, deleteView.frame.size.height / 2.0 + 10, deleteView.frame.size.width, 20);
//                self.deleteLabel.text = @"删除";
//                [deleteView addSubview:self.deleteLabel];
//            }
//        }else {
//            self.deleteImageView.image = [UIImage imageNamed:@"delete"];
//            self.deleteImageView.frame = CGRectMake(deleteButton.frame.size.width/2-15, 10, 30, 40);
//            [deleteButton addSubview:self.deleteImageView];
//
//            self.deleteLabel.frame = CGRectMake(0, deleteButton.frame.size.height / 2.0 + 10, deleteButton.frame.size.width, 20);
//            self.deleteLabel.text = @"删除";
//            [deleteButton addSubview:self.deleteLabel];
//        }
//        [deleteButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
//        [deleteButton setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
//    }
//}
//
//- (void)configCollectButton:(UIButton*)collectButton {
//    if (collectButton) {
//        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
//            for (UIView *collectView in collectButton.subviews) {
//                self.collectImageView.image = [UIImage imageNamed:@"collect"];
//                self.collectImageView.frame = CGRectMake(collectView.frame.size.width/2-15, 10, 30, 40);
//                [collectView addSubview:self.collectImageView];
//
//                self.collectLabel.frame = CGRectMake(0, collectView.frame.size.height / 2.0 + 10, collectView.frame.size.width, 20);
//                self.collectLabel.text = @"收藏";
//                [collectView addSubview:self.collectLabel];
//            }
//        }else {
//            self.collectImageView.image = [UIImage imageNamed:@"collect"];
//            self.collectImageView.frame = CGRectMake(collectButton.frame.size.width/2-15, 10, 30, 40);
//            [collectButton addSubview:self.collectImageView];
//
//            self.collectLabel.frame = CGRectMake(0, collectButton.frame.size.height / 2.0 + 10, collectButton.frame.size.width, 20);
//            self.collectLabel.text = @"收藏";
//            [collectButton addSubview:self.collectLabel];
//        }
//        [collectButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
//        [collectButton setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
//    }
//}
//
////获取当前cell的tableview
//- (UITableView *)tableView {
//    UIView *tableView = self.superview;
//    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
//        tableView = tableView.superview;
//    }
//    return (UITableView *)tableView;
//}

@end
