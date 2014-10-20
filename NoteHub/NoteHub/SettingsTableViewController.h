//
//  SettingsTableViewController.h
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 9/9/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationManager.h"
@class SettingsTableViewController;
@protocol SettingsDelegate <NSObject>
- (void)didLogout;
@end
@interface SettingsTableViewController : UITableViewController <CommunicationDelegate>
{
    __weak IBOutlet UITableViewCell *offline;
    
}
@property (nonatomic, weak) id<SettingsDelegate> delgate;
@end
