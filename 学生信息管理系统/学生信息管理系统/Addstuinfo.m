//
//  Addstuinfo.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "Addstuinfo.h"

@interface Addstuinfo ()

@end

@implementation Addstuinfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.idfield];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordfield];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.namefield];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.sexfield];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.agefield];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.telfield];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.addressfield];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)textChange
{
    self.savebtn.enabled = (self.idfield.text.length && self.passwordfield.text.length && self.namefield.text.length);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 让姓名文本框成为第一响应者(叫出键盘)
    [self.idfield becomeFirstResponder];
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

- (IBAction)saveclick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(addViewController:didAddStudentinfo:)]) {
        stuinfo *info = [[stuinfo alloc]init];
        info.idtmp = self.idfield.text;
        info.passwdtmp = self.passwordfield.text;
        info.nametmp = self.namefield.text;
        info.sextmp = self.sexfield.text;
        info.agetmp = self.agefield.text;
        info.teltmp = self.telfield.text;
        info.addresstmp = self.addressfield.text;
        
        
        [self.delegate addViewController:self didAddStudentinfo:info];
    }
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:[viewControllers objectAtIndex:viewControllers.count-2] animated:YES];
    
}
@end
