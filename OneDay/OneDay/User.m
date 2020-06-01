//
//  User.m
//  OneDay
//
//  Created by sw on 2020/5/6.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "User.h"

@implementation User
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self)
    {
        _phone=[aDecoder decodeObjectForKey:@"phone"];
        _password=[aDecoder decodeObjectForKey:@"password"];
        _username=[aDecoder decodeObjectForKey:@"username"];
        _photo=[aDecoder decodeObjectForKey:@"photo"];
        _email=[aDecoder decodeObjectForKey:@"email"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.email forKey:@"email"];
}
@end
