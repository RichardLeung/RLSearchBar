//
//  RLSearchView.h
//  CustomSearchBarDemo
//
//  Created by 梁原 on 15/7/16.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLCustomSearchBar.h"

typedef void(^RLSearchViewChangeBlock)(NSString *str);

@interface RLSearchView : UIView

@property(nonatomic,strong)RLCustomSearchBar *searchBar;

@property(nonatomic,strong)UIView *navigationView;

@property(nonatomic,strong)RLSearchViewChangeBlock blockChange;

@property(nonatomic,strong)UITableView *tableViewDisplay;

- (instancetype)initWithCallBack:(RLSearchViewChangeBlock)blockChange;

-(void)show;

@end
