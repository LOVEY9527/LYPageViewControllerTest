//
//  LYPageView.m
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/23.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "LYPageView.h"
#import "LYPageCollectionViewCell.h"
#import "LYStyleOneColModelHeaderView.h"

NSString * const kLYPVCollectionViewCellReUseID = @"kLYPVCollectionViewCellReUseID";
NSString * const kLYPVCollectionViewHeaderReUseID = @"kLYPVCollectionViewHeaderReUseID";

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

#pragma mark - 视图

/**
 *  @author liyong
 *
 *  自定义横向分页视图的头视图
 *
 *  @param pageHeaderView 头视图
 */
- (void)customModelPageHeaderWith:(nonnull UIView *)pageHeaderView
{
    //设置collectionView的缩进
    self.collectionView.contentInset = UIEdgeInsetsMake(self.collectionView.contentInset.top,
                                                        pageHeaderView.frame.size.width,
                                                        self.collectionView.contentInset.bottom,
                                                        self.collectionView.contentInset.right);
    self.collectionView.pagingEnabled = NO;
    
    //添加头视图
    pageHeaderView.frame = CGRectMake(-pageHeaderView.frame.size.width, 0, pageHeaderView.frame.size.width, pageHeaderView.frame.size.height);
    [self.collectionView addSubview:pageHeaderView];
}

#pragma mark - 注册

/**
 *  @author liyong
 *
 *  注册分页视图补充视图(头视图/尾视图)
 *
 *  @param viewClass   补充视图类型
 *  @param elementKind 补充视图类型(UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter)
 *  @param identifier  重用ID
 */
- (void)registerClass:(nullable Class)viewClass
        forModelPageSupplementaryViewOfKind:(nullable NSString *)elementKind
        withReuseIdentifier:(nullable NSString *)identifier
{
    [self.collectionView registerClass:viewClass
            forSupplementaryViewOfKind:elementKind
                   withReuseIdentifier:identifier];
}

/**
 *  @author liyong
 *
 *  注册分页视图补充视图(头视图/尾视图)
 *
 *  @param nib        补充视图的nib
 *  @param kind       补充视图类型(UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter)
 *  @param identifier 重用ID
 */
- (void)registerNib:(nullable UINib *)nib
        forModelPageSupplementaryViewOfKind:(nullable NSString *)kind
        withReuseIdentifier:(nullable NSString *)identifier
{
    [self.collectionView registerNib:nib
          forSupplementaryViewOfKind:kind
                 withReuseIdentifier:identifier];
}

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

#pragma mark - UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(100, 0);
//}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.dataSource respondsToSelector:@selector(numberOfModelSectionInPageView:)])
    {
        return [self.dataSource numberOfModelSectionInPageView:self];
    }
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(pageView:numberOfModelInSection:)])
    {
        NSIndexPath *modelIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = modelIndexPath;
        return [self.dataSource pageView:self numberOfModelInSection:finalIndexPath];
    }
    
    return 0;
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

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                                                  withReuseIdentifier:kLYPVCollectionViewHeaderReUseID
//                                                                                         forIndexPath:indexPath];
//        
//        return headerView;
//    }
//    
//    return nil;
//}

#pragma mark - LYPageCollectionViewCellDataSource

- (NSInteger)numberOfSectionInPageCollectionViewCell:(LYPageCollectionViewCell *)cell listView:(UITableView *)listView
{
    if ([self.dataSource respondsToSelector:@selector(pageView:numberOfListViewSectionInIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        
        return [self.dataSource pageView:self numberOfListViewSectionInIndexPath:finalIndexPath];
    }
    
    return 0;
}

- (NSInteger)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                           listView:(nonnull UITableView *)listView
              numberOfRowsInSection:(nonnull NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(pageView:numberOfListViewRowsInSection:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        finalIndexPath.listIndexPath = indexPath;
        
        return [self.dataSource pageView:self numberOfListViewRowsInSection:finalIndexPath];
    }
    
    return 0;
}

- (nonnull UITableViewCell *)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                                           listView:(nonnull UITableView *)listView
                              cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(pageView:listView:cellForRowAtIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        finalIndexPath.listIndexPath = indexPath;
        
        UITableViewCell *cell = [self.dataSource pageView:self
                                                 listView:listView
                                    cellForRowAtIndexPath:finalIndexPath];
        return cell;
    }
    
    return nil;
}

#pragma mark - LYPageCollectionViewCellDelegate

@end
