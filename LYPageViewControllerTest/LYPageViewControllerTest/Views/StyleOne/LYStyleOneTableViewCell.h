//
//  LYStyleOneTableViewCell.h
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/27.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYStyleOneModel.h"

@interface LYStyleOneTableViewCell : UITableViewCell

/**
 *  @author liyong
 *
 *  构建单元格
 *
 *  @param model 模型
 */
- (void)buildCellWithModel:(LYStyleOneModel *)model;

@end
