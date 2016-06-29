//
//  showsearchinfo.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "showsearchinfo.h"

@interface showsearchinfo ()

@end

@implementation showsearchinfo

-(void)showinfo
{
    self.idfield.text = self.student.idtmp;
    self.passwordfield.text = self.student.passwdtmp;
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

@end
