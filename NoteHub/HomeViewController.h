//
//  HomeViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 10/21/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
#import "searchTableTableViewController.h"

@interface HomeViewController : UIViewController <CommunicationDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)searchAction:(id)sender;
- (IBAction)settingsAction:(id)sender;
@end
