//
//  Astuinfo.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "Astuinfo.h"

@interface Astuinfo ()

@end

@implementation Astuinfo

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
    rs=[db executeQuery:@"SELECT * FROM info  WHERE identity = 'student'"];
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



- (void)viewDidLoad {
    [super viewDidLoad];
    [self opendb];
    [self findstuinfo];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.studentinfo count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    infocell *cell = [tableView dequeueReusableCellWithIdentifier:@"stucell" forIndexPath:indexPath];
    
    stuinfo *info = self.studentinfo[indexPath.row];
    cell.textLabel.text = info.idtmp;
    cell.detailTextLabel.text = info.nametmp;

    return cell;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ( UITableViewCellEditingStyleDelete == editingStyle ) {
        
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
         message:@"确定要删除该学生吗?"
         delegate:self
         cancelButtonTitle:@"取消"
         otherButtonTitles:@"好",nil];
         [alert show];
        indextmp = indexPath;
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"取消删除操作");
    }
    else if(buttonIndex == 1)
    {
        stuinfo *stu = self.studentinfo[indextmp.row];
        [db executeUpdate:@"DELETE FROM info WHERE id = ?",stu.idtmp];
        [self.studentinfo removeObjectAtIndex:indextmp.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indextmp]withRowAnimation:UITableViewRowAnimationLeft];
        
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
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    if ([vc isKindOfClass:[AstuinfoController class]])
    {
        AstuinfoController *thisadmininfo = vc;
        thisadmininfo.student = self.studentinfo[path.row];
        thisadmininfo.delegate = self;
        stuinfo *stu = self.studentinfo[path.row];
        stuidtmp = stu.idtmp;
    }
    else if ([vc isKindOfClass:[Addstuinfo class]])
    {
        Addstuinfo *addVc = segue.destinationViewController;
        addVc.delegate = self;
    }
    
}

- (void)studentinfo:(AstuinfoController *)info didSavestudentinfo:(stuinfo *)student
{
    [db executeUpdate:@"UPDATE info SET id = ?, password = ?, name = ?, sex = ?, age = ?, tel = ?, address = ? WHERE id = ? ", student.idtmp, student.passwdtmp, student.nametmp, student.sextmp, student.agetmp, student.teltmp, student.addresstmp, stuidtmp];
    [self.tableView reloadData];
    
}

- (void)addViewController:(Addstuinfo *)addVc didAddStudentinfo:(stuinfo *)student
{
    [self.studentinfo addObject:student];
    
    [db executeUpdate:@"INSERT INTO info (id,password,identity,name,sex,age,tel,address) VALUES (?,?,'student',?, ?, ?, ?, ?)",student.idtmp, student.passwdtmp, student.nametmp,student.sextmp, student.agetmp, student.teltmp, student.addresstmp];
    
    
    [self.tableView reloadData];
}



@end
