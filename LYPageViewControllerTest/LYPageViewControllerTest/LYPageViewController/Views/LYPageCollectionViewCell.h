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



@end