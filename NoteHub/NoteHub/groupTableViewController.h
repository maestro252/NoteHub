//
//  groupTableViewController.h
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 11/12/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
#import "groupNotesTableViewController.h"


@interface groupTableViewController : UITableViewController<CommunicationDelegate, UIAlertViewDelegate>{
    
    NSMutableArray * data;
    NSDictionary * database;
}
- (IBAction)createGroup:(id)sender;
@end
