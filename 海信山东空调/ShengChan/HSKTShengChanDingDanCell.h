//
//  HSKTShengChanDingDanCell.h
//  海信山东空调
//
//  Created by Sun on 16/3/24.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSKTShengChanList;

@interface HSKTShengChanDingDanCell : UITableViewCell

+(instancetype)labelCellWithTableView:(UITableView *)tableView data:(HSKTShengChanList *)data;

@end
