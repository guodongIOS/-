//
//  CustomesViewController.m
//  LGHG
//
//  Created by 黄伟雄 on 15/10/26.
//  Copyright © 2015年 zxx. All rights reserved.
//

#import "CustomesViewController.h"

@interface CustomesViewController ()<UINavigationControllerDelegate>


@end

@implementation CustomesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self=[super initWithRootViewController:rootViewController]) {
        self.orietation=UIInterfaceOrientationMaskPortrait;
    }
    return self;
}

//-(UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
//{
//    return self.orietation;
//}

-(BOOL)shouldAutorotate{
    return YES;
}

//-(id<UINavigationControllerDelegate>)delegate
-(UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    return self.orietation;
}

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    LGLog(@"%ld",(long)UIInterfaceOrientationLandscapeRight);
//
////    return UIInterfaceOrientationMaskLandscapeRight;
//    return self.orietation;
//}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != self.orietation);
}


@end
