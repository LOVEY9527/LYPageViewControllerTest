//
//  LYPageView.m
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/23.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "LYPageView.h"
#import "LYStyleOneColModelHeaderView.h"

NSString * const UITableViewSectionHeader = @"UITableViewSectionHeader";
NSString * const UITableViewSectionFooter = @"UITableViewSectionFooter";

NSString * const kLYPVCollectionViewCellReUseID = @"kLYPVCollectionViewCellReUseID";

@implementation LYIndexPath

@end

@interface LYPageView ()<UICollectionViewDataSource, UICollectionViewDelegate, LYPageCollectionViewCellDataSource, LYPageCollectionViewCellDelegate>

//列表单元格重用信息对象
@property (strong, nonatomic, nonnull) LYListViewReUseObject *listCellReUseObj;
//列表区头视图重用信息对象
@property (strong, nonatomic, nonnull) LYListViewReUseObject *listHeaderReUseObj;
//列表区尾视图重用信息对象
@property (strong, nonatomic, nonnull) LYListViewReUseObject *listFooterReUseObj;

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
 *  @param reUseObj    补充视图重用信息对象
 *  @param elementKind 补充视图类型(UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter)
 */
- (void)registerObj:(nonnull LYListViewReUseObject *)reUseObj forModelPageSuppleMentaryViewOfKind:(nonnull NSString *)elementKind
{
    self.collectionView.pagingEnabled = NO;
    if (reUseObj.listViewReUseNib != nil)
    {
        [self.collectionView registerNib:reUseObj.listViewReUseNib
              forSupplementaryViewOfKind:elementKind
                     withReuseIdentifier:reUseObj.listViewReuseIdentifier];
    }else
    {
        [self.collectionView registerClass:reUseObj.listViewReUseClass
                forSupplementaryViewOfKind:elementKind
                       withReuseIdentifier:reUseObj.listViewReuseIdentifier];
    }
}

/**
 *  @author liyong
 *
 *  注册分页视图中列表的区头区尾
 *
 *  @param listHeaderFooterReUseObj 重用信息对象
 *  @param kind                     补充视图类型(UITableViewSectionHeader/UITableViewSectionFooter)
 */
- (void)registerObj:(nonnull LYListViewReUseObject *)listHeaderFooterReUseObj ForPageViewListSupplementaryViewOfKind:(nonnull NSString *)kind
{
    if ([kind isEqualToString:UITableViewSectionHeader])
    {
        self.listHeaderReUseObj = listHeaderFooterReUseObj;
    }else if ([kind isEqualToString:UITableViewSectionFooter])
    {
        self.listFooterReUseObj = listHeaderFooterReUseObj;
    }
}

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param reUseObj 重用信息对象
 */
- (void)registerListViewCellWith:(nonnull LYListViewReUseObject *)reUseObj
{
    self.listCellReUseObj = reUseObj;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(pageView:layout:referenceSizeForHeaderInSection:)])
    {
        return [self.delegate pageView:self layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(pageView:layout:referenceSizeForFooterInSection:)])
    {
        return [self.delegate pageView:self layout:collectionViewLayout referenceSizeForFooterInSection:section];
    }
    
    return CGSizeZero;
}

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
    if (self.listHeaderReUseObj != nil)
    {
        //注册列表区头视图
        [cell registerListViewHeaderFooterViewWithObject:self.listHeaderReUseObj];
    }
    if (self.listFooterReUseObj != nil)
    {
        //注册列表区尾视图
        [cell registerListViewHeaderFooterViewWithObject:self.listFooterReUseObj];
    }
    if (self.listCellReUseObj != nil)
    {
        //注册列表单元格视图
        [cell registerListViewCellWithObject:self.listCellReUseObj];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageView:collectionView:viewForSupplementOfKind:atIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = indexPath;
        
        return [self.delegate pageView:self
                              collectionView:collectionView
                              viewForSupplementOfKind:kind
                              atIndexPath:finalIndexPath];
    }
    return nil;
}

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
    
    return 1;
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

- (void)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                      listView:(nonnull UITableView *)listView
     didSelectedRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageView:didSelectedAtIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        finalIndexPath.listIndexPath = indexPath;
        
        [self.delegate pageView:self didSelectedAtIndexPath:finalIndexPath];
    }
}

- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
         heightForHeaderInSection:(nonnull NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageView:heightForListViewHeaderAtIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        finalIndexPath.listIndexPath = indexPath;
        
        return [self.delegate pageView:self heightForListViewHeaderAtIndexPath:finalIndexPath];
    }
    
    return self.pageListSectionHeaderHeight;
}

- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
         heightForFooterInSection:(nonnull NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageView:heightForListViewFooterAtIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        finalIndexPath.listIndexPath = indexPath;
        
        return [self.delegate pageView:self heightForListViewFooterAtIndexPath:finalIndexPath];
    }
    
    return self.pageListSectionFooterHeight;
}

- (UIView *)pageCollectionViewCell:(LYPageCollectionViewCell *)cell
                          listView:(UITableView *)listView
            viewForHeaderInSection:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageView:listView:viewForListViewHeaderAtIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        finalIndexPath.listIndexPath = indexPath;
        
        return [self.delegate pageView:self listView:listView viewForListViewHeaderAtIndexPath:finalIndexPath];
    }
    
    return nil;
}

- (UIView *)pageCollectionViewCell:(LYPageCollectionViewCell *)cell
                          listView:(UITableView *)listView
            viewForFooterInSection:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageView:listView:viewForListViewFooterAtIndexPath:)])
    {
        //完整的indexPath
        LYIndexPath *finalIndexPath = [[LYIndexPath alloc] init];
        finalIndexPath.modelIndexPath = [self.collectionView indexPathForCell:cell];
        finalIndexPath.listIndexPath = indexPath;
        
        return [self.delegate pageView:self listView:listView viewForListViewFooterAtIndexPath:finalIndexPath];
    }
    
    return nil;
}

@end
