//
//  Addstuinfo.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stuinfo.h"

@class stuinfo,Addstuinfo;

@protocol Addinfo <NSObject>

- (void)addViewController:(Addstuinfo *)addVc didAddStudentinfo:(stuinfo *)student;

@end


@interface Addstuinfo : UIViewController <Addinfo>

@property (nonatomic, weak) id<Addinfo> delegate;

@property (weak, nonatomic) IBOutlet UITextField *idfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordfield;
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *sexfield;
@property (weak, nonatomic) IBOutlet UITextField *agefield;
@property (weak, nonatomic) IBOutlet UITextField *telfield;
@property (weak, nonatomic) IBOutlet UITextField *addressfield;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *savebtn;
- (IBAction)saveclick:(id)sender;





@end
