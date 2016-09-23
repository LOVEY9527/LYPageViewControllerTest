//
//  LYPageViewController.m
//  LYPageViewControllerTest
//
//  Created by li_yong on 16/9/13.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "LYPageViewController.h"
#import "LYPageView.h"

@interface LYPageViewController ()

@end

@implementation LYPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self buildView];
}

/**
 *  @author liyong
 *
 *  搭建界面
 */
- (void)buildView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    LYPageView *pageView = [[LYPageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
