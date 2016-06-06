//
//  Utils.m
//  海信山东空调
//
//  Created by Sun on 16/3/15.
//  Copyright © 2016年 kedauis. All rights reserved.
//

// NSUserDefaults存和取数据
#import "Utils.h"

@implementation Utils


// 保存数据(KV键值对)
+ (void)saveValue:(nullable id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 获取数据
+ (id)getValueFormKey:(NSString *)key
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


@end
