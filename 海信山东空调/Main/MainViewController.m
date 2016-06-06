//
//  MainViewController.m
//  海信山东空调
//
//  Created by Sun on 16/3/17.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "MainViewController.h"
#import "SDCycleScrollView.h"
#import "UIViewExt.h"
#import "UIImage-Helpers.h"
#import "HSKTLianXiWoMenVC.h"
#import "HSKTGuanYUWoMenTVC.h"
#import "HSKTJiaZhuangController.h"
#import "HSKTShengChanDingDanViewController.h"

@interface MainViewController ()
{
    SDCycleScrollView *_scrollView;
    UIButton *_jiaZhuangBtn;
    UIButton *_shangKongBtn;
    UIButton *_shengChanBtn;
    UIButton *_guanYuBtn;
    UIButton *_lianXiBtn;
}

@end

@implementation MainViewController

- (void)loadView
{
    [super loadView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 85, 40)];
    title.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    title.text = @"海信(浙江)空调生产管理系统";
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [title adjustsFontSizeToFitWidth];
    [self.navigationItem setTitleView:title];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.004 green:0.651 blue:0.659 alpha:1];
    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    // 导航栏（navigationbar)
    CGRect rectNav = self.navigationController.navigationBar.frame;
    // 计算SctollView的Y坐标
    CGFloat y = rectStatus.size.height + rectNav.size.height;
    // 图片数组
    NSArray *imgs = @[[UIImage imageNamed:@"tu-04"], [UIImage imageNamed:@"tu_02"], [UIImage imageNamed:@"tu_01"]];
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, y, DeviceWidth, DeviceHeight / 3.5) imageNamesGroup:imgs];
    _scrollView.autoScrollTimeInterval = 3.0f;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_scrollView];
    
    CGFloat width = (DeviceWidth - 30) / 2;
    CGFloat height = (DeviceHeight - _scrollView.bounds.size.height - y - 40) / 3;
    
    // 家装小时产量
    _jiaZhuangBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _scrollView.bottom + 10, width, height)];
    UIImage *jiaNormalImg = [UIImage imageWithColor:UIColorFromHex(0x00aead)];
    UIImage *jiaHighImg = [UIImage imageWithColor:UIColorFromHex(0x009190)];
    [_jiaZhuangBtn setBackgroundImage:jiaNormalImg forState:UIControlStateNormal];
    [_jiaZhuangBtn setBackgroundImage:jiaHighImg forState:UIControlStateHighlighted];
    [_jiaZhuangBtn setImage:[UIImage imageNamed:@"neiJi"] forState:UIControlStateNormal];
    [_jiaZhuangBtn setImage:[UIImage imageNamed:@"neiJi"] forState:UIControlStateHighlighted];
    [_jiaZhuangBtn addTarget:self action:@selector(JiaZhuang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_jiaZhuangBtn];
    
    // 商空小时产量
    _shangKongBtn = [[UIButton alloc] initWithFrame:CGRectMake(_jiaZhuangBtn.right + 10, _jiaZhuangBtn.top, width, height)];
    UIImage *shangNormalImg = [UIImage imageWithColor:UIColorFromHex(0xfa6800)];
    UIImage *shangHighImg = [UIImage imageWithColor:UIColorFromHex(0xf84500)];
    [_shangKongBtn setBackgroundImage:shangNormalImg forState:UIControlStateNormal];
    [_shangKongBtn setBackgroundImage:shangHighImg forState:UIControlStateHighlighted];
    [_shangKongBtn setImage:[UIImage imageNamed:@"waiJi"] forState:UIControlStateNormal];
    [_shangKongBtn setImage:[UIImage imageNamed:@"waiJi"] forState:UIControlStateHighlighted];
    [_shangKongBtn addTarget:self action:@selector(ShangKong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shangKongBtn];
    
    // 生产订单
    _shengChanBtn = [[UIButton alloc] initWithFrame:CGRectMake(_jiaZhuangBtn.left, _jiaZhuangBtn.bottom + 10, width, height)];
    UIImage *shengNormalImg = [UIImage imageWithColor:UIColorFromHex(0xe76472)];
    UIImage *shengHighImg = [UIImage imageWithColor:UIColorFromHex(0xdd3e4b)];
    [_shengChanBtn setBackgroundImage:shengNormalImg forState:UIControlStateNormal];
    [_shengChanBtn setBackgroundImage:shengHighImg forState:UIControlStateHighlighted];
    [_shengChanBtn setImage:[UIImage imageNamed:@"DingDan"] forState:UIControlStateNormal];
    [_shengChanBtn setImage:[UIImage imageNamed:@"DingDan"] forState:UIControlStateHighlighted];
    [_shengChanBtn addTarget:self action:@selector(ShengChan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shengChanBtn];
    
    // 关于我们
    _guanYuBtn = [[UIButton alloc] initWithFrame:CGRectMake(_shangKongBtn.left, _shangKongBtn.bottom + 10, width, height)];
    UIImage *guanNormalImg = [UIImage imageWithColor:UIColorFromHex(0xa940ff)];
    UIImage *guanHighImg = [UIImage imageWithColor:UIColorFromHex(0x881eff)];
    [_guanYuBtn setBackgroundImage:guanNormalImg forState:UIControlStateNormal];
    [_guanYuBtn setBackgroundImage:guanHighImg forState:UIControlStateHighlighted];
    [_guanYuBtn setImage:[UIImage imageNamed:@"GuanYuWoMen"] forState:UIControlStateNormal];
    [_guanYuBtn setImage:[UIImage imageNamed:@"GuanYuWoMen"] forState:UIControlStateHighlighted];
    [_guanYuBtn addTarget:self action:@selector(GuanYuWoMen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_guanYuBtn];
    
    // 联系我们
    _lianXiBtn = [[UIButton alloc] initWithFrame:CGRectMake(_shengChanBtn.left, _shengChanBtn.bottom + 10, width, height)];
    UIImage *lianNormalImg = [UIImage imageWithColor:UIColorFromHex(0x91d100)];
    UIImage *lianHighImg = [UIImage imageWithColor:UIColorFromHex(0x329e00)];
    [_lianXiBtn setBackgroundImage:lianNormalImg forState:UIControlStateNormal];
    [_lianXiBtn setBackgroundImage:lianHighImg forState:UIControlStateHighlighted];
    [_lianXiBtn setImage:[UIImage imageNamed:@"LianXiWoMen"] forState:UIControlStateNormal];
    [_lianXiBtn setImage:[UIImage imageNamed:@"LianXiWoMen"] forState:UIControlStateHighlighted];
    [_lianXiBtn addTarget:self action:@selector(LianXiWoMen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lianXiBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - action
- (void)LianXiWoMen
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"LianXiWoMen" bundle:nil];
    HSKTLianXiWoMenVC *wvc = [board instantiateViewControllerWithIdentifier:@"HSKTLianXiWoMenVC"];
    [self.navigationController pushViewController:wvc animated:YES];
    // 开启iOS7以上的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)GuanYuWoMen
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"GuanYuWoMen" bundle:nil];
    HSKTGuanYUWoMenTVC *_lvc=[board instantiateViewControllerWithIdentifier:@"HSKTGuanYUWoMenTVC"];
    [self.navigationController pushViewController:_lvc animated:YES];
    // 开启iOS7以上的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }

}

- (void)JiaZhuang
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"JiaZhuang" bundle:nil];
    HSKTJiaZhuangController *_lvc=[board instantiateViewControllerWithIdentifier:@"HSKTJiaZhuangController"];
    _lvc.barTitle = @"内机";
    _lvc.url = @"NJ";
    [self.navigationController pushViewController:_lvc animated:YES];
    // 开启iOS7以上的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)ShangKong
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"JiaZhuang" bundle:nil];
    HSKTJiaZhuangController *_lvc=[board instantiateViewControllerWithIdentifier:@"HSKTJiaZhuangController"];
    _lvc.barTitle = @"外机";
    _lvc.url = @"WJ";
    [self.navigationController pushViewController:_lvc animated:YES];
    // 开启iOS7以上的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)ShengChan
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"ShengChanDingDan" bundle:nil];
    HSKTShengChanDingDanViewController *_lvc=[board instantiateViewControllerWithIdentifier:@"HSKTShengChanDingDanViewController"];
    _lvc.barTitle = @"生产订单";
    [self.navigationController pushViewController:_lvc animated:YES];
    // 关闭iOS7以上的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}

@end
