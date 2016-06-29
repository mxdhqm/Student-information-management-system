//
//  SearchInfo.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "SearchInfo.h"

@interface SearchInfo ()

@end

@implementation SearchInfo


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

-(void)findstuinfo
{
    FMResultSet *rs=[db executeQuery:@"SELECT * FROM info"];
    rs=[db executeQuery:@"SELECT * FROM info WHERE id = ? or name = ? or tel = ?",self.idfield.text,self.namefield.text,self.telfield.text];
    while ([rs next]){
        stu = [[stuinfo alloc]init];
        stu.idtmp = [rs stringForColumn:@"id"];
        stu.passwdtmp = [rs stringForColumn:@"password"];
        stu.nametmp = [rs stringForColumn:@"name"];
        stu.sextmp = [rs stringForColumn:@"sex"];
        stu.agetmp = [rs stringForColumn:@"age"];
        stu.teltmp = [rs stringForColumn:@"tel"];
        stu.addresstmp = [rs stringForColumn:@"address"];
        [self performSegueWithIdentifier:@"showsearchinfo" sender:nil];
    }
    if (stu == nil) {
        NSLog(@"ERROR");
        [self ShowError:@"无此人"];
    }
    
}

-(void)ShowError:(NSString *)infotext
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]];
    
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = infotext;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.idfield becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self opendb];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    id vc = segue.destinationViewController;
    showsearchinfo *info = vc;
    info.student = stu;
    info.delegate = self;
}

- (IBAction)searchclick:(id)sender {
    [self findstuinfo];
    self.idfield.text = nil;
    self.namefield.text = nil;
    self.telfield.text = nil;
    stu = nil;
}
@end
