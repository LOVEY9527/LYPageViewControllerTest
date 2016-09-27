//
//  LYPageViewController.m
//  LYPageViewControllerTest
//
//  Created by li_yong on 16/9/13.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "LYPageViewController.h"

#import "LYPageView.h"
#import "LYStyleOneTableViewCell.h"

NSString * const kLYPCVCListTableViewCellReUseId = @"kLYPCVCListTableViewCellReUseId";

@interface LYPageViewController ()<LYPageViewDataSource, LYPageViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation LYPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self buildData];
    [self buildView];
}

/**
 *  @author liyong
 *
 *  构建数据源
 */
- (void)buildData
{
    self.dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    for (int index = 0; index < 6; index++)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (int index1 = 0; index1 < 10; index1++)
        {
            LYStyleOneModel *model = [[LYStyleOneModel alloc] init];
            model.serviceTitle = @"服务标题";
            model.serviceInfo = @"服务简介服务简介服务简介服务简介服务简介服务简介服务简介";
            model.price = 131.4;
            model.servicePrice = 0.52;
            model.address = @"江苏省南京市雨花台区大数据基地";
            model.collectionCount = 1314;
            [array addObject:model];
        }
        [self.dataSourceArray addObject:array];
    }
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
    pageView.dataSource = self;
    pageView.delegate = self;
    [pageView registerNib:[UINib nibWithNibName:NSStringFromClass([LYStyleOneTableViewCell class]) bundle:nil] forListViewCellWithReuseIdentifier:kLYPCVCListTableViewCellReUseId];
//    [pageView registerClass:[UITableViewCell class] forListViewCellWithReuseIdentifier:kLYPCVCListTableViewCellReUseId];
    [self.view addSubview:pageView];
}

#pragma mark - LYPageViewDataSource

- (nonnull UITableViewCell *)pageView:(nonnull LYPageView *)pageView
                             listView:(nonnull UITableView *)listView
                cellForRowAtIndexPath:(nonnull LYIndexPath *)indexPath
{
//    UITableViewCell *cell;
    LYStyleOneTableViewCell *cell;
    if (indexPath.modelIndexPath.item < [self.dataSourceArray count])
    {
        NSMutableArray *array = [self.dataSourceArray objectAtIndex:indexPath.modelIndexPath.item];
        if (indexPath.rowIndexPath.row < [array count])
        {
            cell = [listView dequeueReusableCellWithIdentifier:kLYPCVCListTableViewCellReUseId
                                                  forIndexPath:indexPath.rowIndexPath];
            LYStyleOneModel *model = [array objectAtIndex:indexPath.rowIndexPath.row];
            [cell buildCellWithModel:model];
            
            NSLog(@"indexPath.rowIndexPath:%@\ncell:%@", indexPath.rowIndexPath, cell);
        }
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
