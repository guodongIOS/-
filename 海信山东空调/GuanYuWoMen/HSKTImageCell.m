//
//  HSKTImageCell.m
//  海信山东空调
//
//  Created by Sun on 16/3/22.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTImageCell.h"

@interface HSKTImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgMid;
@property (weak, nonatomic) IBOutlet UIImageView *imgRight;
@end

@implementation HSKTImageCell

+(instancetype)ImageCellWithTableView:(UITableView *)tableView content:(NSString *)content
{
    static NSString *identi = @"HSKTImageCell";
    HSKTImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    NSArray *array = [content componentsSeparatedByString:@","];
    [cell.imgLeft setImage:[UIImage imageNamed:array[0]]];
    [cell.imgMid setImage:[UIImage imageNamed:array[1]]];
    [cell.imgRight setImage:[UIImage imageNamed:array[2]]];
    return cell;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
