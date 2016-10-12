//
//  LYPageCollectionViewCell.m
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/23.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "LYPageCollectionViewCell.h"

@implementation LYListViewReUseObject

@end

@interface LYPageCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>

//列表
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation LYPageCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];    
    
    //设置列表属性
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
//    self.listTableView.sectionHeaderHeight = 100;
//    self.listTableView.estimatedRowHeight = 1000;
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - 注册

/**
 *  @author liyong
 *
 *  注册列表区头或者区尾
 *
 *  @param aClass     重用信息对象
 */
- (void)registerListViewHeaderFooterViewWithObject:(nullable LYListViewReUseObject *)reUseObj
{
    if (reUseObj.listViewReUseNib != nil)
    {
        [self.listTableView registerNib:reUseObj.listViewReUseNib forHeaderFooterViewReuseIdentifier:reUseObj.listViewReuseIdentifier];
    }else
    {
        [self.listTableView registerClass:reUseObj.listViewReUseClass forHeaderFooterViewReuseIdentifier:reUseObj.listViewReuseIdentifier];
    }
}

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param reUseObj 重用信息对象
 */
- (void)registerListViewCellWithObject:(nullable LYListViewReUseObject *)reUseObj
{
    if (reUseObj.listViewReUseNib != nil)
    {
        [self.listTableView registerNib:reUseObj.listViewReUseNib forCellReuseIdentifier:reUseObj.listViewReuseIdentifier];
    }else
    {
        [self.listTableView registerClass:reUseObj.listViewReUseClass forCellReuseIdentifier:reUseObj.listViewReuseIdentifier];
    }
}

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param cellClass  单元格类型
 *  @param identifier 重用ID
 */
//- (void)registerClass:(nullable Class)cellClass forListViewCellWithReuseIdentifier:(nullable NSString *)identifier
//{
//    [self.listTableView registerClass:cellClass forCellReuseIdentifier:identifier];
//}

/**
 *  @author liyong
 *
 *  注册列表单元格
 *
 *  @param nib        单元格的nib
 *  @param identifier 重用ID
 */
//- (void)registerNib:(nullable UINib *)nib forListViewCellWithReuseIdentifier:(nullable NSString *)identifier
//{
//    [self.listTableView registerNib:nib forCellReuseIdentifier:identifier];
//}

#pragma mark - 列表属性

- (void)setListRowHeight:(CGFloat)listRowHeight
{
    self.listTableView.rowHeight = listRowHeight;
}

- (void)setListEstimatedRowHeight:(CGFloat)listEstimatedRowHeight
{
    self.listTableView.estimatedRowHeight = listEstimatedRowHeight;
}

- (void)setListSectionHeaderHeight:(CGFloat)listSectionHeaderHeight
{
    self.listTableView.sectionHeaderHeight = listSectionHeaderHeight;
}

- (void)setListEstimatedSectionHeaderHeight:(CGFloat)listEstimatedSectionHeaderHeight
{
    self.listTableView.estimatedSectionHeaderHeight = listEstimatedSectionHeaderHeight;
}

- (void)setListSectionFooterHeight:(CGFloat)listSectionFooterHeight
{
    self.listTableView.sectionFooterHeight = listSectionFooterHeight;
}

- (void)setListEstimatedSectionFooterHeight:(CGFloat)listEstimatedSectionFooterHeight
{
    self.listTableView.estimatedSectionFooterHeight = listEstimatedSectionFooterHeight;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionInPageCollectionViewCell:listView:)])
    {
        return [self.dataSource numberOfSectionInPageCollectionViewCell:self
                                                               listView:tableView];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(pageCollectionViewCell:listView:numberOfRowsInSection:)])
    {
        NSIndexPath *listIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        return [self.dataSource pageCollectionViewCell:self
                                              listView:tableView
                                 numberOfRowsInSection:listIndexPath];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(pageCollectionViewCell:listView:cellForRowAtIndexPath:)])
    {
        UITableViewCell *cell = [self.dataSource pageCollectionViewCell:self
                                                               listView:tableView
                                                  cellForRowAtIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageCollectionViewCell:listView:didSelectedRowAtIndexPath:)])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.delegate pageCollectionViewCell:self
                                     listView:tableView
                    didSelectedRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(pageCollectionViewCell:listView:heightForHeaderInSection:)])
    {
        NSIndexPath *listIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        return [self.delegate pageCollectionViewCell:self
                                            listView:tableView
                            heightForHeaderInSection:listIndexPath];
    }
    
    return self.listSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(pageCollectionViewCell:listView:heightForFooterInSection:)])
    {
        NSIndexPath *listIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        return [self.delegate pageCollectionViewCell:self
                                            listView:tableView
                            heightForFooterInSection:listIndexPath];
    }
    
    return self.listSectionFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(pageCollectionViewCell:listView:viewForHeaderInSection:)])
    {
        NSIndexPath *listIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        return [self.delegate pageCollectionViewCell:self
                                            listView:tableView
                              viewForHeaderInSection:listIndexPath];
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(pageCollectionViewCell:listView:viewForFooterInSection:)])
    {
        NSIndexPath *listIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        return [self.delegate pageCollectionViewCell:self
                                            listView:tableView
                              viewForFooterInSection:listIndexPath];
    }
    
    return nil;
}

@end
