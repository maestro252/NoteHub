//
//  scheduleViewController.m
//  NoteHub
//
//  Created by Jonathan Eidelman on 11/3/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "scheduleViewController.h"

@interface scheduleViewController ()

@end

@implementation scheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.picker setDatePickerMode:UIDatePickerModeTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict {
    NSLog(@"%@", dict);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addSchedule_action:(id)sender {
    CommunicationManager * cm = [CommunicationManager new];
    [cm setDelegate:self];
    [cm createSchedule:[NSString stringWithFormat:@"%ld", (long)self.id_course] weekday:[self.weekday titleForSegmentAtIndex:self.weekday.selectedSegmentIndex] time:@"3:00" classroom:self.classroom.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
