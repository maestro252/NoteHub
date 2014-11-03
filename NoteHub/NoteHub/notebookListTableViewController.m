//
//  notebookListTableViewController.m
//  NoteHub
//
//  Created by Jonathan Eidelman on 9/10/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "notebookListTableViewController.h"
#import "scheduleViewController.h"

@interface notebookListTableViewController ()

@end

@implementation notebookListTableViewController
- (IBAction)settings:(id)sender {
    [self performSegueWithIdentifier:@"schedule_segue" sender:nil];
}

- (void)viewDidLoad {
    data = [NSMutableArray new];
    database = [NSDictionary new];
    
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = [self.course objectForKey:@"name"];
    
    [self reload];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController * nav = (UINavigationController *)[sb instantiateViewControllerWithIdentifier:@"home_view"];
    [[self splitViewController] showDetailViewController:nav sender:nil];
}

- (void)reload {
    CommunicationManager * c = [CommunicationManager new];
    [c setDelegate:self];
    [c getNotesForCourse:[[self.course objectForKey:@"id"] integerValue]];
}

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict {
    
    @try {
        NSLog(@"%@", dict);
        
        database = dict;
        [data removeAllObjects];
        for (NSDictionary * inner in dict) {
            [data addObject:inner];
        }
        
        [self.tableView reloadData];
    }
    @catch (NSException *exception) { }
    @finally { }
    
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
    @try {
        cell.textLabel.text = [[data objectAtIndex:indexPath.row] objectForKey:@"title"];
    }
    @catch (NSException *exception) { }
    @finally { }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UINavigationController * nav = (UINavigationController *)[sb instantiateViewControllerWithIdentifier:@"notebook_storyboard"];
        
        NotebookViewController * n = (NotebookViewController *)[nav topViewController];
        
        //[n setText:[[data objectAtIndex:indexPath.row] objectForKey:@"words"]];
        [n setPattern:[[data objectAtIndex:indexPath.row] objectForKey:@"pattern"]];
        [n setNote_id:[[[data objectAtIndex:indexPath.row]objectForKey:@"id"] integerValue]];
        [n setCourse_id:[[self.course objectForKey:@"id"] integerValue]];
        
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

- (IBAction)createNote:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Nueva nota:"
                                                     message:nil
                                                    delegate:self
                                           cancelButtonTitle:@"Cancelar"
                                           otherButtonTitles:@"Crear", nil];
    
    
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField * field = [alert textFieldAtIndex:0];
    [field setPlaceholder:@"Titulo de nota"];
    [alert setTag:2];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            title = [[alertView textFieldAtIndex:0] text];
            
            if (![title isEqual:@""]) {
                UIAlertView * patternChoice = [[UIAlertView alloc]initWithTitle:@"Tipo de cuaderno" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Rayado", @"Cuadriculado", @"Blanco", nil];
                [patternChoice setTag:3];
                [patternChoice show];
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No es posible crear una nota sin titulo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
            
            NSLog(@"Se crea %@", title);
        }
    }else if(alertView.tag == 3){
        NSString * toSend = [NSString new];
        if (buttonIndex == 0) {
            toSend = @"stripped";
        }
        else if (buttonIndex == 1) {
            toSend = @"gridded";
        }
        else {
            toSend = @"plain";
        }
       [[CommunicationManager new] createNoteForCourse:[[self.course objectForKey:@"id"] integerValue] withTitle:title pattern:toSend];
        CommunicationManager * c = [CommunicationManager new];
        [c setDelegate:self];
        [c getNotesForCourse:[[self.course objectForKey:@"id"] integerValue]];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"schedule_segue"]){
        scheduleViewController * svc = (scheduleViewController *)segue.destinationViewController;
        
        [svc setId_course:[[self.course objectForKey:@"id"] integerValue]];
    }
}
@end
