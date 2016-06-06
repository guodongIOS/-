//
//  WSXMLUtils.h
//  Sun
//
//  Created by Sun on 16/3/14.
//  Copyright © 2016年 kedauis. All rights reserved.
//

/**
 使用GDataXMLNode解析访问Webservice返回的xml数据
 */
#import <Foundation/Foundation.h>

@interface SunXMLUtils : NSObject

+ (NSDictionary *)parserXMLWithData:(NSData *)data;

@end
