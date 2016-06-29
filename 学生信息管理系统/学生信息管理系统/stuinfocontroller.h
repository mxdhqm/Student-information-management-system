//
//  stuinfocontroller.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/24.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stuinfo.h"
#import "MBProgressHUD.h"

@class studentController,stuinfocontroller;

@protocol StuInfo <NSObject>

- (void)studentinfo:(stuinfocontroller *)info didSavestudentinfo:(stuinfo *)student;

@end




@interface stuinfocontroller : UIViewController <StuInfo>
{
    MBProgressHUD *HUD;
}

@property (nonatomic, weak) id<StuInfo> delegate;
@property (nonatomic, strong)stuinfo *student;

@property (weak, nonatomic) IBOutlet UITextField *idfield;
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *sexfield;
@property (weak, nonatomic) IBOutlet UITextField *agefield;
@property (weak, nonatomic) IBOutlet UITextField *telfield;
@property (weak, nonatomic) IBOutlet UITextField *addressfield;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editbtn;
@property (weak, nonatomic) IBOutlet UIButton *savebtn;

- (IBAction)editclick:(UIBarButtonItem *)sender;
- (IBAction)saveclick:(id)sender;







@end
