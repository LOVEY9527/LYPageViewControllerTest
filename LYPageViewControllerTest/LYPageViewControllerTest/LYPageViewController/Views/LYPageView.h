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
@property (strong, nonatomic, nonnull) NSIndexPath *rowIndexPath;

@end

@interface LYPageView : UIView

//数据源
@property (weak, nonatomic, nullable) id<LYPageViewDataSource> dataSource;
//代理
@property (weak, nonatomic, nullable) id<LYPageViewDelegate> delegate;

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

@protocol LYPageViewDataSource <NSObject>

@required

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


@end

@protocol LYPageViewDelegate <NSObject>



@end
