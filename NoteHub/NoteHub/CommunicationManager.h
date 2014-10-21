//
//  CommunicationManager.h
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 10/2/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ADDRESS @"localhost:3000"

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
- (void)createCourse:(NSDictionary *)dict;
- (void)getCourses;
- (void)getNotesForCourse:(NSInteger)course;
- (void)createNoteForCourse:(NSInteger)course withTitle:(NSString *)title pattern: (NSString *)pattern;
- (void) updateUser:(NSDictionary *)dict;
- (void)updateNote:(NSDictionary *)dict noteID: (NSInteger) id_note courseID: (NSInteger) id_course;
- (void)searchNotes: (NSString *) searchPattern;
- (void)createSharedNotes:(NSString *) id_note id_user: (NSString *) id_user;

@end
