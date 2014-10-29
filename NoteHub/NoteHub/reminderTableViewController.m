//
//  reminderTableViewController.m
//  NoteHub
//
//  Created by Santiago Carmona Gonazalez on 10/27/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "reminderTableViewController.h"

@interface reminderTableViewController ()

@end

@implementation reminderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [NSMutableArray new];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [data count];
}

-(void)addReminder:(id)sender{
    UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"Nuevo recordatorio" message:@"Escribar el recordatorio a añadir" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Ok", nil];
    [aler setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [aler setTag:290];
    [aler show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 290){
        if(buttonIndex == 1){
            reminderTitle = [alertView textFieldAtIndex:0].text;
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"Fecha limite" message:@"Digite la fecha en formato YYYY-MM-DD" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Crear", nil];
            [aler setTag:893];
            [aler setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [aler show];
            //NSLog(@"crear reminder");
        }
    }else if(alertView.tag == 893){
        if(buttonIndex == 1){
              CommunicationManager * cm = [CommunicationManager new];
              [cm createReminder:reminderTitle deadline:[alertView textFieldAtIndex:0].text];
            
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
            localNotification.alertBody = @"Your alert message";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

            
            [self refresh];
        }
    }
}
             
- (void)refresh {
    [data removeAllObjects];
    
    CommunicationManager * cm = [CommunicationManager new];
    [cm setDelegate:self];
    [cm getReminders];
}

-(void)viewWillAppear:(BOOL)animated{
    [self refresh];
}

-(void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict{
    NSLog(@"el dict es %@", dict);
    if (![dict objectForKey:@"success"]) {
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Formato de fecha invalido" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    
    for (NSDictionary *inn in [dict objectForKey:@"reminders"]) {
        [data addObject:inn];
    }
    NSLog(@"%@ este me lo ppapapadar", dict);
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    @try {
        cell.textLabel.text = [[data objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.detailTextLabel.text = [[data objectAtIndex:indexPath.row] objectForKey:@"deadline"];
    }
    @catch (NSException *exception) { }
    @finally { }
    
    
    if ([[[data objectAtIndex:indexPath.row] objectForKey:@"done"] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    // Configure the cell...
    return cell;
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
        CommunicationManager * cm = [CommunicationManager new];
        [cm deleteReminderById:[[[data objectAtIndex:indexPath.row] objectForKey:@"id"] integerValue]];
        [data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunicationManager * cm = [CommunicationManager new];
    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType != UITableViewCellAccessoryCheckmark) {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [cm updateReminderState:true id_reminder:[[[data objectAtIndex:indexPath.row] objectForKey:@"id"] integerValue]];
    } else  {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [cm updateReminderState:false id_reminder:[[[data objectAtIndex:indexPath.row] objectForKey:@"id"] integerValue]];
        
    }
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
