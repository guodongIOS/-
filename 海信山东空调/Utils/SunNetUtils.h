//
//  SunNetUtils.h
//  海信山东空调
//
//  Created by Sun on 16/4/11.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SunNetUtils : NSObject

+ (void)get:(NSString *)url params:(id)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


@end
