//
//  login.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/23.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "FMDB.h"

@interface login : UIViewController <MBProgressHUDDelegate>
{
    FMDatabase *db;
    NSString *identitytmp;
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UITextField *idtextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwdtextfield;
@property (weak, nonatomic) IBOutlet UILabel *stu_admin_lable;
@property (weak, nonatomic) IBOutlet UISwitch *stu_admin_switch;
@property (weak, nonatomic) IBOutlet UIButton *loginbutton;
- (IBAction)switchclick:(id)sender;

- (IBAction)loginclick:(id)sender;

@end
