//
//  stupasswdchange.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/24.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "stupasswdchange.h"

@interface stupasswdchange ()

@end

@implementation stupasswdchange

- (void)viewDidLoad {
    [super viewDidLoad];
    self.idfield.text = self.student.idtmp;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.oldpassword];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.newpassword];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.newpassword2];
    
    // Do any additional setup after loading the view.
}

-(void)textChange
{
    self.savebtn.enabled = (self.oldpassword.text.length && self.newpassword.text.length && self.newpassword2.text.length);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.oldpassword becomeFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)ShowInfo:(NSString *)infotext WithImage:(NSString *)image
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];

    HUD.mode = MBProgressHUDModeCustomView;

    HUD.delegate = self;
    HUD.labelText = infotext;

    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5];
}

- (IBAction)saveclick:(id)sender {
    if (![self.oldpassword.text isEqualToString:self.student.passwdtmp]) {
        [self ShowInfo:@"密码错误" WithImage:@"error.png"];
        self.oldpassword.text = nil;
        self.newpassword.text = nil;
        self.newpassword2.text = nil;
        [self.oldpassword becomeFirstResponder];
    }
    else
    {
        if ([self.oldpassword.text isEqualToString:self.newpassword.text]) {
            [self ShowInfo:@"与原密码相同" WithImage:@"error.png"];
            self.newpassword.text = nil;
            self.newpassword2.text = nil;
            [self.newpassword becomeFirstResponder];
        }
        else{
            if (![self.newpassword.text isEqualToString:self.newpassword2.text]) {
                [self ShowInfo:@"密码不匹配" WithImage:@"error.png"];
                self.newpassword.text = nil;
                self.newpassword2.text = nil;
                [self.newpassword becomeFirstResponder];
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(studentinfo:didSavepasswordinfo:)])
                {
                    self.student.passwdtmp = self.newpassword.text;
                    [self.delegate studentinfo:self didSavepasswordinfo:self.student];
                }
                [self ShowInfo:@"修改成功" WithImage:@"success.png"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSArray *viewControllers = self.navigationController.viewControllers;
                    [self.navigationController popToViewController:[viewControllers objectAtIndex:viewControllers.count-2] animated:YES];
                });
            }
        }
    }
    
}
@end
