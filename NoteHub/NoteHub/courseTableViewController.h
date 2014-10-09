//
//  courseTableViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 9/10/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"

@interface courseTableViewController : UITableViewController <CommunicationDelegate> {
    
    NSMutableArray * data;
    NSDictionary * database;
    
}

- (void)reload;

@end
