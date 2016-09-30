//
//  LYPageView.h
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/23.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYPageViewDataSource;
@protocol LYPageViewDelegate;

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
 *  @param viewClass   补充视图类型
 *  @param elementKind 补充视图类型(UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter)
 *  @param identifier  重用ID
 */
- (void)registerClass:(nullable Class)viewClass
        forModelPageSupplementaryViewOfKind:(nullable NSString *)elementKind
        withReuseIdentifier:(nullable NSString *)identifier;

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
        withReuseIdentifier:(nullable NSString *)identifier;

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param cellClass  单元格类型
 *  @param identifier 重用ID
 */
- (void)registerClass:(nullable Class)cellClass forListViewCellWithReuseIdentifier:(nullable NSString *)identifier;

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param nib        单元格的nib
 *  @param identifier 重用ID
 */
- (void)registerNib:(nullable UINib *)nib forListViewCellWithReuseIdentifier:(nullable NSString *)identifier;

@end

@protocol LYPageViewDataSource <NSObject>

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

@end

@protocol LYPageViewDelegate <NSObject>



@end
