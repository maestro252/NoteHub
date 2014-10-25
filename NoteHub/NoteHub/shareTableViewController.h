//
//  shareTableViewController.h
//  NoteHub
//
//  Created by Jonathan Eidelman on 10/25/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
@interface shareTableViewController : UITableViewController<CommunicationDelegate>
{
    NSDictionary * database;
    NSMutableArray * data;
}
@end
