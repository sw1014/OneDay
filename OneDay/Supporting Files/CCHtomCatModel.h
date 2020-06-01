//
//  CCHtomCatModel.h
//  01-tomCat
//
//  Created by cc on 16/1/15.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCHtomCatModel : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic , assign) NSInteger count;
@property (nonatomic,copy) NSString *  sound;

-(instancetype) initWithDictionary:(NSDictionary *) dic;
+(instancetype) tomCatWithDictionary:(NSDictionary *) dic;
@end
