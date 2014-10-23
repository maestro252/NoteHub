//
//  courseTableViewController.m
//  NoteHub
//
//  Created by Jonathan Eidelman on 9/10/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "courseTableViewController.h"
#import "notebookListTableViewController.h"

@interface courseTableViewController ()

@end

@implementation courseTableViewController

- (void)viewDidLoad {
    data = [NSMutableArray new];
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    [self reload];
    [super viewWillAppear:animated];
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
    
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict {
    @try {
        NSLog(@"%@", dict);
        
        database = dict;
        
        for (NSDictionary * inner in dict) {
            [data addObject:[inner objectForKey:@"name"]];
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
    [cm getCourses];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"notebooks_segue" sender:indexPath];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"notebooks_segue"]) {
        notebookListTableViewController * c = (notebookListTableViewController *)segue.destinationViewController;
        
        NSLog(@"%@ HOLA", database);
        
        NSMutableArray * array = [NSMutableArray new];
        
        for (NSDictionary * d in database) {
            [array addObject:d];
        }
        
        NSIndexPath * path = (NSIndexPath *)sender;
        
        [c setCourse:[array objectAtIndex:path.row]];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
