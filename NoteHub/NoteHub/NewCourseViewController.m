//
//  NewCourseViewController.m
//  NoteHub
//
//  Created by Jonathan Eidelman on 8/10/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "NewCourseViewController.h"

@interface NewCourseViewController ()

@end

@implementation NewCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveButton:(id)sender{
    CommunicationManager * cm = [[CommunicationManager alloc] init];
    cm.delegate = self;
    NSDictionary * dict = @{@"course": @{@"name":courseNameTextField.text,
                                       @"description":courseDescriptionTextField.text,
                                       @"start":startDateTextField.text,
                                       @"end":endDateTextField.text}};
    
    [cm createCourse:dict];
}

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict {
    
    if ([[dict objectForKey:@"success"] integerValue] == 1) {
        courseTableViewController * c = (courseTableViewController *)[[self.navigationController viewControllers] objectAtIndex:0];
        
        [c reload];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        for (NSString * e in [dict objectForKey:@"errors"]) {
            NSMutableString * str = [NSMutableString new];
            
            for (NSString * s in [[dict objectForKey:@"errors"] objectForKey:e]) {
                [str appendString:[NSString stringWithFormat:@"%@ ", s]];
            }
            
            [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error en %@", e]
                                        message:str
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil] show];
            
        }
        
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
