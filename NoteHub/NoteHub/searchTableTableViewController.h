//
//  searchTableTableViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 10/21/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"

@interface searchTableTableViewController : UITableViewController <CommunicationDelegate> {
    NSMutableArray * database;
}
@property (nonatomic,strong) NSDictionary * dict;
@end
