//
//  groupNotesTableViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 11/13/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
@interface groupNotesTableViewController : UITableViewController<CommunicationDelegate,UIAlertViewDelegate>{
    
    NSMutableArray * data;
    NSDictionary * database;
    NSString * title;
}
@property (nonatomic, strong) NSDictionary * course;
@property (nonatomic) NSInteger group;
- (IBAction)createGroupNote:(id)sender;

@end
