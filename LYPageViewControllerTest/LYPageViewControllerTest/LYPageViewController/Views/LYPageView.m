//
//  LYPageView.m
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/23.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "LYPageView.h"
#import "LYPageCollectionViewCell.h"

NSString * const kLYPVCollectionViewCellReUseID = @"kLYPVCollectionViewCellReUseID";

@implementation LYIndexPath

@end

@interface LYPageView ()<UICollectionViewDataSource, UICollectionViewDelegate, LYPageCollectionViewCellDataSource, LYPageCollectionViewCellDelegate>

//列表重用信息对象
@property (strong, nonatomic, nonnull) LYListViewCellReUseObject *reUseObj;

//横向滑动的视图
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation LYPageView

/**
 *  @author liyong
 *
 *  初始化方法
 *
 *  @param frame
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self buildView];
    }
    
    return self;
}

/**
 *  @author liyong
 *
 *  构建界面
 */
- (void)buildView
{
    //横向collectionView
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    collectionViewLayout.minimumLineSpacing = 0;
    collectionViewLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                                          collectionViewLayout:collectionViewLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LYPageCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:kLYPVCollectionViewCellReUseID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
}

#pragma mark - 注册

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param cellClass  单元格类型
 *  @param identifier 重用ID
 */
- (void)registerClass:(nullable Class)cellClass forListViewCellWithReuseIdentifier:(nullable NSString *)identifier
{
    self.reUseObj = [[LYListViewCellReUseObject alloc] init];
    self.reUseObj.listViewCellReUseClass = cellClass;
    self.reUseObj.listViewCellReuseIdentifier = identifier;
}

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param nib        单元格的nib
 *  @param identifier 重用ID
 */
- (void)registerNib:(nullable UINib *)nib forListViewCellWithReuseIdentifier:(nullable NSString *)identifier
{
    self.reUseObj = [[LYListViewCellReUseObject alloc] init];
    self.reUseObj.listViewCellReUseNib = nib;
    self.reUseObj.listViewCellReuseIdentifier = identifier;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLYPVCollectionViewCellReUseID
                                                                               forIndexPath:indexPath];
    cell.dataSource = self;
    cell.delegate = self;
    if (self.reUseObj.listViewCellReUseNib != nil)
    {
        [cell registerNib:self.reUseObj.listViewCellReUseNib forListViewCellWithReuseIdentifier:self.reUseObj.listViewCellReuseIdentifier];
    }else
    {
        [cell registerClass:self.reUseObj.listViewCellReUseClass forListViewCellWithReuseIdentifier:self.reUseObj.listViewCellReuseIdentifier];
    }
    
    return cell;
}

#pragma mark - LYPageCollectionViewCellDataSource

- (nonnull UITableViewCell *)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                                           listView:(nonnull UITableView *)listView
                              cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(pageView:listView:cellForRowAtIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        finalIndexPath.rowIndexPath = indexPath;
        
        UITableViewCell *cell = [self.dataSource pageView:self
                                                 listView:listView
                                    cellForRowAtIndexPath:finalIndexPath];
        return cell;
    }
    
    return nil;
}

#pragma mark - LYPageCollectionViewCellDelegate

@end
