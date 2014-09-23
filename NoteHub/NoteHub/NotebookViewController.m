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

- (void)createNote {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setTimeoutInterval:10];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"Token token=15d0dafb0c5a1b9cd42ea0313d51214a8c494edac168fe8d6fd2eee726fd6de2121f32905e30231877b9238583ce2fa20419dc1c50d2e32d94479ec381774733" forHTTPHeaderField:@"Authorization"];
    
    [request setURL:[NSURL URLWithString:@"http://localhost:3000/api/v1/courses/1/notes"]];
    
    NSDictionary * sender = @{
                              @"note": @{
                                      @"title": @"Title 1",
                                      @"date": @"",
                                      @"words": assistedNotebook.text,
                                      @"lines": @""
                                      }
                              };
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:sender options:kNilOptions error:nil]];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments
                                                                error:nil];
        NSLog(@"%@", dict);
    }];
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
        
        [self createNote];
    } else {
        pencilButton.title = @"Lapiz";
        [assistedNotebook setDrawable:false];
        
        [assistedNotebook resignFirstResponder];
        [assistedNotebook endEditing:YES];
        
        [assistedNotebook setEditable:YES];
        
    }
    
}
@end
