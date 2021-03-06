//
//  NotebookViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 16/09/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHAssistedNotebookView.h"
#import "CommunicationManager.h"
#import "notebookListTableViewController.h"

@interface NotebookViewController : UIViewController <UISplitViewControllerDelegate, CommunicationDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet UIBarButtonItem *pencilButton;
    __weak IBOutlet NHAssistedNotebookView *assistedNotebook;    
}

@property (nonatomic, weak) NSString * text;
@property (nonatomic, weak) NSString * pattern;
@property (nonatomic) NSInteger note_id;
- (IBAction)published_action:(id)sender;
@property (nonatomic) NSInteger course_id;
@property (nonatomic) NSInteger group_id;
- (IBAction)writing:(id)sender;

@end
