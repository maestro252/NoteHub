//
//  LoginViewController.m
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 10/1/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(repaint) name: UIDeviceOrientationDidChangeNotification object:nil];
    
    [[usernameLabel layer] setBorderWidth:1.0f];
    [[usernameLabel layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [[passwordLabel layer] setBorderWidth:1.0f];
    [[passwordLabel layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [[passwordLabel layer] setCornerRadius:10];
    [[usernameLabel layer] setCornerRadius:10];
    
    [usernameLabel setFont:[UIFont systemFontOfSize:20]];
    [passwordLabel setFont:[UIFont systemFontOfSize:20]];
    
    [usernameLabel setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    [passwordLabel setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    
    [usernameLabel textRectForBounds:CGRectMake(10, 10, 10, 10)];
    
    [[loginButton layer] setBorderWidth:1.0f];
    [[loginButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[loginButton layer] setCornerRadius:10];
    [loginButton setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    
    [self repaint];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)repaint {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 2000, 1500);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:0.470f green:0.76f blue:0.08f alpha:1] CGColor],
                       (id)[[UIColor colorWithRed:0.23f green:0.45f blue:0.070f alpha:1] CGColor],
                       nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
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

- (IBAction)login:(id)sender {
    CommunicationManager * comm = [[CommunicationManager alloc] init];
    
    [comm setDelegate:self];
    [comm loginWithKey:usernameLabel.text password:passwordLabel.text];
    
    
}

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict {
    NSLog(@"%@", dict);
    
    if ([[dict objectForKey:@"success"] integerValue] == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error en login"
                                    message:[[dict objectForKey:@"errors"] objectAtIndex:0]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    }
}
@end
