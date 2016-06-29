//
//  stuinfo.h
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/24.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stuinfo : NSObject <NSCoding>

@property (nonatomic, copy) NSString *idtmp;
@property (nonatomic, copy) NSString *passwdtmp;
@property (nonatomic, copy) NSString *nametmp;
@property (nonatomic, copy) NSString *sextmp;
@property (nonatomic, copy) NSString *agetmp;
@property (nonatomic, copy) NSString *teltmp;
@property (nonatomic, copy) NSString *addresstmp;


@end
