//
//  LYStyleOneModel.h
//  LYPageViewControllerTest
//
//  Created by 李勇 on 16/9/27.
//  Copyright © 2016年 li_yong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface LYStyleOneModel : NSObject

@property (copy, nonatomic) NSString *serviceTitle;
@property (copy, nonatomic) NSString *serviceInfo;
@property (assign, nonatomic) CGFloat price;
@property (assign, nonatomic) CGFloat servicePrice;
@property (copy, nonatomic) NSString *address;
@property (assign, nonatomic) NSInteger collectionCount;

@end
