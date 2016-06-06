//
//  ViewController.m
//  海信山东空调
//
//  Created by Sun on 16/3/15.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewExt.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDictionary+Extension.h"
#import "ToastUtils.h"
#import "SunXMLUtils.h"
#import "Utils.h"
#import "SVProgressHUD.h"
#import "MainViewController.h"
#import "JSONKit.h"
#import "AFHTTPSessionManager.h"
#import "CustomesViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)loadView
{
    [super loadView];
    
    // 用户名框
    _userName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _userName.layer.cornerRadius = 8.0f;
    _userName.layer.masksToBounds = YES;
    _userName.layer.borderWidth = 1.0f;
    // 用户名左侧图标
    UIImageView *_userNameLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _userNameLeft.image = [UIImage imageNamed:@"User"];
    _userNameLeft.backgroundColor = [UIColor clearColor];
    _userNameLeft.contentMode = UIViewContentModeScaleAspectFit;
    _userName.leftView = _userNameLeft;
    _userName.leftViewMode = UITextFieldViewModeAlways;
    _userName.placeholder = @"请输入用户名";
    _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName.autocorrectionType = UITextAutocorrectionTypeNo; // 是否自动纠错
    _userName.autocapitalizationType = UITextAutocapitalizationTypeNone; // 首字母是否大写
    _userName.returnKeyType = UIReturnKeyNext;
    _userName.adjustsFontSizeToFitWidth = YES;
    _userName.frame = CGRectMake(40, DeviceHeight / 2.5, _passWord.width, _passWord.height);
   [_userName addTarget:self action:@selector(userNameDidEndOnExit) forControlEvents:UIControlEventEditingDidEndOnExit];
   
    // 密码框
    _passWord.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _passWord.layer.cornerRadius = 8.0f;
    _passWord.layer.masksToBounds = YES;
    _passWord.layer.borderWidth = 1.0f;
    // 密码左侧图标
    UIImageView *_passWordLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _passWordLeft.image = [UIImage imageNamed:@"Pass"];
    _passWordLeft.backgroundColor = [UIColor clearColor];
    _passWordLeft.contentMode = UIViewContentModeScaleAspectFit;
    _passWord.leftView = _passWordLeft;
    _passWord.leftViewMode = UITextFieldViewModeAlways;
    _passWord.placeholder = @"请输入密码";
    _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWord.secureTextEntry = YES;
    _passWord.autocorrectionType = UITextAutocorrectionTypeNo; // 是否自动纠错
    _passWord.autocapitalizationType = UITextAutocapitalizationTypeNone; // 首字母是否大写
    _passWord.returnKeyType = UIReturnKeyJoin;
    _passWord.adjustsFontSizeToFitWidth = YES;
    [_passWord addTarget:self action:@selector(passwordDidEndOnExit) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    // 记住密码
    BOOL remeberPW =[[NSUserDefaults standardUserDefaults] boolForKey:@"remeberPW"];
    if (YES == remeberPW)
    {
        _userName.text = [Utils getValueFormKey:@"userName"];
        _passWord.text = [Utils getValueFormKey:@"passWord"];
        _rememberBtn.selected = YES;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 隐藏键盘
- (void)keyboardHidden
{
    [self.view endEditing:YES];
}

#pragma mark - userNameDidEndOnExit
- (void)userNameDidEndOnExit
{
    [_passWord becomeFirstResponder];
}

#pragma mark - passwordDidEndOnExit
- (void)passwordDidEndOnExit
{
    [self keyboardHidden];
    [self login];
}

#pragma mark - 登录
- (void)login
{
    if (_userName.text == nil || [_userName.text isEqualToString:@""])
    {
        [ToastUtils showWithText:@"用户名不能为空" duration:2];
        return;
    }else if (_passWord.text == nil || [_passWord.text isEqualToString:@""])
    {
        [ToastUtils showWithText:@"密码不能为空" duration:2];
        return;
    } else
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD showWithStatus:@"正在登录..."];
        [self loginTask];
    }
}

- (IBAction)denglu:(id)sender
{
    [self login];
}

- (IBAction)remeberPW:(id)sender
{
    _rememberBtn.selected = !_rememberBtn.selected;
}

- (void)loginTask
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@DengLu", IPConfig];
    NSDictionary *requestPars = @{@"YongHuMing" : _userName.text, @"MiMa" : _passWord.text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = TimeOut; // 设置请求超时
    [manager GET:requestUrl parameters:requestPars progress:^(NSProgress * _Nonnull downloadProgress)
    {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSDictionary *dic = [SunXMLUtils parserXMLWithData:responseObject];
        
        NSLog(@"dic",responseObject);
        
        if ([dic[@"ZhuangTai"] isEqualToString:@"success"])
        {
            [Utils saveValue:dic[@"QuanXian"] forKey:@"QuanXian"];
            [Utils saveValue:dic[@"NiCheng"] forKey:@"NiCheng"];
            [Utils saveValue:dic[@"YongHuId"] forKey:@"YongHuId"];
            [Utils saveValue:dic[@"YongHuMingCheng"] forKey:@"YongHuMingCheng"];
            if ([_rememberBtn isSelected])
            {
                [Utils saveValue:_userName.text forKey:@"userName"];
                [Utils saveValue:_passWord.text forKey:@"passWord"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"remeberPW"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            } else
            {
                [Utils saveValue:@"" forKey:@"userName"];
                [Utils saveValue:@"" forKey:@"passWord"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"remeberPW"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            
            MainViewController *mvc = [[MainViewController alloc] init];
            CustomesViewController *nav = [[CustomesViewController alloc] initWithRootViewController:mvc];
            
            dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            dispatch_after(when, dispatch_get_main_queue(), ^{
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                window.rootViewController = nav;
            });
        }else
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        
        NSLog(@"%@", dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

@end
