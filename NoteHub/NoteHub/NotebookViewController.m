//
//  NotebookViewController.m
//  NoteHub
//
//  Created by Jonathan Eidelman on 16/09/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "NotebookViewController.h"

@interface NotebookViewController ()

@end

@implementation NotebookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self writing:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)writing:(id)sender {
    if ([[pencilButton title] isEqualToString:@"Lapiz"]) {
        pencilButton.title = @"Teclado";
        [assistedNotebook setDrawable:true];
        
        [assistedNotebook resignFirstResponder];
        [assistedNotebook endEditing:YES];
        [assistedNotebook setEditable:false];
    } else {
        pencilButton.title = @"Lapiz";
        [assistedNotebook setDrawable:false];
        
        [assistedNotebook resignFirstResponder];
        [assistedNotebook endEditing:YES];
        
        [assistedNotebook setEditable:YES];
        
    }
    
}
@end
