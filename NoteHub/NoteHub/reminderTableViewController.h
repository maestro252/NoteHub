//
//  reminderTableViewController.h
//  NoteHub
//
//  Created by Santiago Carmona Gonazalez on 10/27/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
@interface reminderTableViewController : UITableViewController<UIAlertViewDelegate,CommunicationDelegate>
{
    NSString * reminderTitle;
    NSMutableArray * data;
    NSDate * date;
}
- (IBAction)addReminder:(id)sender;
@end
