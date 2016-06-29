//
//  AdminController.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/23.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "AdminController.h"

@interface AdminController ()

@end

@implementation AdminController

- (NSMutableArray *)Admininfo
{
    if (_Admininfo == nil) {
        _Admininfo = [NSMutableArray array];
    }
    return _Admininfo;
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

-(void)findstuinfo
{
    FMResultSet *rs=[db executeQuery:@"SELECT * FROM info"];
    rs=[db executeQuery:@"SELECT * FROM info WHERE id = ?",adminid];
    while ([rs next]){
        stuinfo *admind = [[stuinfo alloc]init];
        admind.idtmp = [rs stringForColumn:@"id"];
        admind.passwdtmp = [rs stringForColumn:@"password"];
        admind.nametmp = [rs stringForColumn:@"name"];
        admind.sextmp = [rs stringForColumn:@"sex"];
        admind.agetmp = [rs stringForColumn:@"age"];
        admind.teltmp = [rs stringForColumn:@"tel"];
        admind.addresstmp = [rs stringForColumn:@"address"];
        [self.Admininfo addObject:admind];
    }
}


-(void)initMutableArray
{
    item = [[NSMutableArray alloc]initWithObjects:nil];
    [item addObject:@"学生信息"];
    [item addObject:@"查询学生信息"];
    [item addObject:@"修改信息"];
    [item addObject:@"修改密码"];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    adminid = [self.navigationItem.title substringFromIndex:3];
    [self initMutableArray];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self opendb];
    [self findstuinfo];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginoutclick:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    
}

#pragma mark - actionsheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [item count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    infocell *cell = [tableView dequeueReusableCellWithIdentifier:@"adminitem" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.itemlable.text = item[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"Astuinfo" sender:nil];
    }
    else if(indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"searchstuinfo" sender:nil];
    }
    else if (indexPath.row == 2)
    {
        [self performSegueWithIdentifier:@"Admininfo" sender:nil];
    }
    else if (indexPath.row == 3)
    {
        [self performSegueWithIdentifier:@"Apasswordchange" sender:nil];
    }
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    if (path.row == 0 || path.row == 1)
    {
//        id vc = segue.destinationViewController;
//        if ([vc isKindOfClass:[Astuinfo class]]) {
//            
//            Astuinfo *info = segue.destinationViewController;
//        }
    }
    else if(path.row == 2 || path.row == 3)
    {
        id vc = segue.destinationViewController;
        stuinfocontroller *thisadmininfo = vc;
        thisadmininfo.student = self.Admininfo[0];
        thisadmininfo.delegate = self;
        stuinfo *stu = self.Admininfo[0];
        adminid = stu.idtmp;
    }
    
}
- (void)studentinfo:(stuinfocontroller *)info didSavestudentinfo:(stuinfo *)student
{
    [db executeUpdate:@"UPDATE info SET name = ?, sex = ?, age = ?, tel = ?, address = ? WHERE id = ? ",student.nametmp, student.sextmp, student.agetmp, student.teltmp, student.addresstmp, adminid];
}

//-(void)ShowError:(NSString *)infotext
//{
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success.png"]];
//    
//    HUD.mode = MBProgressHUDModeCustomView;
//    
//    HUD.delegate = self;
//    HUD.labelText = infotext;
//    
//    [HUD show:YES];
//    [HUD hide:YES afterDelay:1];
//}

- (void)studentinfo:(stupasswdchange *)info didSavepasswordinfo:(stuinfo *)student
{
    [db executeUpdate:@"UPDATE info SET password = ? WHERE id = ? ",student.passwdtmp, adminid];
    //[self ShowError:@"自动退出"];
}



@end
