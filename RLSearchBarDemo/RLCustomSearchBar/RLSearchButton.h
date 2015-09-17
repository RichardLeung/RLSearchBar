//
//  RLSearchButton.h
//  CustomSearchBarDemo
//
//  Created by 梁原 on 15/7/20.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RLSearchButtonDelegate <NSObject>

-(void)searchButtonClick;

@end

@interface RLSearchButton : UIView

@property(nonatomic,weak)id<RLSearchButtonDelegate>delelgate;

@end
