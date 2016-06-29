//
//  studentController.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/24.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
#import "stuinfo.h"
#import "stuinfocell.h"
#import "stuinfocontroller.h"
#import "stupasswdchange.h"

@interface studentController : UITableViewController<UIActionSheetDelegate,StuInfo>
{
    NSString *stuid;
    FMDatabase *db;
    NSMutableArray *item;
}
- (IBAction)loginoutclick:(id)sender;

@property (nonatomic, strong) NSMutableArray *studentinfo;

@end
