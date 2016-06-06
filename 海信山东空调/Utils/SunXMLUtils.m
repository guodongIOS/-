//
//  WSXMLUtils.m
//  Sun
//
//  Created by Sun on 16/3/14.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "SunXMLUtils.h"
#import "GDataXMLNode.h"
#import "JSONKit.h"

@implementation SunXMLUtils

+ (NSDictionary *)parserXMLWithData:(NSData *)data
{
    GDataXMLDocument *_document = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *_element = _document.rootElement;
    return [_element.stringValue objectFromJSONString];
}

@end
