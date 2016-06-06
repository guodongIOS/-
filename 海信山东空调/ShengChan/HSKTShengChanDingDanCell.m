//
//  HSKTShengChanDingDanCell.m
//  海信山东空调
//
//  Created by Sun on 16/3/24.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTShengChanDingDanCell.h"
#import "HSKTShengChanList.h"

@interface HSKTShengChanDingDanCell ()
@property (weak, nonatomic) IBOutlet UILabel *chanPingMingCheng;
@property (weak, nonatomic) IBOutlet UILabel *shengChanXianTi;
@property (weak, nonatomic) IBOutlet UILabel *shengChanDingDan;
@property (weak, nonatomic) IBOutlet UILabel *shengChanZhuangTai;
@property (weak, nonatomic) IBOutlet UILabel *jiHuaShu;
@property (weak, nonatomic) IBOutlet UILabel *shengChanShu;
@property (weak, nonatomic) IBOutlet UILabel *heGeShu;
@property (weak, nonatomic) IBOutlet UILabel *wanGongShu;
@property (weak, nonatomic) IBOutlet UILabel *yiKuShu;
@property (nonatomic,strong)HSKTShengChanList *data;
@end


@implementation HSKTShengChanDingDanCell


+(instancetype)labelCellWithTableView:(UITableView *)tableView data:(HSKTShengChanList *)data
{
    static NSString *dentifier = @"HSKTShengChanDingDanCell";
    HSKTShengChanDingDanCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    cell.data = data;
    return cell;
}


-(void)setData:(HSKTShengChanList *)data
{
    _data = data;
    _chanPingMingCheng.text = _data.ChanPinMingCheng;
    _shengChanXianTi.text = _data.ShengChanXianTi;
    _shengChanDingDan.text = _data.ShengChanDingDan;
    _shengChanZhuangTai.text = _data.ShengChanZhuangTai;
    _jiHuaShu.text = _data.JiHuaShuLiang;
    _shengChanShu.text = _data.YiShengChanShuLiang;
    _heGeShu.text = _data.HeGeShuLiang;
    _wanGongShu.text = _data.SAPWanGongShuLiang;
    _yiKuShu.text = _data.SAPYiKuShuLiang;
}

@end
