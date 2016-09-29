//
//  LLTabBarController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import "HMTabBar.h"
#import <BAButton/BAButton.h>
@interface HMTabBar()
//记录按钮
@property (nonatomic,strong)UIButton *button;
@property(nonatomic,weak)UIImageView*backGuround;

@end

@implementation HMTabBar
//通过代码创建控件的时候最先调用
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBackground];
    }
    return self;
}
//添加背景图片
-(void)addBackground{
    
    self.backgroundColor = [UIColor whiteColor];
//    UIImageView*back=[[UIImageView alloc]init];
//    back.image=[UIImage imageNamed:@"toolBar_shade"];
//    self.backGuround = back;
//    [self addSubview:back];

}
//设置按钮
-(void)addButton:(UITabBarItem *)item{
    
    BACustomButton*btn= [[BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self addSubview:btn];
        //设置图片
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setImage:item.selectedImage forState:UIControlStateSelected];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor: [UIColor colorWithRed:10/255.0 green:178/255.0 blue:10/255.0 alpha:1.0]forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
   //绑定点击事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    //设置默认选中
    //获取按钮个数
    NSInteger count=self.subviews.count;
    if (count==1) {
        [self btnClick:btn];
    }
   }
//点击事件
-(void)btnClick:(UIButton*)btn{
    //判断是否实现代理方法
    if ([self.delegate respondsToSelector:@selector(TabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate TabBar:self didSelectedButtonFrom:btn.tag to:btn.tag];
    }
//取消上一次选中
    self.button.selected=NO;
    //设置当前选中
    btn.selected=YES;
    self.button=btn;
   
    
}
//设置按钮frame
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnY= -2;
   
    CGFloat btnH=self.frame.size.height;
    //获取按钮个数
    NSInteger count= self.subviews.count;
     CGFloat btnW=self.frame.size.width/count;
    for (int i=0; i<count; i++) {
        UIButton*btn=self.subviews[i];
        CGFloat btnX=btnW * i;
        //设置tag值
        btn.tag=i;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);

        //此处为购物车的按钮
        if (i == 3) {
            [btn addSubview:self.countLable];
            self.countLable.frame = CGRectMake(btn.imageView.frame.origin.x +btn.imageView.frame.size.width  , 0, 20, 20);
            }
    }
   
self.backGuround.frame=CGRectMake(0, btnY, btnW, btnH);
}

//绘图
-(void)drawRect:(CGRect)rect{
    UIImage*img=[UIImage imageNamed:@"tabBar_back"];
    [img drawInRect:rect];

}
  /// MARK: ---- 懒加载
-(UILabel *)countLable {
    
    if (_countLable == nil) {
        _countLable = [[UILabel alloc]init];
        _countLable.textAlignment = NSTextAlignmentCenter;
        _countLable.textColor = [UIColor whiteColor];
        _countLable.backgroundColor = [UIColor colorWithRed:10/255.0 green:178/255.0 blue:10/255.0 alpha:1.0];
        _countLable.font = [UIFont systemFontOfSize:12];
        _countLable.layer.cornerRadius = 10;
        _countLable.hidden = true;
        _countLable.layer.masksToBounds = true;
    }
    return _countLable;
}
@end
