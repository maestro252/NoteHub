//
//  CommunicationManager.m
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 10/2/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "CommunicationManager.h"

@implementation CommunicationManager

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.request = [[NSMutableURLRequest alloc] init];
        self.request.timeoutInterval = 10;
        
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    return self;
}

- (void)loginWithKey:(NSString *)key password:(NSString *)passwd {
    [self.request setURL:[self makeURLWithService:@"api/v1/login"]];
    [self.request setHTTPMethod:@"POST"];
    
    NSDictionary * dict = @{@"user": @{@"key": key, @"password": passwd}};
    
    [self.request setHTTPBody:[self makeJSONWithDictionary:dict]];
    
    [self send];
}

- (void)createUser:(NSDictionary *)dict {
    [self.request setURL:[self makeURLWithService:@"api/v1/users"]];
    [self.request setHTTPMethod:@"POST"];
    
    [self.request setHTTPBody:[self makeJSONWithDictionary:dict]];
    
    [self send];
}

- (void)getCourses {
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:@"api/v1/courses"]];
    [self.request setHTTPMethod:@"GET"];
    
    [self send];
}

- (void)getNotesForCourse:(NSInteger)course {
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    NSLog(@"URL: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]);
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/courses/%ld/notes", (long)course]]];
    [self.request setHTTPMethod:@"GET"];
    
    [self send];
}

- (void)createCourse:(NSDictionary *)dict {
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:@"api/v1/courses"]];
    [self.request setHTTPMethod:@"POST"];
    
    [self.request setHTTPBody:[self makeJSONWithDictionary:dict]];
    
    [self send];
}

- (void)createNoteForCourse:(NSInteger)course withTitle:(NSString *)title pattern: (NSString *)pattern {
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/courses/%ld/notes", (long)course]]];
    
    [self.request setHTTPMethod:@"POST"];
    
    
    [self.request setHTTPBody:[self makeJSONWithDictionary:@{
                                                             @"note": @{
                                                                     @"title": title,
                                           @"pattern": pattern,
                                            @"words": @""
                                                                     }
                                                             }]];
    
    [self send];
}

- (void)updateNote:(NSDictionary *)dict noteID: (NSInteger) id_note courseID: (NSInteger) id_course{
    
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/courses/%ld/notes/%ld", (long)id_course, (long)id_note]]];
    
    [self.request setHTTPMethod:@"PUT"];
    
    
    [self.request setHTTPBody:[self makeJSONWithDictionary:dict]];
    [self send];
}

- (void) updateUser:(NSDictionary *)dict{
    
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/users/%ld", (long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] integerValue]]]];
    
    [self.request setHTTPMethod:@"PATCH"];
    
    
    [self.request setHTTPBody:[self makeJSONWithDictionary:dict]];
    
    [self send];
}

- (void)searchNotes:(NSString *)searchPattern{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/notes?search=%@", searchPattern]]];
    
    [self.request setHTTPMethod:@"GET"];
    
    [self send];
}

- (void)createSharedNotes:(NSString *) id_note id_user: (NSString *) id_user{
    
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/shares"]]];
    [self.request setHTTPBody:[self makeJSONWithDictionary: @{
                                                             @"share":
                                                                 @{
                                                                     @"user_id": id_user,
                                                                     @"note_id": id_note
                                                                     }
                                                             }]];
    
    [self.request setHTTPMethod:@"POST"];
    
    [self send];
}

- (void) getNoteById:(NSInteger) id_note{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/notes/%ld", (long)id_note]]];
    
    [self.request setHTTPMethod:@"GET"];
    
    [self send];
}

-(void)getShareNote{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/shares"]]];
    [self.request setHTTPMethod:@"GET"];
    
    [self send];
}

-(void) setPrivate:(NSInteger) id_note id_course:(NSInteger)id_course{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/courses/%ld/notes/%ld", (long)id_course, (long)id_note]]];
    
    [self.request setHTTPMethod:@"PUT"];
    
    
    [self.request setHTTPBody:[self makeJSONWithDictionary:@{
                                                             @"note":@{
                                                                     @"tags":@"",
                                                                     @"published":@false
                                                                     }
                                                             }
                               
                               ]];
    
    [self send];

}

