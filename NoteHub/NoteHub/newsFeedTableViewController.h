//
//  newsFeedTableViewController.h
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 11/10/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
@interface newsFeedTableViewController : UITableViewController<CommunicationDelegate, UIAlertViewDelegate>
- (IBAction)addFriends:(id)sender;

@end
