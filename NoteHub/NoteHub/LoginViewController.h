//
//  LoginViewController.h
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 10/1/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CommunicationManager.h"

@interface LoginViewController : UIViewController <CommunicationDelegate>
{
    __weak IBOutlet UITextField *usernameLabel;
    __weak IBOutlet UITextField *passwordLabel;
    __weak IBOutlet UIButton *loginButton;
}

- (IBAction)login:(id)sender;

@end
