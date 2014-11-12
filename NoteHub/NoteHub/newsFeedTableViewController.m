//
//  newsFeedTableViewController.m
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 11/10/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "newsFeedTableViewController.h"

@interface newsFeedTableViewController ()

@end

@implementation newsFeedTableViewController

- (void)viewDidLoad {
    self.data = [NSMutableArray new];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    CommunicationManager * cm = [CommunicationManager new];
    [cm setDelegate:self];
    [cm setTag:44];
    [cm getFriendsPublished];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    [[cell textLabel]setText:[[self.data objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    [[cell detailTextLabel] setText:[[self.data objectAtIndex:indexPath.row] objectForKey:@"username"]];
    
    
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

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict{
    if (comm.tag == 63) {
        
        if([[dict objectForKey:@"success"]integerValue] == 0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error al agregar amigo" message:[[dict objectForKey:@"errors"] objectAtIndex:0] delegate:nil cancelButtonTitle:@"Ok"  otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if(comm.tag == 44){
        NSLog(@"ESTE ES EL DICT QUE QUEREMOS VER!!! %@", dict);
        for (NSDictionary * inner in [dict objectForKey:@"notes"]) {
            [self.data addObject:inner];
        }
        
        [self.tableView reloadData];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        //agregar
        CommunicationManager * cm = [CommunicationManager new];
        [cm setDelegate:self];
        [cm setTag:63];
        [cm addFriendByUsername:[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue] username:[alertView textFieldAtIndex:0].text];
        
    }
    
}

- (IBAction)addFriends:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Agregar amigo" message:@"Introduzca el nombre de usuario a agregar" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}
@end
