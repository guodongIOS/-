//
//  HSKTShengChanList.h
//  海信山东空调
//
//  Created by Sun on 16/3/25.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSKTShengChanList : NSObject
/**
 *  产品名称
 */
@property (nonatomic,copy)NSString *ChanPinMingCheng;
/**
 *  生产线体
 */
@property (nonatomic,copy)NSString *ShengChanXianTi;
/**
 *  生产订单
 */
@property (nonatomic,copy)NSString *ShengChanDingDan;
/**
 *  生产状态
 */
@property (nonatomic,copy)NSString *ShengChanZhuangTai;
/**
 *  计划数
 */
@property (nonatomic,copy)NSString *JiHuaShuLiang;
/**
 *  生产数
 */
@property (nonatomic,copy)NSString *YiShengChanShuLiang;
/**
 *  合格数
 */
@property (nonatomic,copy)NSString *HeGeShuLiang;
/**
 *  完工数
 */
@property (nonatomic,copy)NSString *SAPWanGongShuLiang;
/**
 *  移库数
 */
@property (nonatomic,copy)NSString *SAPYiKuShuLiang;
/**
 *  高度
 */
@property (nonatomic,assign) CGFloat height;


@end
