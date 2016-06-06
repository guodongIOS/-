//
//  HSKTShengChanDingDanViewController.m
//  海信山东空调
//
//  Created by Sun on 16/3/24.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "HSKTShengChanDingDanViewController.h"
#import "HSKTShengChanList.h"
#import "HSKTShengChanDingDanCell.h"
#import "CustomesViewController.h"
#import "SZCalendarPicker.h"
#import "TableViewWithBlock+Category.h"
#import "HSKTXianTiList.h"

typedef NS_ENUM(NSInteger, UITextField_Tag)
{
    XianTiMingCheng = 1,
    ShengChanZhuangTai,
    DateCong,
    DateDao
};


@interface HSKTShengChanDingDanViewController ()
@property (weak, nonatomic) IBOutlet UITextField *shengChanDingDan;
@property (weak, nonatomic) IBOutlet UITextField *xianTiMingCheng;
@property (weak, nonatomic) IBOutlet UITextField *shengChanZhuangTai;
@property (weak, nonatomic) IBOutlet UITextField *dateCong;
@property (weak, nonatomic) IBOutlet UITextField *dateDao;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hideHead;

@property (nonatomic, assign) BOOL isHideHead;
@property (nonatomic, assign) NSInteger mPage;

@property (nonatomic,strong) NSMutableArray *mLists;
@property (nonatomic, copy)NSString *xianTiID;
@property (nonatomic, copy)NSString *zhuangtaiID;
@property (nonatomic, strong) NSArray *mListSCZT;
@property (nonatomic, strong) NSArray *mListXianTi;
@property (nonatomic,strong)NSMutableArray *mListXianTiBianHao;
@property (nonatomic,strong) TableViewWithBlock *tb;
@property (nonatomic,assign) CGRect  rectInMainView; //坐标
@property (nonatomic, assign) BOOL isSelectedFirstList;

- (IBAction)loadData;



@end

@implementation HSKTShengChanDingDanViewController


-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // 强制横屏
    ((CustomesViewController *)self.navigationController).orietation = UIInterfaceOrientationMaskLandscapeRight;
    [self didLoadHengPing];
    
    // 线体名称 -- 右侧图片
    UIImageView *mingCheng = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    mingCheng.image = [UIImage imageNamed:@"LanSe"];
    mingCheng.contentMode = UIViewContentModeScaleAspectFit;
    mingCheng.backgroundColor = [UIColor clearColor];
    self.xianTiMingCheng.rightView = mingCheng;
    self.xianTiMingCheng.rightViewMode = UITextFieldViewModeAlways;
    self.xianTiMingCheng.delegate = self;
    self.xianTiMingCheng.tag = XianTiMingCheng;
    
    // 生产状态 -- 右侧图片
    UIImageView *zhuangTai = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    zhuangTai.image = [UIImage imageNamed:@"LanSe"];
    zhuangTai.contentMode = UIViewContentModeScaleAspectFit;
    zhuangTai.backgroundColor = [UIColor clearColor];
    self.shengChanZhuangTai.rightView = zhuangTai;
    self.shengChanZhuangTai.rightViewMode = UITextFieldViewModeAlways;
    self.shengChanZhuangTai.delegate = self;
    self.shengChanZhuangTai.tag = ShengChanZhuangTai;
    
    // 开工时间 -- 右侧图片
    UIImageView *imgDate = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    imgDate.image = [UIImage imageNamed:@"RiLi"];
    imgDate.contentMode = UIViewContentModeScaleAspectFit;
    imgDate.backgroundColor = [UIColor clearColor];
    self.dateCong.rightView = imgDate;
    self.dateCong.rightViewMode = UITextFieldViewModeAlways;
    self.dateCong.delegate = self;
    self.dateCong.tag = DateCong;
    
    // 开工时间 -- 右侧图片
    UIImageView *imgDateDao = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    imgDateDao.image = [UIImage imageNamed:@"RiLi"];
    imgDateDao.contentMode = UIViewContentModeScaleAspectFit;
    imgDateDao.backgroundColor = [UIColor clearColor];
    self.dateDao.rightView = imgDateDao;
    self.dateDao.rightViewMode = UITextFieldViewModeAlways;
    self.dateDao.delegate = self;
    self.dateDao.tag = DateDao;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // 上拉加载更多
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.footer.ignoredScrollViewContentInsetBottom = 3.0;
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.header.ignoredScrollViewContentInsetTop = 3.0;
    // 加载数据
    [self loadData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
    tap.cancelsTouchesInView = NO;
    [self.headView addGestureRecognizer:tap];
}

