//
//  AdminController.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/23.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infocell.h"
#import "Astuinfo.h"
#import "FMDB.h"
#import "stuinfo.h"
#import "stuinfocontroller.h"
#import "stupasswdchange.h"


@interface AdminController : UITableViewController <UIActionSheetDelegate,StuInfo,StuPasswd>
{
    NSString *adminid;
    NSMutableArray *item;
    FMDatabase *db;

}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginoutbutton;
- (IBAction)loginoutclick:(id)sender;
@property (nonatomic, strong) NSMutableArray *Admininfo;
@end
