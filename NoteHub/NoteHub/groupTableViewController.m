//
//  groupTableViewController.m
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 11/12/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "groupTableViewController.h"

@interface groupTableViewController ()

@end

@implementation groupTableViewController

- (void)viewDidLoad {
    data = [NSMutableArray new];
    [super viewDidLoad];
    
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

-(void)viewWillAppear:(BOOL)animated{
    [self reload];
    [super viewWillAppear:animated];

}

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict {
    @try {
        NSLog(@"%@", dict);
        
        database = dict;
        for (NSDictionary * inner in [dict objectForKey:@"groups"]) {
            [data addObject:inner];
        }
        
        [self.tableView reloadData];
    }
    @catch (NSException *exception) { }
    @finally { }
}

- (void)reload {
    [data removeAllObjects];
    [self.tableView reloadData];
    
    CommunicationManager *cm = [CommunicationManager new];
    
    [cm setDelegate:self];
    [cm getGroups];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"esteeeeeeeee eessss coutnnnnn       %i", [data count]);
    return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    @try{
        cell.textLabel.text = [[[data objectAtIndex:indexPath.row]objectForKey:@"group"]objectForKey:@"name"];
    }@catch (NSException *exception) {
        
    }@finally{
    
    }
    
    // Configure the cell...
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        CommunicationManager * cm = [CommunicationManager new];
        [cm createGroup:[alertView textFieldAtIndex:0].text];
         [self reload];
    }
}

- (IBAction)createGroup:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Crear grupo" message:@"Introduzca el nombre del grupo" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Crear", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        [self performSegueWithIdentifier:@"group_notes_segue" sender:nil];
    }
}
@end
