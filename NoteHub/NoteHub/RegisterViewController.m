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
    CommunicationManager * cm = [[CommunicationManager alloc] init];
    cm.delegate = self;
    NSDictionary * dict = @{@"user": @{@"name":nameTextField.text,
                                       @"username":usernameTextField.text,
                                       @"email":emailTextField.text,
                                       @"password":passwordTextField.text}};
    
    [cm createUser:dict];
}
@end
