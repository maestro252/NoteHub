//
//  SettingsTableViewController.m
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 9/9/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    UISwitch * swoffline = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    
    [offline setAccessoryView:swoffline];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4 && indexPath.row == 0) {
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogged"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"lifetime"];
        
        if ([self.delgate respondsToSelector:@selector(didLogout)]) {
            [self.delgate didLogout];
        }
    }else if(indexPath.section == 0 && indexPath.row == 0){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Editar Descripcion"
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:@"Cancelar"
                                               otherButtonTitles:@"Guardar", nil];
        
        
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        UITextField * field = [alert textFieldAtIndex:0];
        [field setPlaceholder:@"Descripcion del usuario"];
        
        [alert show];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString * title = [[alertView textFieldAtIndex:0] text];
        
        if (![title isEqual:@""]) {
            CommunicationManager * c = [CommunicationManager new];
            [c updateUser:@{
                            @"user": @{
                                    @"description": title
                                    }
                            }];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No es posible crear una nota sin titulo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        
        NSLog(@"Se crea %@", title);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
