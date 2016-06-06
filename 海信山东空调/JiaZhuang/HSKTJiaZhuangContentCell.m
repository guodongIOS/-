//
//  HSKTJiaZhuangContentCell.m
//  海信山东空调
//
//  Created by Sun on 16/3/23.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTJiaZhuangContentCell.h"
#import "HSKTJiaZhuangList.h"

@interface HSKTJiaZhuangContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *xianTiMingCheng;
@property (weak, nonatomic) IBOutlet UILabel *xiaoShiQuJian;
@property (weak, nonatomic) IBOutlet UILabel *jiHuaChanLiang;

@property (weak, nonatomic) IBOutlet UILabel *shiShiChanLiang;
@property (weak, nonatomic) IBOutlet UILabel *jiHuaHeJi;
@property (weak, nonatomic) IBOutlet UILabel *shiJiHeJi;
@property (weak, nonatomic) IBOutlet UILabel *heJiWanChengLv;
@property (nonatomic,strong)HSKTJiaZhuangList *data;

@end

@implementation HSKTJiaZhuangContentCell

+(instancetype)labelCellWithTableView:(UITableView *)tableView data:(HSKTJiaZhuangList *)data
{
    static NSString *identi = @"HSKTJiaZhuangContentCell";
    HSKTJiaZhuangContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    cell.data = data;
    return cell;
}

-(void)setData:(HSKTJiaZhuangList *)data
{
    _data = data;
    _xianTiMingCheng.text = _data.XianTiBianHao;
    _xiaoShiQuJian.text = _data.XiaoShiQuJian;
    _jiHuaChanLiang.text = _data.JiHuaChanLiang;
    _shiShiChanLiang.text = _data.ShiJiChanLiang;
    _jiHuaHeJi.text = _data.JiHuaHeJi;
    _shiJiHeJi.text = _data.ShiJiHeJi;
    _heJiWanChengLv.text = _data.HeJiWanChengLv;
}


@end
