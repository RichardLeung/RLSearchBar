//
//  RLSearchButton.m
//  CustomSearchBarDemo
//
//  Created by 梁原 on 15/7/20.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import "RLSearchButton.h"
#import "RLCustomSearchBar.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface RLSearchButton()

@property(nonatomic,strong)RLCustomSearchBar *searchBar;
@property(nonatomic,strong)UIButton *button;

@end

@implementation RLSearchButton

+ (instancetype)searchButton{
    RLSearchButton *searchButton =[[RLSearchButton alloc]init];
    return searchButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        RLCustomSearchBar *searchBar =[RLCustomSearchBar searchBar];
        searchBar.frame =CGRectMake(0, 0, ScreenWidth, 44);
        [searchBar initWithBackgroundColor:rgba(220, 220, 220, 1)
                       textBackgroundColor:[UIColor whiteColor]
                                 textColor:[UIColor blackColor]
                                 tintColor:[UIColor lightGrayColor]
                               placeHolder:@"搜索"
                          placeHolderColor:[UIColor colorWithRed:((0xbbbbbb>>16) & 0xff)/255.0 green:((0xbbbbbb>>8) & 0xff)/255.0 blue:(0xbbbbbb & 0xff)/255.0 alpha:1]
                                 imageMark:@"search_icon_Green"
                                 imageFunc:@"search_icon_Green"];
        searchBar.layoutButtonCancelWidth.constant =0;
        searchBar.buttonCancel.hidden =YES;
        searchBar.textFieldSearch.textAlignment =NSTextAlignmentLeft;
        searchBar.layoutViewLeft.constant =5;
        searchBar.layoutImageLeft.constant =ScreenWidth*2/5;
        searchBar.buttonFunc.hidden =YES;
        [self insertSubview:searchBar atIndex:0];
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(0, 0, ScreenWidth, 44);
        button.backgroundColor =[UIColor clearColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.frame =frame;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        RLCustomSearchBar *searchBar =[RLCustomSearchBar searchBar];
        searchBar.frame =CGRectMake(0, 0, ScreenWidth, 44);
        [searchBar initWithBackgroundColor:rgba(220, 220, 220, 1)
                       textBackgroundColor:[UIColor whiteColor]
                                 textColor:[UIColor blackColor]
                                 tintColor:[UIColor lightGrayColor]
                               placeHolder:@"搜索"
                          placeHolderColor:[UIColor colorWithRed:((0xbbbbbb>>16) & 0xff)/255.0 green:((0xbbbbbb>>8) & 0xff)/255.0 blue:(0xbbbbbb & 0xff)/255.0 alpha:1]
                                 imageMark:@"search_icon_Green"
                                 imageFunc:nil];
        searchBar.layoutButtonCancelWidth.constant =0;
        searchBar.buttonCancel.hidden =YES;
        searchBar.textFieldSearch.textAlignment =NSTextAlignmentCenter;
        searchBar.layoutViewLeft.constant =5;
        [self insertSubview:searchBar atIndex:0];
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(0, 0, ScreenWidth, 44);
        button.backgroundColor =[UIColor clearColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

    }
    return self;
}

-(void)buttonClick:(UIButton *)button{
    if ([self.delelgate respondsToSelector:@selector(searchButtonClick)]) {
        [self.delelgate searchButtonClick];
    }
}

@end