- (void)keyboardHidden
{
    [self.headView endEditing:YES];
}

#pragma mark - 加载数据
- (void)loadData
{
    self.mPage = 1;
    self.isHideHead = YES;
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    NSString *requestUrl = [NSString stringWithFormat:@"%@ShengChanJiHuaLieBiao", IPConfig];
    NSDictionary *requestPars =
        @{@"YeMa" : [NSString stringWithFormat:@"%ld",(long)self.mPage],
          @"HangShu" : @"10",
          @"XianTiBianHao" : self.xianTiID,
          @"KaiShiShiJian" : self.dateCong.text,
          @"JieShuShiJian" : self.dateDao.text,
          @"ShengChanZhuangTai" : self.zhuangtaiID,
          @"ShengChanDingDan" : self.shengChanDingDan.text
         };
    
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
             [self.mLists removeAllObjects];
             self.mLists = [HSKTShengChanList mj_objectArrayWithKeyValuesArray:dic[@"ShengChanJiHuaLieBiao"]];
             if (self.mLists.count != 0)
                 [SVProgressHUD showSuccessWithStatus:@"加载成功"];
             else
                 [SVProgressHUD showSuccessWithStatus:@"没有数据"];
             [self.tableView reloadData];
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
         NSLog(@"%@",error.description);
     }];
}

-(void)loadMoreData
{
    self.mPage++;
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    NSString *requestUrl = [NSString stringWithFormat:@"%@ShengChanJiHuaLieBiao", IPConfig];
    NSDictionary *requestPars =
    @{@"YeMa" : [NSString stringWithFormat:@"%ld",(long)self.mPage],
      @"HangShu" : @"10",
      @"XianTiBianHao" : self.xianTiID,
      @"KaiShiShiJian" : self.dateCong.text,
      @"JieShuShiJian" : self.dateDao.text,
      @"ShengChanZhuangTai" : self.zhuangtaiID,
      @"ShengChanDingDan" : self.shengChanDingDan.text
      };
    
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
             NSArray *array = [NSArray array];
             array = [HSKTShengChanList mj_objectArrayWithKeyValuesArray:dic[@"ShengChanJiHuaLieBiao"]];
             if (array.count != 0)
             {
                 [self.mLists addObjectsFromArray:array];
                 [SVProgressHUD showSuccessWithStatus:@"加载成功"];
                 [self.tableView reloadData];
                 [self.tableView.footer endRefreshing];
             } else
             {
                 [SVProgressHUD showSuccessWithStatus:@"没有更多"];
                 [self.tableView.footer endRefreshing];
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:@"加载失败"];
             [self.tableView.footer endRefreshing];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [SVProgressHUD showErrorWithStatus:@"加载失败"];
         [self.tableView.footer endRefreshing];
     }];
}


#pragma mark - tableview dataSoure
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mLists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HSKTShengChanDingDanCell labelCellWithTableView:tableView data:self.mLists[indexPath.row]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSKTShengChanList *entity = self.mLists[indexPath.row];
    return entity.height;
}

#pragma mark - UITextFiled Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    CGFloat y = self.navigationController.navigationBar.frame.size.height;
    switch (textField.tag)
    {
        case XianTiMingCheng: // 线体名称
        {
            [self getXianTiLists];
            self.isSelectedFirstList = YES;
            self.rectInMainView = [textField convertRect:textField.bounds toView:self.view];
            //显示下拉列表
            [self.view addSubview:self.tb];
            _tb.hasClearn = YES;
            _tb.didSelectedClear = ^()
            {
                textField.text=@"";
                _xianTiID = @"";
            };
            return NO;
        }
            
        case ShengChanZhuangTai: // 生产状态
        {
            self.isSelectedFirstList = NO;
            self.rectInMainView = [textField convertRect:textField.bounds toView:self.view];
            //显示下拉列表
            [self.view addSubview:self.tb];
            _tb.hasClearn = YES;
            _tb.didSelectedClear = ^()
            {
                textField.text=@"";
                _zhuangtaiID = @"";
            };
            return NO;
        }
            break;
            
        case DateCong: // 日期从
        {
            SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
            calendarPicker.today = [NSDate date];
            calendarPicker.date = calendarPicker.today;
            calendarPicker.frame = CGRectMake(0, y, self.view.frame.size.width, DeviceHeight - y);
            calendarPicker.subView = self.dateCong;
            return NO;
        }
            break;
            
        case DateDao: // 日期到
        {
            SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
            calendarPicker.today = [NSDate date];
            calendarPicker.date = calendarPicker.today;
            calendarPicker.frame = CGRectMake(0, y, self.view.frame.size.width, DeviceHeight - y);
            calendarPicker.subView = self.dateDao;
            return NO;
        }
            break;
            
        default: // 其他
            return YES;
            break;
    }
}

