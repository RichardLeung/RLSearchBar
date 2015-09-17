//
//  RLCustomSearchBar.h
//  CustomSearchBarDemo
//
//  Created by RichardLeung on 15/7/15.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLCustomSearchBar;

@protocol RLCustomSearchBarDelegate <NSObject>

@optional
/**
 *  取消按钮点击
 */
-(void)searchBarButtonCancelDidClick;

/**
 *  搜索按钮点击
 *  @param str 输入信息
 */
-(void)searchBarButtonSearchDidClick:(NSString *)str;

/**
 *  开始输入
 */
-(void)searchBarTextDidBegin;

/**
 *  结束输入
 */
-(void)searchBarTextDidEnd;

/**
 *  输入信息发生变化
 *  @param str 当前输入的信息
 */
-(void)searchBarTextDidChange:(NSString *)str;

@end

@interface RLCustomSearchBar : UIView
//searchBar 背景
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
//输入框背景
@property (weak, nonatomic) IBOutlet UIView *viewTextBackground;
//左图标
@property (weak, nonatomic) IBOutlet UIImageView *imageViewMark;
//输入框
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
//右功能图标按键
@property (weak, nonatomic) IBOutlet UIButton *buttonFunc;
//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) id<RLCustomSearchBarDelegate>delelgate;
//输入框到左边的约束，方便自定义动画
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutViewLeft;
//输入框左边图标到左边的约束，方便自定义动画或者初始化设置
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutImageLeft;
//取消按钮的宽度约束（初始值为50），方便自定义动画
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutButtonCancelWidth;

//实例化方法
+ (RLCustomSearchBar *)searchBar;

//初始化方法
- (void)initWithGreenStyle;

//自定义初始化方法
- (void)initWithBackgroundColor:(UIColor *)colorBackground
            textBackgroundColor:(UIColor *)colorTextBackground
                      textColor:(UIColor *)textColor
                      tintColor:(UIColor *)tintColor
                    placeHolder:(NSString *)placeHolder
               placeHolderColor:(UIColor *)placeHolderColor
                      imageMark:(NSString *)imageMarkName
                      imageFunc:(NSString *)imageFuncName;

@end
