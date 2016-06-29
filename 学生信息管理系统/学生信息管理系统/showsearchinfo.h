//
//  showsearchinfo.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stuinfo.h"

@class SearchInfo,showsearchinfo;

@protocol ShowInfo <NSObject>


@end



@interface showsearchinfo : UIViewController

@property (nonatomic, weak) id<ShowInfo> delegate;
@property (nonatomic, strong)stuinfo *student;

@property (weak, nonatomic) IBOutlet UITextField *idfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordfield;
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *sexfield;
@property (weak, nonatomic) IBOutlet UITextField *agefield;
@property (weak, nonatomic) IBOutlet UITextField *telfield;
@property (weak, nonatomic) IBOutlet UITextField *addressfield;



@end
