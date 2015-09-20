//
//  RLCustomSearchViewController.h
//  CustomSearchBarDemo
//
//  Created by RichardLeung on 15/7/15.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLCustomSearchBar.h"

@class RLCustomSearchViewController;

@protocol RLCustomSearchViewControllerDelegate <NSObject>

@optional
/**
 *  添加搜索时显示的自定义底部工具视图的代理方法
 *
 *  @param searchViewController
 *
 *  @return
 */
-(UIView *)searchViewControllerBuildBottomView:(RLCustomSearchViewController *)searchViewController;

/**
 *  当完成输入按下搜索键时的回调方法
 *
 *  @param str 输入内容
 */
-(void)searchViewControllerFinish:(NSString *)str;

/**
 *  当输入框内容发生变化时的回调方法
 *
 *  @param str 输入内容
 */
-(void)searchViewControllerTextDidChange:(NSString *)str;

/**
 *  当按下取消按钮时的回调方法
 */
-(void)searchViewControllerButtonCancelClick;

@end

@interface RLCustomSearchViewController : UIViewController

//自定义的SearchBar
@property(nonatomic,strong)RLCustomSearchBar *searchBar;

@property(nonatomic,strong)UITableView *tableViewDisplay;

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,weak)id<RLCustomSearchViewControllerDelegate>delegate;


- (instancetype)initWithCurrentViewController:(UIViewController *)viewController
                                     delegate:(id)delegate;



-(void)show;

-(void)dismiss;

@end
