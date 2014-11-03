//
//  shareTableViewController.m
//  NoteHub
//
//  Created by Jonathan Eidelman on 10/25/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "shareTableViewController.h"
#import "NotebookViewController.h"

@interface shareTableViewController ()

@end

@implementation shareTableViewController

- (void)viewDidLoad {
    data = [NSMutableArray new];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [super viewDidLoad];
    
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
    return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [[data objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}


-(void)viewWillAppear:(BOOL)animated{
    CommunicationManager * cm = [CommunicationManager new];
    [cm setDelegate:self];
    [cm getShareNote];
    [super viewWillAppear:animated];
}

-(void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict {
    database = dict;
    
    NSLog(@"este es el que necesitamo papiririiiiiis %@", dict);
    
    for (NSDictionary * inner in [dict objectForKey:@"share"]) {
        [data addObject:[inner objectForKey:@"note"]];
    }
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UINavigationController * nav = (UINavigationController *)[sb instantiateViewControllerWithIdentifier:@"notebook_storyboard"];
        
        NotebookViewController * n = (NotebookViewController *)[nav topViewController];
        
        //[n setText:[[data objectAtIndex:indexPath.row] objectForKey:@"words"]];
        [n setPattern:[[data objectAtIndex:indexPath.row] objectForKey:@"pattern"]];
        [n setNote_id:[[[data objectAtIndex:indexPath.row]objectForKey:@"id"] integerValue]];
        //[n setCourse_id:[[self.course objectForKey:@"id"] integerValue]];
        
        [[self splitViewController] showDetailViewController:nav sender:nil];
    }
    @catch (NSException *exception) { }
    @finally { }
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

@end
