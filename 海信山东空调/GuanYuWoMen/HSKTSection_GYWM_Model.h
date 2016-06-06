//
//  HSKTSection_GYWM_Model.h
//  海信山东空调
//
//  Created by Sun on 16/3/21.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSKTSection_GYWM_Model : NSObject

/** section头标题 */
@property (nonatomic,copy)NSString *headTitle;

/** 内容数组 */
@property (nonatomic,strong)NSArray *labels;
/** 是否隐藏 */
@property (nonatomic,assign,getter=isHidden) BOOL hidden;


@end
