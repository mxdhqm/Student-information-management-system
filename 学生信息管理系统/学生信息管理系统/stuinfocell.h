//
//  stuinfocell.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stuinfocell : UITableViewCell<NSCoding>

@property (nonatomic, weak) UIView *divider;

@property (weak, nonatomic) IBOutlet UILabel *infolable;

@property (copy, nonatomic) NSString *iteminfo;
@end
