//
//  scheduleViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 11/3/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
@interface scheduleViewController : UIViewController <CommunicationDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (weak, nonatomic) IBOutlet UITextField *classroom;
@property (weak, nonatomic) IBOutlet UISegmentedControl *weekday;
@property (nonatomic) NSInteger id_course;
- (IBAction)addSchedule_action:(id)sender;

@end
