//
//  stupasswdchange.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/24.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stuinfo.h"
#import "MBProgressHUD.h"

@class studentController,stupasswdchange;

@protocol StuPasswd <NSObject>

- (void)studentinfo:(stupasswdchange *)info didSavepasswordinfo:(stuinfo *)student;

@end




@interface stupasswdchange : UIViewController <StuPasswd>
{
    MBProgressHUD *HUD;
}

@property (nonatomic, weak) id<StuPasswd> delegate;
@property (nonatomic, strong)stuinfo *student;

@property (weak, nonatomic) IBOutlet UITextField *idfield;
@property (weak, nonatomic) IBOutlet UITextField *oldpassword;
@property (weak, nonatomic) IBOutlet UITextField *newpassword;
@property (weak, nonatomic) IBOutlet UITextField *newpassword2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *savebtn;

- (IBAction)saveclick:(id)sender;



@end
