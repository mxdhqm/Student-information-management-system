//
//  login.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/23.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "login.h"

@interface login () <UITextFieldDelegate>

@end

@implementation login

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDir);
    
    
    identitytmp = @"student";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.idtextfield];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwdtextfield];
    
    // Do any additional setup after loading the view.
}

-(void)textChange
{
    self.loginbutton.enabled = (self.idtextfield.text.length && self.passwdtextfield.text.length);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)filepath
{ 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"info.sqlite"];
}

-(void)opendb
{
    db= [FMDatabase databaseWithPath:[self filepath]];
    if (![db open]) {
        NSLog(@"ERROR");
    }
    
}

-(BOOL)accountmatch
{
    [self opendb];

    FMResultSet *rs=[db executeQuery:@"SELECT * FROM info"];
    rs=[db executeQuery:@"SELECT * FROM info WHERE id = ? and password = ?",self.idtextfield.text, self.passwdtextfield.text];
    while ([rs next]){
        //NSLog(@"%@ %@ %@",[rs stringForColumn:@"id"],[rs stringForColumn:@"password"],[rs stringForColumn:@"identity"]);
        if ([self.idtextfield.text isEqualToString:[rs stringForColumn:@"id"]] && [self.passwdtextfield.text isEqualToString:[rs stringForColumn:@"password"]] && [identitytmp isEqualToString:[rs stringForColumn:@"identity"]]) {
            return YES;
        }
    }
    
    return NO;
}

- (IBAction)switchclick:(id)sender {
    BOOL value = self.stu_admin_switch.on;
    if(value)
    {
        self.stu_admin_lable.text = @"学生";
        identitytmp = @"student";
    }
    else
    {
        self.stu_admin_lable.text = @"管理员";
        identitytmp = @"admin";
    }
}

- (IBAction)loginclick:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    if ([self accountmatch]) {
        HUD.dimBackground = YES;
        HUD.removeFromSuperViewOnHide = YES;
        HUD.delegate = self;
        HUD.labelText = @"登录中";
        
        [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
        [db close];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if([identitytmp isEqualToString:@"student"])
            {
                [self performSegueWithIdentifier:@"student" sender:nil];
            }
            else if([identitytmp isEqualToString:@"admin"])
            {
                [self performSegueWithIdentifier:@"admin" sender:nil];
            }
        });
    }
    else
    {
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]];

        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"账号/密码错误";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        self.idtextfield.text = nil;
        self.passwdtextfield.text = nil;
        [self.idtextfield becomeFirstResponder];
        
    }
}

- (void)myTask {
    sleep(1);
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = @"登陆成功";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.1];
    
}

#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *gotocontroller = segue.destinationViewController;
    gotocontroller.title = [NSString stringWithFormat:@"欢迎-%@",self.idtextfield.text];
    
    
}

@end
