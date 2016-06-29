//
//  stuinfocontroller.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/24.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "stuinfocontroller.h"

@interface stuinfocontroller ()

@end

@implementation stuinfocontroller

-(void)showinfo
{
    self.idfield.text = self.student.idtmp;
    self.namefield.text = self.student.nametmp;
    self.sexfield.text = self.student.sextmp;
    self.agefield.text = self.student.agetmp;
    self.telfield.text = self.student.teltmp;
    self.addressfield.text = self.student.addresstmp;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self showinfo];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)editclick:(UIBarButtonItem *)sender {
    if (self.namefield.enabled) {
        self.namefield.enabled = NO;
        self.sexfield.enabled = NO;
        self.agefield.enabled = NO;
        self.telfield.enabled = NO;
        self.addressfield.enabled = NO;
        self.editbtn.title = @"编辑";
        self.savebtn.hidden = YES;
        [self.view endEditing:YES];
        
        self.namefield.text = self.student.nametmp;
        self.sexfield.text = self.student.sextmp;
        self.agefield.text = self.student.agetmp;
        self.telfield.text = self.student.teltmp;
        self.addressfield.text = self.student.addresstmp;
    }
    else
    {
        self.namefield.enabled = YES;
        self.sexfield.enabled = YES;
        self.agefield.enabled = YES;
        self.telfield.enabled = YES;
        self.addressfield.enabled = YES;
        self.editbtn.title = @"取消";
        self.savebtn.hidden = NO;
        [self.telfield becomeFirstResponder];
    }
    
}

-(void)ShowInfo:(NSString *)infotext
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success.png"]];
    
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = infotext;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5];
}


- (IBAction)saveclick:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];

    if ([self.delegate respondsToSelector:@selector(studentinfo:didSavestudentinfo:)])
    {
        self.student.idtmp = self.idfield.text;
        self.student.nametmp = self.namefield.text;
        self.student.sextmp = self.sexfield.text;
        self.student.agetmp = self.agefield.text;
        self.student.teltmp = self.telfield.text;
        self.student.addresstmp = self.addressfield.text;
        [self.delegate studentinfo:self didSavestudentinfo:self.student];
    }
    [self ShowInfo:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *viewControllers = self.navigationController.viewControllers;
        
        [self.navigationController popToViewController:[viewControllers objectAtIndex:viewControllers.count-2] animated:YES];
    });

    
}
@end
