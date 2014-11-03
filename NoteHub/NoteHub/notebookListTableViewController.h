//
//  notebookListTableViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 9/10/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
#import "NotebookViewController.h"

@interface notebookListTableViewController : UITableViewController <CommunicationDelegate, UIAlertViewDelegate> {
    NSMutableArray * data;
    NSDictionary * database;
    NSString * title;
    NSMutableString * days;
    __weak IBOutlet UILabel *days_label;
}
@property (nonatomic, strong) NSDictionary * course;
- (IBAction)createNote:(id)sender;

- (void)reload;
@end
