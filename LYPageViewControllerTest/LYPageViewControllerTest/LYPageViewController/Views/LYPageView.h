//
//  LYPageView.h
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/23.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPageCollectionViewCell.h"

@protocol LYPageViewDataSource;
@protocol LYPageViewDelegate;

extern NSString * const UITableViewSectionHeader;
extern NSString * const UITableViewSectionFooter;

@interface LYIndexPath : NSObject

//模块序号
@property (strong, nonatomic, nonnull) NSIndexPath *modelIndexPath;
//列表单元格序号
@property (strong, nonatomic, nonnull) NSIndexPath *listIndexPath;

@end

@interface LYPageView : UIView

//数据源
@property (weak, nonatomic, nullable) id<LYPageViewDataSource> dataSource;
//代理
@property (weak, nonatomic, nullable) id<LYPageViewDelegate> delegate;

//列表单元格高度(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat pageListRowHeight;             // will return the default value if unset
//列表单元格估算高度,一般跟约束一起使用(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat pageListEstimatedRowHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate

//列表区的区头高度(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat pageListSectionHeaderHeight;   // will return the default value if unset
//列表区的区头的估算高度,一般跟约束一起使用(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat pageListEstimatedSectionHeaderHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate

//列表区的区尾高度(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat pageListSectionFooterHeight;   // will return the default value if unset
//列表区的区尾的估算高度,一般跟约束一起使用(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat pageListEstimatedSectionFooterHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate

#pragma mark - 视图

/**
 *  @author liyong
 *
 *  自定义横向分页视图的头视图
 *
 *  @param pageHeaderView 头视图
 */
- (void)customModelPageHeaderWith:(nonnull UIView *)pageHeaderView;

#pragma mark - 注册

/**
 *  @author liyong
 *
 *  注册分页视图补充视图(头视图/尾视图)
 *
 *  @param reUseObj    补充视图重用信息对象
 *  @param elementKind 补充视图类型(UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter)
 */
- (void)registerObj:(nonnull LYListViewReUseObject *)reUseObj forModelPageSuppleMentaryViewOfKind:(nonnull NSString *)elementKind;

/**
 *  @author liyong
 *
 *  注册分页视图中列表的区头区尾
 *
 *  @param listHeaderFooterReUseObj 重用信息对象
 *  @param kind                     补充视图类型(UITableViewSectionHeader/UITableViewSectionFooter)
 */
- (void)registerObj:(nonnull LYListViewReUseObject *)listHeaderFooterReUseObj ForPageViewListSupplementaryViewOfKind:(nonnull NSString *)kind;

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param reUseObj 重用信息对象
 */
- (void)registerListViewCellWith:(nonnull LYListViewReUseObject *)reUseObj;

@end

@protocol LYPageViewDataSource <NSObject>

@optional

/**
 *  @author liyong
 *
 *  模块区数
 *
 *  @param pageView 分页视图
 *
 *  @return
 */
- (NSInteger)numberOfModelSectionInPageView:(nonnull LYPageView *)pageView;

/**
 *  @author liyong
 *
 *  模块中列表的区数
 *
 *  @param pageView  分页视图
 *  @param indexPath 序号
 *
 *  @return
 */
- (NSInteger)pageView:(nonnull LYPageView *)pageView numberOfListViewSectionInIndexPath:(nonnull LYIndexPath *)indexPath;

@required

/**
 *  @author liyong
 *
 *  模块区中模块的个数
 *
 *  @param pageView  分页视图
 *  @param indexPath 单元格序号
 *
 *  @return 
 */
