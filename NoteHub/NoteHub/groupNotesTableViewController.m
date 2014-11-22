//
//  groupNotesTableViewController.m
//  NoteHub
//
//  Created by Jonathan Eidelman on 11/13/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "groupNotesTableViewController.h"

@interface groupNotesTableViewController ()

@end

@implementation groupNotesTableViewController

- (void)viewDidLoad {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


- (IBAction)createGroupNote:(id)sender {
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Nueva nota:"
//                                                     message:nil
//                                                    delegate:self
//                                           cancelButtonTitle:@"Cancelar"
//                                           otherButtonTitles:@"Crear", nil];
//    
//    
//    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    
//    UITextField * field = [alert textFieldAtIndex:0];
//    [field setPlaceholder:@"Titulo de nota"];
//    [alert setTag:2];
//    [alert show];
    if(true){ // si el usuario que clickeo es el admin aparecen las dos opciones, sino solo la de agregar nota.
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Que desea hacer?" message:nil delegate:self cancelButtonTitle:@"Agregar Nota" otherButtonTitles:@"Agregar Usuario", nil];
        [alert setTag:133];
        [alert show];
    }else{
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
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 133) {
        if (buttonIndex == 0) {
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

          
//            title = [[alertView textFieldAtIndex:0] text];
//            
//            if (![title isEqual:@""]) {
//                UIAlertView * patternChoice = [[UIAlertView alloc]initWithTitle:@"Tipo de cuaderno" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Rayado", @"Cuadriculado", @"Blanco", nil];
//                [patternChoice setTag:3];
//                [patternChoice show];
//            } else {
//                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No es posible crear una nota sin titulo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//            }
            
            NSLog(@"Se crea %@", title);
        }else if(buttonIndex == 1){
            UIAlertView * alerta = [[UIAlertView alloc]initWithTitle:@"Agregar Usuario" message:@"Introduzca el nombre de usuario" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Agregar", nil];
            [alerta setAlertViewStyle:UIAlertViewStylePlainTextInput];
            UITextField * field = [alerta textFieldAtIndex:0];
            [field setPlaceholder:@"Amigo nuevo"];
            [alerta setTag:256];
            [alerta show];
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
        [[CommunicationManager new] createNoteForCourse:0 withTitle:title pattern:toSend];
//        CommunicationManager * c = [CommunicationManager new];
//        [c setDelegate:self];
//        [c createNoteForCourse:0 withTitle:title pattern:toSend];
        
    }else if(alertView.tag == 2){
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
    } else if(alertView.tag == 256){
        NSLog(@"maimitmiamiamiamiamaimaim");
        CommunicationManager * c = [CommunicationManager new];
        
        [c addUserToGroup:self.group username:[alertView textFieldAtIndex:0].text];
        
    }
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


@end
