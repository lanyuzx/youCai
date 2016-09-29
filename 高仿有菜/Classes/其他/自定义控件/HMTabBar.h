//
//  LLTabBarController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMTabBar;
@protocol HMTabBarDelegate <NSObject>

-(void)TabBar:(HMTabBar*)TabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
@end
@interface HMTabBar : UIView
-(void)addButton:(UITabBarItem*)item;
@property(nonatomic,weak)id<HMTabBarDelegate>delegate;
//购买的个数
@property (nonatomic,strong)UILabel *countLable;
@end
