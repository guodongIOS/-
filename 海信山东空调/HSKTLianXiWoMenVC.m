//
//  HSKTLianXiWoMenVC.m
//  海信山东空调
//
//  Created by Sun on 16/3/22.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTLianXiWoMenVC.h"

@interface HSKTLianXiWoMenVC ()

@end

@implementation HSKTLianXiWoMenVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 85, 40)];
    
    title.text = @"联系我们";
    title.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [title adjustsFontSizeToFitWidth];
    [self.navigationItem setTitleView:title];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.004 green:0.651 blue:0.659 alpha:1];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 20, 25);
    [backBtn setImage:[UIImage imageNamed:@"FangXiangZuo"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