- (NSInteger)pageView:(nonnull LYPageView *)pageView numberOfModelInSection:(nonnull LYIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  模块中列表的行数
 *
 *  @param pageView  分页视图
 *  @param indexPath 单元格序号
 *
 *  @return
 */
- (NSInteger)pageView:(nonnull LYPageView *)pageView numberOfListViewRowsInSection:(nonnull LYIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  单元格
 *
 *  @param pageView  分页视图
 *  @param listView  列表视图
 *  @param indexPath 单元格序号
 *
 *  @return 
 */
- (nonnull UITableViewCell *)pageView:(nonnull LYPageView *)pageView
                             listView:(nonnull UITableView *)listView
                cellForRowAtIndexPath:(nonnull LYIndexPath *)indexPath;

@end

@protocol LYPageViewDelegate <NSObject>

@optional

/**
 *  @author liyong
 *
 *  点击模块中的单元格
 *
 *  @param pageView  分页视图
 *  @param indexPath 被点击的单元格序号
 */
- (void)pageView:(nonnull LYPageView *)pageView didSelectedAtIndexPath:(nonnull LYIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  分页模块区头size
 *
 *  @param pageView             分页视图
 *  @param collectionViewLayout
 *  @param section              区头所在的区号
 *
 *  @return
 */
- (CGSize)pageView:(nonnull LYPageView *)pageView
          layout:(nonnull UICollectionViewLayout *)collectionViewLayout
          referenceSizeForHeaderInSection:(NSInteger)section;

/**
 *  @author liyong
 *
 *  分页模块区尾size
 *
 *  @param pageView             分页视图
 *  @param collectionViewLayout
 *  @param section              区尾所在的区号
 *
 *  @return
 */
- (CGSize)pageView:(nonnull LYPageView *)pageView
          layout:(nonnull UICollectionViewLayout *)collectionViewLayout
          referenceSizeForFooterInSection:(NSInteger)section;

/**
 *  @author liyong
 *
 *  获取列表的单元格高度(高度统一的话建议使用pageListRowHeight)
 *
 *  @param pageView  分页视图
 *  @param indexPath 单元格所在的序号
 *
 *  @return 
 */
- (CGFloat)pageView:(nonnull LYPageView *)pageView heightForListViewRowAtIndexPath:(nonnull LYIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  获取列表的区头高度
 *
 *  @param pageView  分页视图
 *  @param indexPath 区头所在的序号
 *
 *  @return 区头高度
 */
- (CGFloat)pageView:(nonnull LYPageView *)pageView heightForListViewHeaderAtIndexPath:(nonnull LYIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  获取列表区尾的高度
 *
 *  @param pageView  分页视图
 *  @param indexPath 区尾所在的序号
 *
 *  @return 区尾的高度
 */
- (CGFloat)pageView:(nonnull LYPageView *)pageView heightForListViewFooterAtIndexPath:(nonnull LYIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  获取模块补充视图(头视图/尾视图)
 *
 *  @param pageView  分页视图
 *  @param pageView  模块
 *  @param kind      补充视图类型(UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter)
 *  @param indexPath 补充视图所在的序号
 *
 *  @return
 */
- (nullable UICollectionReusableView *)pageView:(nonnull LYPageView *)pageView
                                 collectionView:(nonnull UICollectionView *)collectionView
                        viewForSupplementOfKind:(nonnull NSString *)kind
                                    atIndexPath:(nonnull LYIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  获取列表的区头视图
 *
 *  @param pageView  分页视图
 *  @param listView  区尾所在的列表
 *  @param indexPath 区头所在的序号
 *
 *  @return 区头视图
 */
- (nullable UIView *)pageView:(nonnull LYPageView *)pageView
                     listView:(nonnull UITableView *)listView
                     viewForListViewHeaderAtIndexPath:(nonnull LYIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  获取列表区尾视图
 *
 *  @param pageView  分页视图
 *  @param listView  区尾所在的列表
 *  @param indexPath 区尾所在的序号
 *
 *  @return 区尾视图
 */
- (nullable UIView *)pageView:(nonnull LYPageView *)pageView
                     listView:(nonnull UITableView *)listView
                     viewForListViewFooterAtIndexPath:(nonnull LYIndexPath *)indexPath;

@end
