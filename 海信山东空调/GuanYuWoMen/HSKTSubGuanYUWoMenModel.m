//
//  HSKTGuanYUWoMenModel.m
//  海信山东空调
//
//  Created by Sun on 16/3/21.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTSubGuanYUWoMenModel.h"
#import "MJExtension.h"

@implementation HSKTSubGuanYUWoMenModel

-(void)setContent:(NSString *)content
{
    _content=[content copy];
    NSDictionary *attributes=@{
                               NSFontAttributeName:[UIFont systemFontOfSize:15]
                               };
    [content sizeWithAttributes:attributes];
    CGSize size=CGSizeMake(DeviceWidth-10, MAXFLOAT);
    CGRect rec=[content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    _height=rec.size.height + 5;
}

@end
