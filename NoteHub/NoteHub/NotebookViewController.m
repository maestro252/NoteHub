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
    
    assistedNotebook.text = self.text;
    if ([self.pattern isEqualToString:@"stripped"]) {
        assistedNotebook.style = NHAssistedNotebookPatternStriped;
    }else if([self.pattern isEqualToString:@"gridded"]){
        assistedNotebook.style = NHAssistedNotebookPatternGridded;
    }else{
        assistedNotebook.style = NHAssistedNotebookPatternFlat;
    }
    [self writing:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict{
    
    if(comm.tag == 199){
        [comm setTag:255];
        [comm createSharedNotes:[NSString stringWithFormat:@"%ld",(long)self.note_id] id_user:[[dict objectForKey:@"user"] objectForKey:@"id"]];
        
    } else if(comm.tag == 255){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Compartdio exitoso" message:@"La nota se ha compartido satisfactoriamente" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        assistedNotebook.text = [[dict objectForKey:@"note"] objectForKey:@"words"];
        NSLog(@"%@", dict);
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    CommunicationManager * c = [CommunicationManager new];
    [c updateNote:@{
                                                  @"note": @{
                                                          @"words": assistedNotebook.text,
                                                          @"lines": @""
                                                          }
                                                  } noteID:self.note_id courseID:self.course_id];
    
    NSLog(@"HOOOOOOOOOOOOOOOOOOOOOLI %@", assistedNotebook.text);
}

- (void)viewWillAppear:(BOOL)animated{
    CommunicationManager * cm = [CommunicationManager new];
    [cm setDelegate:self];
    [cm getNoteById:self.note_id];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateNote {
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    
//    [request setTimeoutInterval:10];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"Token token=58bb049ac1932cbf128155dd343aa6f202b7cfb1cecb64f3578b0700da2bf4eb6c453c5f80030edc0d2ad1530ce1e835f819919e28d29c79e7a4f1e16c877b4" forHTTPHeaderField:@"Authorization"];
//    
//    [request setURL:[NSURL URLWithString:@"http://localhost:3000/api/v1/courses/1/notes/8"]];
//    
//    NSDateFormatter * f = [[NSDateFormatter alloc] init];
//    [f setDateFormat:@"yyyy-MM-dd"];
//    
//    
//    NSDictionary * sender = @{
//                              @"note": @{
//                                      @"title": @"Title 1",
//                                      @"date": [f stringFromDate:[NSDate date]],
//                                      @"words": assistedNotebook.text,
//                                      @"lines": @""
//                                      }
//                              };
//    
//    [request setHTTPMethod:@"PUT"];
//    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:sender options:kNilOptions error:nil]];
//    
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
//                                                              options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments
//                                                                error:nil];
//        NSLog(@"%@", dict);
//        
//        if (dict) {
//            if ([dict objectForKey:@"errors"] != nil) {
//                for (NSString * error in [dict objectForKey:@"errors"]) {
//                    [[[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//                }
//            }
//        }
//    }];
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
- (IBAction)published_action:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Publicar nota" message: nil delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Publicar Nota", @"Volver Privada", @"Compartir nota", nil];
    [alert setTag:99999];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 99999) {
        if (buttonIndex == 0) {
            //cancelar
        }else if (buttonIndex == 1){
            //publicar
            UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Agregar etiquetas" message:@"Ingrese las etiquetas separadas por espacios, limite de caracteres: 256" delegate:self cancelButtonTitle:@"cancelar" otherButtonTitles:@"Publicar", nil];
            [al setTag:12];
            [al setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [al show];
        }else if(buttonIndex == 3){
            //compartir
            UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"compartir nota" message:@"Ingrese el nombre de usuario con el que quiere compartir la nota" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Compartir", nil];
            [a setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [a setTag:20];
            [a show];
            
        }else if(buttonIndex == 2){
            //Volver privada
            CommunicationManager * cm = [CommunicationManager new];
            [cm setPrivate:self.note_id id_course:self.course_id];
            UIAlertView * al = [[UIAlertView alloc] initWithTitle:@"Nota privada" message:@"La nota ya no es publica" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [al show];
        }
    } else if (alertView.tag == 12) {
        if (buttonIndex == 1) {
            NSLog(@"%@", [alertView textFieldAtIndex:0].text);
            CommunicationManager * cm = [CommunicationManager new];
            [cm updateTagsByNoteId:self.note_id tags:[alertView textFieldAtIndex:0].text id_course:self.course_id];
        }
    } else if(alertView.tag == 20){
        CommunicationManager * cm = [CommunicationManager new];
        [cm setDelegate:self];
        [cm setTag:199];
        [cm getUserIdByUsername:[alertView textFieldAtIndex:0].text];
    }
    
}
@end
