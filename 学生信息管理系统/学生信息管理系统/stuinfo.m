//
//  stuinfo.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/24.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "stuinfo.h"

@implementation stuinfo

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.idtmp forKey:@"id"];
    [encoder encodeObject:self.passwdtmp forKey:@"passwd"];
    [encoder encodeObject:self.nametmp forKey:@"name"];
    [encoder encodeObject:self.sextmp forKey:@"sex"];
    [encoder encodeObject:self.agetmp forKey:@"age"];
    [encoder encodeObject:self.teltmp forKey:@"tel"];
    [encoder encodeObject:self.addresstmp forKey:@"address"];
}


- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.idtmp = [decoder decodeObjectForKey:@"id"];
        self.passwdtmp = [decoder decodeObjectForKey:@"passwd"];
        self.nametmp = [decoder decodeObjectForKey:@"name"];
        self.sextmp = [decoder decodeObjectForKey:@"sex"];
        self.agetmp = [decoder decodeObjectForKey:@"age"];
        self.teltmp = [decoder decodeObjectForKey:@"tel"];
        self.addresstmp = [decoder decodeObjectForKey:@"address"];
    }
    return self;
}


@end

