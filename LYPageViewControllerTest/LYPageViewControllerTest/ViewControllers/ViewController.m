//
//  ViewController.m
//  LYPageViewControllerTest
//
//  Created by li_yong on 16/9/13.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "ViewController.h"
#import "LYPageViewController.h"
#import "LYBeforeViewController.h"
#import "LYAfterViewController.h"
#import "LYContentTableViewController.h"

@interface ViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  @author liyong
 *
 *  样式一
 *
 *  @param sender
 */
- (IBAction)styleOneClick:(id)sender
{
    LYPageViewController *pageStyleOneVC = [[LYPageViewController alloc] init];
    [self.navigationController pushViewController:pageStyleOneVC animated:YES];
}

/**
 *  @author liyong
 *
 *  样式二
 *
 *  @param sender
 */
- (IBAction)styleTwoClick:(id)sender
{
    UIViewController *pageStyleTwoVC = [[UIViewController alloc] init];
    pageStyleTwoVC.view.backgroundColor = [UIColor whiteColor];
    
    UIPageViewController *pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                 options:@{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMax)}];
    pageVC.dataSource = self;
    pageVC.delegate = self;
    pageVC.view.backgroundColor = [UIColor whiteColor];
    pageVC.view.frame = CGRectMake(0, 64, pageStyleTwoVC.view.frame.size.width, pageStyleTwoVC.view.frame.size.height - 64);
//    pageStyleTwoVC.automaticallyAdjustsScrollViewInsets = NO;
    LYContentTableViewController *firsrVC = [[LYContentTableViewController alloc] init];
    [pageVC setViewControllers:@[firsrVC]
                     direction:UIPageViewControllerNavigationDirectionReverse
                      animated:YES
                    completion:nil];
    
    [pageStyleTwoVC addChildViewController:pageVC];
    [pageStyleTwoVC.view addSubview:pageVC.view];
    
    [self.navigationController pushViewController:pageStyleTwoVC animated:YES];
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    LYContentTableViewController *beforeVC = [[LYContentTableViewController alloc] init];
    beforeVC.view.frame = CGRectMake(0, 64, beforeVC.view.frame.size.width, beforeVC.view.frame.size.height - 64);
    
    return beforeVC;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    LYContentTableViewController *afterVC = [[LYContentTableViewController alloc] init];
    
    return afterVC;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
