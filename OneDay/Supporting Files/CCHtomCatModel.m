//
//  CCHtomCatModel.m
//  01-tomCat
//
//  Created by cc on 16/1/15.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "CCHtomCatModel.h"

@implementation CCHtomCatModel
-(instancetype) initWithDictionary:(NSDictionary *) dic
{
    if (self= [super init]) {
        self.name=dic[@"imageName"];
        self.count=[dic[@"frames"] integerValue];
        self.sound=dic[@"soundFiles"][0];
    }
    return self;
}
+(instancetype) tomCatWithDictionary:(NSDictionary *) dic
{
    return [[self alloc] initWithDictionary:dic];
}

@end
