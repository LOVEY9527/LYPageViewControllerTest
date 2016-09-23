//
//  ViewController.m
//  LYPageViewControllerTest
//
//  Created by li_yong on 16/9/13.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "ViewController.h"
#import "LYPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
