//
//  CommunicationManager.h
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 10/2/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ADDRESS @"162.243.159.78"

@class CommunicationManager;
@protocol CommunicationDelegate <NSObject>
@optional
- (void)communication:(CommunicationManager *)comm didReceiveData:(NSDictionary *)dict;
@end

@interface CommunicationManager : NSObject
@property (nonatomic, weak) id<CommunicationDelegate> delegate;
@property (nonatomic, strong) NSMutableURLRequest * request;
@property (nonatomic, strong, readonly) NSString * auth;
@property (nonatomic, strong, readonly) NSDate * expires;

- (void)loginWithKey:(NSString *)key password:(NSString *)passwd;
- (void)createUser:(NSDictionary *)dict;

@end
