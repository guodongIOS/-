//
//  TableViewWithBlock+Category.h
//  LGHG
//
//  Created by 贺俊孟 on 15/10/21.
//  Copyright © 2015年 zxx. All rights reserved.
//

#import "TableViewWithBlock.h"
#import "SelectionCell.h"


@interface TableViewWithBlock (Category)
+(TableViewWithBlock*)getXiaLaKuang:(CGRect)rectInMainView setPickArray:(NSArray*)pickArray setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock;

@end
