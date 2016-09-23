//
//  LYPageView.m
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/23.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import "LYPageView.h"
#import "LYPageCollectionViewCell.h"

NSString *const collectionViewCellReUseID = @"collectionViewCellReUseID";

@interface LYPageView ()<UICollectionViewDataSource, UICollectionViewDelegate>

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
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                                          collectionViewLayout:collectionViewLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LYPageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:collectionViewCellReUseID];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.pagingEnabled = YES;
    [self addSubview:collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellReUseID
                                                                               forIndexPath:indexPath];
    
    return cell;
}

@end
