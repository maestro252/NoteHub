//
//  RegisterViewController.m
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 10/7/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(repaint) name: UIDeviceOrientationDidChangeNotification object:nil];
    
    [[nameTextField layer] setBorderWidth:1.0f];
    [[nameTextField layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[nameTextField layer] setCornerRadius:10];
    [nameTextField setFont:[UIFont systemFontOfSize:20]];
    [nameTextField setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    
    [[usernameTextField layer] setBorderWidth:1.0f];
    [[usernameTextField layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[usernameTextField layer] setCornerRadius:10];
    [usernameTextField setFont:[UIFont systemFontOfSize:20]];
    [usernameTextField setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    
    [[emailTextField layer] setBorderWidth:1.0f];
    [[emailTextField layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[emailTextField layer] setCornerRadius:10];
    [emailTextField setFont:[UIFont systemFontOfSize:20]];
    [emailTextField setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    
    [[passwordTextField layer] setBorderWidth:1.0f];
    [[passwordTextField layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[passwordTextField layer] setCornerRadius:10];
    [passwordTextField setFont:[UIFont systemFontOfSize:20]];
    [passwordTextField setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    
    [[confirmPasswordTextField layer] setBorderWidth:1.0f];
    [[confirmPasswordTextField layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[confirmPasswordTextField layer] setCornerRadius:10];
    [confirmPasswordTextField setFont:[UIFont systemFontOfSize:20]];
    [confirmPasswordTextField setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    
    [[registerButton layer] setBorderWidth:1.0f];
    [[registerButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[registerButton layer] setCornerRadius:10];
    [registerButton setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f]];
    
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


- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict {
    NSLog(@"%@", dict);
    
    if ([[dict objectForKey:@"success"] integerValue] == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        for (NSString * e in [dict objectForKey:@"errors"]) {
            NSMutableString * str = [NSMutableString new];
            
            for (NSString * s in [[dict objectForKey:@"errors"] objectForKey:e]) {
                [str appendString:[NSString stringWithFormat:@"%@ ", s]];
            }
            
            [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error en %@", ([e isEqualToString:@"password_encrypted"]) ? @"password" : e]
                                        message:str
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil] show];
            
        }
        
    }
}
- (IBAction)registerAction:(id)sender {
    
    if ([passwordTextField.text isEqualToString:confirmPasswordTextField.text]) {
        
    
    
    CommunicationManager * cm = [[CommunicationManager alloc] init];
    cm.delegate = self;
    NSDictionary * dict = @{@"user": @{@"name":nameTextField.text,
                                       @"username":usernameTextField.text,
                                       @"email":emailTextField.text,
                                       @"password":passwordTextField.text}};
    
    [cm createUser:dict];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Las contraseñas no coinciden" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         
    }
}
@end
