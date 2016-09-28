//
//  HMTabBar.h
//  考试编程题
//
//  Created by ma on 15/10/12.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMTabBar;
@protocol HMTabBarDelegate <NSObject>

-(void)TabBar:(HMTabBar*)TabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
@end
@interface HMTabBar : UIView
-(void)addButton:(UITabBarItem*)item;
@property(nonatomic,weak)id<HMTabBarDelegate>delegate;

@end
