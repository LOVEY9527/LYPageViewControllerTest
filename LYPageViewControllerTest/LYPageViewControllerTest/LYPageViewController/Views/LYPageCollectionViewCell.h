//
//  LYPageCollectionViewCell.h
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/23.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYPageCollectionViewCellDataSource;
@protocol LYPageCollectionViewCellDelegate;

@interface LYListViewCellReUseObject : NSObject

//列表重用的单元格类
@property (strong, nonatomic, nullable) Class listViewCellReUseClass;
//列表重用的单元格nib
@property (strong, nonatomic, nullable) UINib *listViewCellReUseNib;
//列表重用ID
@property (copy, nonatomic, nonnull) NSString *listViewCellReuseIdentifier;

@end

@interface LYPageCollectionViewCell : UICollectionViewCell

//数据源
@property (weak, nonatomic, nullable) id<LYPageCollectionViewCellDataSource> dataSource;
//代理
@property (weak, nonatomic, nullable) id<LYPageCollectionViewCellDelegate> delegate;

//列表单元格高度(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat listRowHeight;             // will return the default value if unset
//列表单元格估算高度,一般跟约束一起使用(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat listEstimatedRowHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate

//列表区的区头高度(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat listSectionHeaderHeight;   // will return the default value if unset
//列表区的区头的估算高度,一般跟约束一起使用(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat listEstimatedSectionHeaderHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate

//列表区的区尾高度(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat listSectionFooterHeight;   // will return the default value if unset
//列表区的区尾的估算高度,一般跟约束一起使用(所有高低不一致或者不定的时候需要通过代理设定，代理的优先级更高)
@property (nonatomic) CGFloat listEstimatedSectionFooterHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate

#pragma mark - 注册

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

@protocol LYPageCollectionViewCellDataSource <NSObject>

@required

/**
 *  @author liyong
 *
 *  区中的行数
 *
 *  @param cell      单元格所在列表的模块单元格
 *  @param listView  单元格所在的列表
 *  @param indexPath 序号
 *
 *  @return 
 */
- (NSInteger)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                           listView:(nonnull UITableView *)listView
              numberOfRowsInSection:(nonnull NSIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  单元格
 *
 *  @param cell      单元格所在列表的模块单元格
 *  @param listView  单元格所在的列表
 *  @param indexPath 序号
 *
 *  @return
 */
- (nonnull UITableViewCell *)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                                           listView:(nonnull UITableView *)listView
                              cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@optional

/**
 *  @author liyong
 *
 *  列表区数
 *
 *  @param cell     单元格所在列表的模块单元格
 *  @param listView 单元格所在的列表
 *
 *  @return 
 */
- (NSInteger)numberOfSectionInPageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                                            listView:(nonnull UITableView *)listView;

@end

@protocol LYPageCollectionViewCellDelegate <NSObject>

@optional

/**
 *  @author liyong
 *
 *  点击单元格
 *
 *  @param cell       单元格所在列表的模块单元格
 *  @param listView   单元格所在的列表
 *  @param indexPath  被点击的单元格的序号
 */
- (void)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                      listView:(nonnull UITableView *)listView
     didSelectedRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

//列表的高度属性

/**
 *  @author liyong
 *
 *  获取指定单元格高度
 *
 *  @param cell      单元格所在列表的模块单元格
 *  @param listView  单元格所在的列表
 *  @param indexPath 单元格所在的序号
 *
 *  @return 单元格高度
 */
- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
          heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  获取指定列表区头高度
 *
 *  @param cell      区头所在列表的模块单元格
 *  @param listView  区头所在的列表
 *  @param indexPath 区头所在的序号
 *
 *  @return 区头的高度
 */
- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
         heightForHeaderInSection:(nonnull NSIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  获取指定列表区尾高度
 *
 *  @param cell      区尾所在列表的模块单元格
 *  @param listView  区尾所在的列表
 *  @param indexPath 区尾所在的序号
 *
 *  @return 区尾的高度
 */
- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
         heightForFooterInSection:(nonnull NSIndexPath *)indexPath;

/**
 *  @author liyong
 *
 *  获取指定单元格的估算高度
 *
 *  @param cell      单元格所在列表的模块单元格
 *  @param listView  单元格所在的列表
 *  @param indexPath 单元格所在的序号
 *
 *  @return 单元格估算高度
 */
- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
 estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);

/**
 *  @author liyong
 *
 *  获取指定列表区头估算高度
 *
 *  @param cell      区头所在列表的模块单元格
 *  @param listView  区头所在的列表
 *  @param indexPath 区头所在的序号
 *
 *  @return 区头的估算高度
 */
- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
estimatedHeightForHeaderInSection:(nonnull NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);

/**
 *  @author liyong
 *
 *  获取指定列表区尾高度
 *
 *  @param cell      区尾所在列表的模块单元格
 *  @param listView  区尾所在的列表
 *  @param indexPath 区尾所在的序号
 *
 *  @return 区尾的高度
 */
- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
estimatedHeightForFooterInSection:(nonnull NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);

//自定义列表的区头区尾

/**
 *  @author liyong
 *
 *  获取列表的区头视图
 *
 *  @param cell      区头所在列表的模块单元格
 *  @param listView  区头所在的列表
 *  @param indexPath 区头所在的序号
 *
 *  @return 区头的视图
 */
- (nullable UIView *)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                                   listView:(nonnull UITableView *)listView
                     viewForHeaderInSection:(nonnull NSIndexPath *)indexPath;   // custom view for header. will be adjusted to default or specified header height

/**
 *  @author liyong
 *
 *  获取指定列表区尾视图
 *
 *  @param cell      区尾所在列表的模块单元格
 *  @param listView  区尾所在的列表
 *  @param indexPath 区尾所在的序号
 *
 *  @return 区尾的视图
 */
- (CGFloat)pageCollectionViewCell:(nonnull LYPageCollectionViewCell *)cell
                         listView:(nonnull UITableView *)listView
           viewForFooterInSection:(nonnull NSIndexPath *)indexPath;   // custom view for footer. will be adjusted to default or specified footer height

@end
