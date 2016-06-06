//
//  HSKTLabelCell.m
//  海信山东空调
//
//  Created by Sun on 16/3/21.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTLabelCell.h"

@interface HSKTLabelCell ()


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation HSKTLabelCell

+(instancetype)labelCellWithTableView:(UITableView *)tableView content:(NSString *)content
{
    static NSString *identi = @"HSKTLabelCell";
    HSKTLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    cell.contentLabel.text = content;
    return cell;
}

@end
