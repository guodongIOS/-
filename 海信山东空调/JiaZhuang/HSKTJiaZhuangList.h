//
//  HSKTJiaZhuangList.h
//  海信山东空调
//
//  Created by Sun on 16/3/23.
//  Copyright © 2016年 kedauis. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface HSKTJiaZhuangList : NSObject
/**
 *  线体编号
 */
@property (nonatomic,copy)NSString *XianTiBianHao;
/**
 *  线体名称
 */
@property (nonatomic,copy)NSString *XianTiMingCheng;
/**
 *  小时
 */
@property (nonatomic,copy)NSString *Hour;
/**
 *  计划产量
 */
@property (nonatomic,copy)NSString *JiHuaChanLiang;
/**
 *  小时区间
 */
@property (nonatomic,copy)NSString *XiaoShiQuJian;
/**
 *  实际产量
 */
@property (nonatomic,copy)NSString *ShiJiChanLiang;
/**
 *  计划合计
 */
@property (nonatomic,copy)NSString *JiHuaHeJi;
/**
 *  实际合计
 */
@property (nonatomic,copy)NSString *ShiJiHeJi;
/**
 *  合计完成率
 */
@property (nonatomic,copy)NSString *HeJiWanChengLv;

@end
