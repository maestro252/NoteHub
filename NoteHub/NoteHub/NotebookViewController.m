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
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateNote) userInfo:nil repeats:YES];
    
    [timer fire];
    
    [self writing:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateNote {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setTimeoutInterval:10];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"Token token=58bb049ac1932cbf128155dd343aa6f202b7cfb1cecb64f3578b0700da2bf4eb6c453c5f80030edc0d2ad1530ce1e835f819919e28d29c79e7a4f1e16c877b4" forHTTPHeaderField:@"Authorization"];
    
    [request setURL:[NSURL URLWithString:@"http://localhost:3000/api/v1/courses/1/notes/8"]];
    
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDictionary * sender = @{
                              @"note": @{
                                      @"title": @"Title 1",
                                      @"date": [f stringFromDate:[NSDate date]],
                                      @"words": assistedNotebook.text,
                                      @"lines": @""
                                      }
                              };
    
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:sender options:kNilOptions error:nil]];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments
                                                                error:nil];
        NSLog(@"%@", dict);
        
        if (dict) {
            if ([dict objectForKey:@"errors"] != nil) {
                for (NSString * error in [dict objectForKey:@"errors"]) {
                    [[[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                }
            }
        }
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
    } else {
        pencilButton.title = @"Lapiz";
        [assistedNotebook setDrawable:false];
        
        [assistedNotebook resignFirstResponder];
        [assistedNotebook endEditing:YES];
        
        [assistedNotebook setEditable:YES];
        
    }
    
}
@end
