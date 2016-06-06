//
//  HSKTShengChanList.m
//  海信山东空调
//
//  Created by Sun on 16/3/25.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTShengChanList.h"

@implementation HSKTShengChanList


-(void)setChanPinMingCheng:(NSString *)ChanPinMingCheng
{
    _ChanPinMingCheng = [ChanPinMingCheng copy];
    NSDictionary *attributes=@{
                               NSFontAttributeName:[UIFont systemFontOfSize:14]
                               };
    [ChanPinMingCheng sizeWithAttributes:attributes];
    CGSize size=CGSizeMake(139, MAXFLOAT);
    CGRect rec=[ChanPinMingCheng boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    _height=rec.size.height + 5;
}

@end
