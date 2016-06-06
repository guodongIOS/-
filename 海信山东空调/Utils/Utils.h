//
//  Utils.h
//  海信山东空调
//
//  Created by Sun on 16/3/15.
//  Copyright © 2016年 kedauis. All rights reserved.
//

// NSUserDefaults存和取数据
#import <Foundation/Foundation.h>

@interface Utils : NSObject

// 保存数据(KV键值对)
+ (void)saveValue:(NSObject *)value forKey:(NSString *)key;

// 获取数据
+ (id)getValueFormKey:(NSString *)key;

@end
