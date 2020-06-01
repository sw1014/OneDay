//
//  Diary.m
//  OneDay
//
//  Created by sw on 2020/4/29.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "Diary.h"

@implementation Diary
-(id)initWithUserphone:(NSString *)user_phone Pic:(NSString *)picture Date:(NSString *)date Title:(NSString *)title Weather:(NSString *)weather Mood:(NSString *)mood Event:(NSString *)event Draft:(NSString *)draft Content:(NSString *)content Id:(NSString *)idnumber
{
    self=[super init];
    if (self)
    {
        self.weather=weather;
        self.user_phone=user_phone;
        self.picture=picture;
        self.date=date;
        self.title=title;
        self.mood=mood;
        self.event=event;
        self.draft=draft;
        self.content=content;
        self.idnumber=idnumber;
        
    }
    return self;
}
@end
