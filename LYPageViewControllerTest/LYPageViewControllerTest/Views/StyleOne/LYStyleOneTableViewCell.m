//
//  LYStyleOneTableViewCell.m
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/27.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "LYStyleOneTableViewCell.h"

@interface LYStyleOneTableViewCell ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *img;
//服务标题
@property (weak, nonatomic) IBOutlet UILabel *serviceTitleLab;
//服务简介
@property (weak, nonatomic) IBOutlet UILabel *serviceInfoLab;
//价格
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
//服务费
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLab;

//地址容器视图
@property (weak, nonatomic) IBOutlet UIView *addressContainView;
//地址
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

//收藏量的icon
@property (weak, nonatomic) IBOutlet UIImageView *collectionCountIcon;
//收藏数量
@property (weak, nonatomic) IBOutlet UILabel *collectionCountLab;

@end

@implementation LYStyleOneTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  @author liyong
 *
 *  构建单元格
 *
 *  @param model 模型
 */
- (void)buildCellWithModel:(LYStyleOneModel *)model
{
    self.serviceTitleLab.text = model.serviceTitle;
    self.serviceInfoLab.text = model.serviceInfo;
    self.priceLab.text = [NSString stringWithFormat:@"￥%.2f", model.price];
    self.servicePriceLab.text = [NSString stringWithFormat:@"服务费:%.2f", model.servicePrice];
    self.addressLab.text = model.address;
    self.collectionCountLab.text = [NSString stringWithFormat:@"%ld", model.collectionCount];
}

@end
