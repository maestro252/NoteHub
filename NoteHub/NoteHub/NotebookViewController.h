//
//  NotebookViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 16/09/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHAssistedNotebookView.h"

@interface NotebookViewController : UIViewController
{
    __weak IBOutlet UIBarButtonItem *pencilButton;
    __weak IBOutlet NHAssistedNotebookView *assistedNotebook;    
}
- (IBAction)writing:(id)sender;
@end
