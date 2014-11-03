//
//  NewCourseViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 8/10/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
#import "courseTableViewController.h"
@interface NewCourseViewController : UIViewController <CommunicationDelegate>
{
    __weak IBOutlet UITextField *courseNameTextField;
    
    __weak IBOutlet UITextField *courseDescriptionTextField;
    __weak IBOutlet UITextField *startDateTextField;
    __weak IBOutlet UITextField *endDateTextField;
}

- (IBAction)saveButton:(id)sender;

@end
