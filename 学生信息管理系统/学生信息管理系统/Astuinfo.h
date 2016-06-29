//
//  Astuinfo.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
#import "stuinfo.h"
#import "infocell.h"
#import "Addstuinfo.h"
#import "AstuinfoController.h"


@interface Astuinfo : UITableViewController <Info,UIAlertViewDelegate>
{
    FMDatabase *db;
    NSString *stuidtmp;
    NSIndexPath* indextmp;
}



@property (nonatomic, strong) NSMutableArray *studentinfo;

@end
