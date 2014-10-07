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
                    
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[auth objectForKey:@"user"] objectForKey:@"username"] forKey:@"username"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[auth objectForKey:@"user"] objectForKey:@"email"] forKey:@"email"];
                    
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
