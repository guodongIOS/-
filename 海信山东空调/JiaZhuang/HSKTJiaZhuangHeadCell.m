//
//  HSKTJiaZhuangHeadCell.m
//  海信山东空调
//
//  Created by Sun on 16/3/23.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTJiaZhuangHeadCell.h"

@implementation HSKTJiaZhuangHeadCell

+(instancetype)labelCellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"HSKTJiaZhuangHeadCell";
    HSKTJiaZhuangHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    return cell;
}


@end
