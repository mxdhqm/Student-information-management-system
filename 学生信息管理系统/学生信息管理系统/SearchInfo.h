//
//  SearchInfo.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
#import "stuinfo.h"
#import "showsearchinfo.h"
#import "MBProgressHUD.h"

@interface SearchInfo : UIViewController <ShowInfo>
{
    FMDatabase *db;
    stuinfo *stu;
    MBProgressHUD *HUD;
    
}

@property (weak, nonatomic) IBOutlet UITextField *idfield;
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *telfield;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchbtn;
- (IBAction)searchclick:(id)sender;



@end
