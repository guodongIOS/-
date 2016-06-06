//
//  HSKTHeadImageCell.m
//  海信山东空调
//
//  Created by Sun on 16/3/21.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTHeadImageCell.h"

@interface HSKTHeadImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation HSKTHeadImageCell

+(instancetype)ImageCellWithTableView:(UITableView *)tableView content:(NSString *)content
{
    static NSString *identi = @"HSKTHeadImageCell";
    HSKTHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    cell.image.image = [UIImage imageNamed:content];
    return cell;
}

@end
