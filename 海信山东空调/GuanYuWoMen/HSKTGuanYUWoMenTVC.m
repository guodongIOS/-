//
//  HSKTGuanYUWoMenTVC.m
//  海信山东空调
//
//  Created by Sun on 16/3/21.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTGuanYUWoMenTVC.h"
#import "MJExtension.h"
#import "HSKTSection_GYWM_Model.h"
#import "HSKTSubGuanYUWoMenModel.h"
#import "HSKTLabelCell.h"
#import "HSKTHeadImageCell.h"
#import "HSKTImageCell.h"
#import "UIViewExt.h"

@interface HSKTGuanYUWoMenTVC ()

@property (nonatomic,strong)NSArray *datas;

@end

@implementation HSKTGuanYUWoMenTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 85, 40)];
    title.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    title.text = @"关于我们";
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.sectionIndexBackgroundColor=[UIColor whiteColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.datas.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HSKTSection_GYWM_Model *head = (HSKTSection_GYWM_Model *)self.datas[section];
    
    
    return head.isHidden ? head.labels.count : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 0;
            break;
            
        default:
            return 10;
            break;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            HSKTSection_GYWM_Model *head = (HSKTSection_GYWM_Model *)self.datas[indexPath.section];
            HSKTSubGuanYUWoMenModel *entity = head.labels[indexPath.row];
            return [HSKTHeadImageCell ImageCellWithTableView:tableView content:entity.content];
        }
            break;
        
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    HSKTSection_GYWM_Model *head = (HSKTSection_GYWM_Model *)self.datas[indexPath.section];
                    HSKTSubGuanYUWoMenModel *entity = head.labels[indexPath.row];
                    return [HSKTLabelCell labelCellWithTableView:tableView content:entity.content];
                }
                    break;
                    
                case 1:
                {
                    HSKTSection_GYWM_Model *head = (HSKTSection_GYWM_Model *)self.datas[indexPath.section];
                    HSKTSubGuanYUWoMenModel *entity = head.labels[indexPath.row];
                    return [HSKTImageCell ImageCellWithTableView:tableView content:entity.content];
                }
                    break;
            }
        }
            break;
            
        default:
        {
            HSKTSection_GYWM_Model *head = (HSKTSection_GYWM_Model *)self.datas[indexPath.section];
            HSKTSubGuanYUWoMenModel *entity = head.labels[indexPath.row];
            return [HSKTLabelCell labelCellWithTableView:tableView content:entity.content];
        }
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSKTSection_GYWM_Model *head = (HSKTSection_GYWM_Model *)self.datas[indexPath.section];
    HSKTSubGuanYUWoMenModel *entity = head.labels[indexPath.row];
    
    switch (indexPath.section)
    {
        case 0:
            return DeviceHeight / 3.5;
            break;
            
        case 2:
            switch (indexPath.row)
            {
                case 0:
                    return entity.height;
                    break;
                    
                case 1:
                    return 110;
                    break;
            }
            break;
            
        default:
            return entity.height;
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    if (section == 0)
        height = 0;
    else height = 35;
    return height;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 35)];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenCell:)];
    view.tag=section;
    [view addGestureRecognizer:ges];
    
    view.backgroundColor = [UIColor colorWithRed:0.004 green:0.651 blue:0.659 alpha:1];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, DeviceWidth - 40, 25)];
    HSKTSection_GYWM_Model *head = (HSKTSection_GYWM_Model *)self.datas[section];
    title.text = head.headTitle;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    title.textColor = [UIColor whiteColor];
    [title adjustsFontSizeToFitWidth];
    [view addSubview:title];
    
    UIImageView *dian = [[UIImageView alloc] initWithFrame:CGRectMake(title.right + 10, title.top + 7.5, 10, 10)];
    dian.image = [UIImage imageNamed:@"BaiSe"];
    [view addSubview:dian];
    return view;
}

-(void)hiddenCell:(UIGestureRecognizer *)ges
{
    HSKTSection_GYWM_Model *head = (HSKTSection_GYWM_Model *)self.datas[ges.view.tag];
    head.hidden = !head.isHidden;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:ges.view.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - get
-(NSArray *)datas
{
    if (!_datas)
        _datas=[HSKTSection_GYWM_Model mj_objectArrayWithFilename:@"GuanYuWoMen.plist"];
    return _datas;
}

#pragma mark - action
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
