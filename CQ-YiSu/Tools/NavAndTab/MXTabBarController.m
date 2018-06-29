//
//  MXTabBarController.m
//  navDemo
//
//  Created by Max on 16/9/20.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import "MXTabBarController.h"
#import "MXNavigationController.h"
#import "CQHomePageVC.h"
#import "CQMineVC.h"


@interface MXTabBarController ()

@end

@implementation MXTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViews];
}


- (void)setUpChildViews{
    CQHomePageVC *homeVC = [[CQHomePageVC alloc] init];
    MXNavigationController *homePageVC = [[MXNavigationController alloc] initWithRootViewController:homeVC];
    homeVC.title = @"首页";
    
    CQMineVC *mineVC = [[CQMineVC alloc]init];
    MXNavigationController *myVC = [[MXNavigationController alloc] initWithRootViewController:mineVC];
    mineVC.title = @"我的";

    self.viewControllers = @[homePageVC,myVC];
}




@end
