//
//  ViewController.m
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 9/9/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogged"]) {
        [self performSegueWithIdentifier:@"login_segue" sender:nil];
    }
    
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settings:(id)sender {
    [self performSegueWithIdentifier:@"setting_segue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setting_segue"]) {
        UINavigationController * c = (UINavigationController *)segue.destinationViewController;
        
        SettingsTableViewController * s = (SettingsTableViewController *)[c topViewController];
        
        [s setDelgate:self];
    }
}

- (void)didLogout {
    [self performSegueWithIdentifier:@"login_segue" sender:nil];
}
@end
