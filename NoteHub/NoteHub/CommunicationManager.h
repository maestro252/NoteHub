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
@property (nonatomic) NSInteger tag;

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
- (void) getNoteById:(NSInteger) id_note;
- (void) updateTagsByNoteId:(NSInteger) id_note tags:(NSString *) tags id_course:(NSInteger) id_course;
-(void) setPrivate:(NSInteger) id_note id_course:(NSInteger)id_course;
-(void) getShareNote;
-(void)getUserIdByUsername:(NSString *) username;
-(void) createReminder: (NSString *) title deadline: (NSString *) deadline;
-(void)getReminders;
-(void)updateReminderState:(Boolean)state id_reminder: (NSInteger) id_reminder;
-(void) deleteReminderById: (NSInteger) reminder_id;
-(void)createSchedule: (NSString *)id_course weekday: (NSString *) weekday time: (NSString *) time classroom: (NSString *) classroom;
- (void)getWeekdays:(NSInteger)id_course;
- (void)addFriendByUsername: (NSInteger) id_user username: (NSString *) username;
- (void)getFriendsPublished;
-(void)createGroup: (NSString *) title;
-(void)getGroups;



@end
