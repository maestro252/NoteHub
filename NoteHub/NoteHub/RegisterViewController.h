//
//  RegisterViewController.h
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 10/7/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
@interface RegisterViewController : UIViewController <CommunicationDelegate>{
    
    __weak IBOutlet UITextField *nameTextField;
    
    __weak IBOutlet UITextField *usernameTextField;
    __weak IBOutlet UITextField *emailTextField;
    __weak IBOutlet UITextField *passwordTextField;
    __weak IBOutlet UITextField *confirmPasswordTextField;
    __weak IBOutlet UIButton *registerButton;
}

- (IBAction)registerAction:(id)sender;
@end
