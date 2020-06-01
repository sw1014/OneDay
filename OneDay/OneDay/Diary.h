//
//  Diary.h
//  OneDay
//
//  Created by sw on 2020/4/29.
//  Copyright © 2020年 sw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diary : NSObject
@property(nonatomic)NSString *user_phone;
@property(nonatomic)NSString *title;
@property(nonatomic)NSString *date;
@property(nonatomic)NSString *weather;
@property(nonatomic)NSString *mood;
@property(nonatomic)NSString *event;
@property(nonatomic)NSString *picture;
@property(nonatomic)NSString *draft;
@property(nonatomic)NSString *content;

@property(nonatomic)NSString *idnumber;
-(id)initWithUserphone:(NSString *)user_phone Pic:(NSString *)picture Date:(NSString *)date Title:(NSString *)title Weather:(NSString *)weather Mood:(NSString *)mood Event:(NSString *)event Draft:(NSString *)draft Content:(NSString *)content Id:(NSString *)idnumber;
@end
