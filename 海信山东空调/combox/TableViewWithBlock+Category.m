//
//  TableViewWithBlock+Category.m
//  LGHG
//
//  Created by 贺俊孟 on 15/10/21.
//  Copyright © 2015年 zxx. All rights reserved.
//

#import "TableViewWithBlock+Category.h"
#define DeviceHeight  [UIScreen mainScreen].bounds.size.height

@implementation TableViewWithBlock (Category)

/**
参数： rectInMainView：  选中的View在 主view 中的frame
pickArray :      下拉框中显示的数据
setDidSelectRowBlock: 选中后的block
 rectInMainView.origin.x-rectInMainView.size.width/2-8
*/
+(TableViewWithBlock*)getXiaLaKuang:(CGRect)rectInMainView setPickArray:(NSArray*)pickArray setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock{
    CGFloat height = pickArray.count >= 4 ? 4*44 : pickArray.count * 44;
    int offsit =rectInMainView.origin.y+rectInMainView.size.height +height - DeviceHeight;
    if (offsit>0) {
        CGRect rect = CGRectMake(rectInMainView.origin.x, rectInMainView.origin.y-height, rectInMainView.size.width, rectInMainView.size.height);
        rectInMainView =  rect;
    }
    
    TableViewWithBlock *tbWithBlock=[[TableViewWithBlock alloc]initWithFrame:CGRectMake(
                                                            rectInMainView.origin.x,
                                                            rectInMainView.origin.y + rectInMainView.size.height+10,
                                                            rectInMainView.size.width, height)
                                                         ];
    [tbWithBlock    initTableViewDataSourceAndDelegate:
                         ^NSInteger (UITableView *tableView,NSInteger section){
                             return pickArray.count;
                         }
                    setCellForIndexPathBlock:
                     ^(UITableView *tableView,NSIndexPath *indexPath){
                         SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
                         if (!cell) {
                             cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
                             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
                         }
                         [cell.lb setText:[pickArray[indexPath.row] valueForKey:@"XIanTiMingCheng"]];
                         return cell;
                     }
                    setDidSelectRowBlock:didSelectRowBlock];
    //tbWithBlock.rowHeight = 200;
    [tbWithBlock.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [tbWithBlock.layer setBorderWidth:0.5];
    tbWithBlock.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    return tbWithBlock;
}

@end