- (void) updateTagsByNoteId:(NSInteger) id_note tags:(NSString *) tags id_course:(NSInteger) id_course{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/courses/%ld/notes/%ld", (long)id_course, (long)id_note]]];
    
    [self.request setHTTPMethod:@"PUT"];
    
    
    [self.request setHTTPBody:[self makeJSONWithDictionary:@{
                                                             @"note":@{
                                                                     @"tags":tags,
                                                                @"published":@true
                                                                     }
    }
                                                             
                                                             ]];
    
    [self send];
}


-(void)getUserIdByUsername:(NSString *) username{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/users/usertoid/%@", username]]];
    [self.request setHTTPMethod:@"GET"];
    
    [self send];

}

-(void)getReminders{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/reminders"]]];
    
    [self.request setHTTPMethod:@"GET"];
    
    [self send];
}

-(void) deleteReminderById: (NSInteger) reminder_id{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/reminders/%ld", (long)reminder_id]]];
    
    [self.request setHTTPMethod:@"DELETE"];
    [self send];
    
}

-(void)updateReminderState:(Boolean)state id_reminder: (NSInteger) id_reminder{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/reminders/%ld", (long)id_reminder]]];
    
    [self.request setHTTPMethod:@"PUT"];
    
    if (!state) {
        [self.request setHTTPBody:[self makeJSONWithDictionary:@{
                                                                 @"reminder":@{
                                                                         @"done":@false
                                                                         }
                                                                 }
                                   
                                   ]];
        
        [self send];
    }else{
        [self.request setHTTPBody:[self makeJSONWithDictionary:@{
                                                                 @"reminder":@{
                                                                         @"done":@true
                                                                         }
                                                                 }
                                   
                                   ]];
        
        [self send];
    }
    
    

}
#pragma mark - Metodos privados de la clase

- (NSData *)makeJSONWithDictionary:(NSDictionary *)dict {
    return [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
}

- (NSURL *)makeURLWithService:(NSString *)service {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@", ADDRESS, service]];
}



- (void)authorize {
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@", self.auth] forHTTPHeaderField:@"Authorization"];
}

-(void) createReminder: (NSString *) title deadline: (NSString *) deadline{
    [self.request setValue:[NSString stringWithFormat:@"Token token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    
    [self.request setURL:[self makeURLWithService:[NSString stringWithFormat: @"api/v1/reminders"]]];
    [self.request setHTTPBody:[self makeJSONWithDictionary: @{
                                                              @"reminder":
                                                                  @{
                                                                      
                                                                      @"title": title,
                                                                      @"deadline": deadline
                                                                      }
                                                              }]];
    
    [self.request setHTTPMethod:@"POST"];
    
    [self send];
}


- (void)send {
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:self.request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
             NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
            
            
            NSDictionary * auth;
            
            @try {
                if ((auth = [dict objectForKey:@"auth"]) != nil) {
                    NSString * token = [auth objectForKey:@"token"];
                    
                    NSDateFormatter *lt = [[NSDateFormatter alloc] init];
                    [lt setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZ"];
                    
                    NSString *lifetime = [auth objectForKey:@"expires"];
                    NSString *username = [[dict objectForKey:@"user"] objectForKey:@"username"];
                    
                    NSLog(@"%@", username);
                    
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[dict objectForKey:@"user"] objectForKey:@"email"] forKey:@"email"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[dict objectForKey:@"user"] objectForKey:@"id"] forKey:@"user_id"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:lifetime forKey:@"lifetime"];
                }
            }
            @catch (NSException *exception) { }
            @finally { }
            
            if ([self.delegate respondsToSelector:@selector(communication:didReceiveData:)]) {
                
                [self.delegate communication:self didReceiveData:dict];
            }
        }
        
       
        
        
    }];
}

@end
