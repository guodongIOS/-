//
//  HSKTSection_GYWM_Model.m
//  海信山东空调
//
//  Created by Sun on 16/3/21.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTSection_GYWM_Model.h"
#import "MJExtension.h"
#import "HSKTSubGuanYUWoMenModel.h"

@implementation HSKTSection_GYWM_Model

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"labels": [HSKTSubGuanYUWoMenModel class]
             };
}

@end
