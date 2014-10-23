//
//  HomeViewController.m
//  NoteHub
//
//  Created by Jonathan Eidelman on 10/21/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogged"]) {
        [self performSegueWithIdentifier:@"login_segue" sender:nil];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchAction:(id)sender {
    CommunicationManager * cm = [CommunicationManager new];
    [cm setDelegate:self];
    [cm searchNotes:self.searchTextField.text];
}

- (IBAction)settingsAction:(id)sender {
    [self performSegueWithIdentifier:@"setting_segue" sender:nil];
}

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict{
    NSLog(@"%@",dict);
    [self performSegueWithIdentifier:@"search_segue" sender:dict];
    
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"search_segue"]) {
        UINavigationController * u = (UINavigationController *)segue.destinationViewController;
        searchTableTableViewController * stvc = (searchTableTableViewController *)u.topViewController;
        
        [stvc setDict:sender];
    }else if([segue.identifier isEqual:@"setting_segue"]){
        
    }
}
@end
