//
//  studentController.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/24.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "studentController.h"

@interface studentController ()

@end

@implementation studentController

- (NSMutableArray *)studentinfo
{
    if (_studentinfo == nil) {
        _studentinfo = [NSMutableArray array];
    }
    return _studentinfo;
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
    rs=[db executeQuery:@"SELECT * FROM info WHERE id = ?",stuid];
    while ([rs next]){
        stuinfo *stu = [[stuinfo alloc]init];
        stu.idtmp = [rs stringForColumn:@"id"];
        stu.passwdtmp = [rs stringForColumn:@"password"];
        stu.nametmp = [rs stringForColumn:@"name"];
        stu.sextmp = [rs stringForColumn:@"sex"];
        stu.agetmp = [rs stringForColumn:@"age"];
        stu.teltmp = [rs stringForColumn:@"tel"];
        stu.addresstmp = [rs stringForColumn:@"address"];
        [self.studentinfo addObject:stu];
    }
}

-(void)initMutableArray
{
    item = [[NSMutableArray alloc]initWithObjects:nil];
    [item addObject:@"信息查询"];
    [item addObject:@"修改密码"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMutableArray];
    [self opendb];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    stuid = [self.navigationItem.title substringFromIndex:3];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [item count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    stuinfocell *cell = [tableView dequeueReusableCellWithIdentifier:@"stuinfocell" forIndexPath:indexPath];
    cell.infolable.text = item[indexPath.row];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"stuinfo" sender:nil];
    }
    else if(indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"Stupasswdchange" sender:nil];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id vc = segue.destinationViewController;
    stuinfocontroller *thisstuinfo = vc;
    thisstuinfo.student = self.studentinfo[0];
    thisstuinfo.delegate = self;
    stuinfo *stu = self.studentinfo[0];
    stuid = stu.idtmp;
}


- (void)studentinfo:(stuinfocontroller *)info didSavestudentinfo:(stuinfo *)student
{
    [db executeUpdate:@"UPDATE info SET name = ?, sex = ?, age = ?, tel = ?, address = ? WHERE id = ? ",student.nametmp, student.sextmp, student.agetmp, student.teltmp, student.addresstmp, stuid];
}


- (void)studentinfo:(stupasswdchange *)info didSavepasswordinfo:(stuinfo *)student
{
    [db executeUpdate:@"UPDATE info SET password = ? WHERE id = ? ",student.passwdtmp, stuid];
    //[self ShowError:@"自动退出"];
}

@end
