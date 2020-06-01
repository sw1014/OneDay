//
//  User.h
//  OneDay
//
//  Created by sw on 2020/5/6.
//  Copyright © 2020年 sw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *email;

@end
