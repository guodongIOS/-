//
//  HSKTJiaZhuangContentCell.h
//  海信山东空调
//
//  Created by Sun on 16/3/23.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSKTJiaZhuangList;

@interface HSKTJiaZhuangContentCell : UITableViewCell


+(instancetype)labelCellWithTableView:(UITableView *)tableView data:(HSKTJiaZhuangList *)data;

@end
