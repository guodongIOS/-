//
//  HSKTJiaZhuangController.m
//  海信山东空调
//
//  Created by Sun on 16/3/23.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTJiaZhuangController.h"
#import "HSKTJiaZhuangList.h"
#import "HSKTJiaZhuangHeadCell.h"
#import "HSKTJiaZhuangContentCell.h"

@interface HSKTJiaZhuangController ()
{
    BOOL *flag;
}

/**
 *  总数据
 */
@property (nonatomic,strong)NSMutableArray *dataMA;


@end

@implementation HSKTJiaZhuangController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.header.ignoredScrollViewContentInsetTop = 3.0;
    
    // 加载数据
    [self loadData];
}

-(void)loadData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    NSString *requestUrl = [NSString stringWithFormat:@"%@XiaoShiChanLiang", IPConfig];
    NSDictionary *requestPars = @{@"LeiBie" : _url};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = TimeOut; // 设置请求超时
    [manager GET:requestUrl parameters:requestPars progress:^(NSProgress * _Nonnull downloadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary *dic = [SunXMLUtils parserXMLWithData:responseObject];
         
         if ([dic[@"ZhuangTai"] isEqualToString:@"success"])
         {
             self.dataMA = [HSKTJiaZhuangList mj_objectArrayWithKeyValuesArray:dic[@"XiaoShiChanLiang"]];
             [self.tableView.header endRefreshing];
         }else
         {
             [SVProgressHUD showErrorWithStatus:@"加载失败"];
             [self.tableView.header endRefreshing];
         }
                      
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [SVProgressHUD showErrorWithStatus:@"加载失败"];
         [self.tableView.header endRefreshing];
     }];
}

#pragma mark - tableview代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return flag[section] ? [self.dataMA[section] count] + 1 : 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataMA.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenCell:)];
    view.tag=section;
    [view addGestureRecognizer:ges];
    
//    view.backgroundColor = [UIColor redColor];
    view.backgroundColor = [UIColor colorWithRed:0.004 green:0.651 blue:0.659 alpha:1];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth - 40, 50)];
    HSKTJiaZhuangList *entity= [self.dataMA[section] firstObject];
    title.text = [NSString stringWithFormat:@"线体名称：%@",entity.XianTiMingCheng];
    [title adjustsFontSizeToFitWidth];
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    return view;
}


-(void)hiddenCell:(UIGestureRecognizer *)ges
{
    int index = (int)ges.view.tag;
    flag[index] = !flag[index];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [HSKTJiaZhuangHeadCell labelCellWithTableView:tableView];
    }else
    {
        HSKTJiaZhuangList *entity= [self.dataMA[indexPath.section] objectAtIndex:indexPath.row - 1];
        return [HSKTJiaZhuangContentCell labelCellWithTableView:tableView data:entity];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
//    ((UITableViewHeaderFooterView *) view).contentView.backgroundColor = [UIColor clearColor];
    view.tintColor = [UIColor clearColor];
}

#pragma mark - set
-(void)setDataMA:(NSMutableArray *)dataMA
{
    if (flag)
    {
        memset(flag, NO, sizeof(*flag));
    }
    
    NSString *stringTemp=nil;
    NSMutableArray *mArr=nil;
    
    if (!_dataMA)
    {
        _dataMA=[NSMutableArray array];
    }
    
    [_dataMA removeAllObjects];
    
    for (HSKTJiaZhuangList *entity in dataMA)
    {
        if ([entity.XianTiBianHao isEqualToString:stringTemp])
        {
            [mArr addObject:entity];
        }
        else
        {
            mArr = [NSMutableArray arrayWithObject:entity];
            stringTemp=entity.XianTiBianHao;
            [_dataMA addObject:mArr];
        }
    }
    
    flag = (BOOL *)malloc(_dataMA.count * sizeof(BOOL *));
    memset(flag, NO, sizeof(*flag));
    
    if (self.dataMA.count != 0)
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
    else
        [SVProgressHUD showSuccessWithStatus:@"没有数据"];
    [self.tableView reloadData];
}

#pragma mark - setter
-(void)setBarTitle:(NSString *)barTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 85, 40)];
    title.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    title.text = barTitle;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [title adjustsFontSizeToFitWidth];
    title.textAlignment = NSTextAlignmentCenter;
    [self.navigationItem setTitleView:title];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 20, 25);
    [backBtn setImage:[UIImage imageNamed:@"FangXiangZuo"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)setUrl:(NSString *)url
{
    _url = url;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