#pragma mark - getter
-(NSArray *)mListSCZT
{
    if (!_mListSCZT)
        _mListSCZT = @[
                       @{@"XIanTiMingCheng" : @"全部", @"XianTiBianHao" : @""},
                       @{@"XIanTiMingCheng" : @"未开始", @"XianTiBianHao" : @"未开始"},
                       @{@"XIanTiMingCheng" : @"生产中", @"XianTiBianHao" : @"生产中"},
                       @{@"XIanTiMingCheng" : @"生产结束", @"XianTiBianHao" : @"生产结束"}
                      ]; // 全部,未开始,生产中,生产结束
    return _mListSCZT;
}

-(NSString *)zhuangtaiID
{
    if (!_zhuangtaiID)
        _zhuangtaiID = @"";
    return _zhuangtaiID;
}

-(NSString *)xianTiID
{
    if (!_xianTiID)
        _xianTiID = @"";
    return _xianTiID;
}

-(TableViewWithBlock *)tb
{
    [_tb removeFromSuperview];
    NSArray *pickArr;
    pickArr = self.isSelectedFirstList ? self.mListXianTi : self.mListSCZT;
    
    //选中下拉某一项
    UITableViewDidSelectRowAtIndexPathBlock didSelectedRowBlock=^(UITableView* tableView, NSIndexPath* indexPath)
    {
        if (self.isSelectedFirstList)
        {
            self.xianTiMingCheng.text = [self.mListXianTi[indexPath.row] valueForKey:@"XIanTiMingCheng"];
            self.xianTiID = [self.mListXianTi[indexPath.row] valueForKey:@"XianTiBianHao"];
        }
        else
        {
            self.shengChanZhuangTai.text = [self.mListSCZT[indexPath.row] valueForKey:@"XIanTiMingCheng"];
            self.zhuangtaiID = [self.mListSCZT[indexPath.row] valueForKey:@"XianTiBianHao"];
        }
        
        [_tb removeFromSuperview];
    };
    _tb= [TableViewWithBlock getXiaLaKuang:_rectInMainView setPickArray:pickArr setDidSelectRowBlock:didSelectedRowBlock];
    return _tb;
}

-(void)getXianTiLists
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@ShengChanXianTiLieBiao", IPConfig];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 3; // 设置请求超时
    [manager GET:requestUrl parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary *dic = [SunXMLUtils parserXMLWithData:responseObject];
         
         if ([dic[@"ZhuangTai"] isEqualToString:@"success"])
         {
             self.mListXianTi = [HSKTXianTiList mj_objectArrayWithKeyValuesArray:dic[@"ShengChanXianTiLieBiao"]];
         }else
             self.mListXianTi = [NSArray array];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
     }];
}


#pragma mark - setter
-(void)setBarTitle:(NSString *)barTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 85, 40)];
    title.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    title.text = barTitle;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [title adjustsFontSizeToFitWidth];
    [self.navigationItem setTitleView:title];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 20, 25);
    [backBtn setImage:[UIImage imageNamed:@"FangXiangZuo"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *shouQi = [UIButton buttonWithType:UIButtonTypeCustom];
    shouQi.frame = CGRectMake(0, 0, 40, 40);
    [shouQi setImage:[UIImage imageNamed:@"DiQiuSouSuo"] forState:UIControlStateNormal];
    [shouQi addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:shouQi];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)setIsHideHead:(BOOL)isHideHead
{
    _isHideHead = isHideHead;
    [self hiedHead];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    ((CustomesViewController *)self.navigationController).orietation=UIInterfaceOrientationMaskPortrait;
    [self willapperaHengPing];
}

-(void)hide
{
    [self hiedHead];
    self.isHideHead = !self.isHideHead;
}

-(void)hiedHead
{
    if (self.isHideHead)
    {
        [UIView transitionWithView:self.headView duration:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
        {
            self.hideHead.constant = -self.headView.bounds.size.height;
        } completion:nil];

    }
    else
    {
        [UIView transitionWithView:self.headView duration:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
        {
            self.hideHead.constant = 0;
        } completion:nil];
    }
}

#pragma mark - 横屏
-(void)didLoadHengPing
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}



-(void)willapperaHengPing
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

@end
