//
//  RLSearchView.m
//  CustomSearchBarDemo
//
//  Created by 梁原 on 15/7/16.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import "RLSearchView.h"

#import "RLCustomSearchBar.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface RLSearchView()<RLCustomSearchBarDelegate>

@end

@implementation RLSearchView

- (instancetype)initWithCallBack:(RLSearchViewChangeBlock)blockChange;
{
    self = [super init];
    if (self) {
        self.blockChange =blockChange;
        self.backgroundColor =[UIColor clearColor];
        _navigationView =[[UIView alloc]initWithFrame:CGRectMake(0, -64, ScreenWidth, 64)];
        _navigationView.backgroundColor =rgba(45, 185, 105, 1);
;
        [self addSubview:_navigationView];
        
        _searchBar =[RLCustomSearchBar searchBar];
        [_searchBar initWithGreenStyle];
        _searchBar.backgroundColor =[UIColor whiteColor];
        _searchBar.frame =CGRectMake(0, 20, ScreenWidth, 44);
        _searchBar.delelgate =self;
        [_navigationView addSubview:_searchBar];
                
        self.tableViewDisplay =[[UITableView alloc]initWithFrame:CGRectMake(0, _navigationView.frame.size.height, ScreenWidth, ScreenHeight-_navigationView.frame.size.height) style:UITableViewStyleGrouped];
        [self addSubview:self.tableViewDisplay];
        [self.tableViewDisplay registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellSearchID"];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [_searchBar.buttonCancel addTarget:self action:@selector(buttonCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary * info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    float y =[[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    NSLog(@"keyboard changed, keyboard width = %f, height = %f~~~~~~~~~~~~~~%f",
          kbSize.width, kbSize.height,y);
    // 在这里调整UI位置
}

-(void)buttonCancelClick:(UIButton *)button{
    
    [_searchBar.textFieldSearch resignFirstResponder];
    [self dismiss];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    NSDictionary * info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    float y =[[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    NSLog(@"keyboard changed, keyboard width = %f, height = %f~~~~~~~~~~~~~~%f",
          kbSize.width, kbSize.height,y);
}

-(void)showNavigationView{
    [_navigationView setFrame:CGRectMake(0, 0, ScreenWidth, 64)];
}

-(void)hideNavigationView{
    [_navigationView setFrame:CGRectMake(0, -64, ScreenWidth, 64)];
}



-(void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self setFrame:window.bounds];
    [window addSubview:self];
    self.alpha = 0;
    [self.searchBar.textFieldSearch becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha =1;
        [self showNavigationView];
    }completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss{
    [self.searchBar.textFieldSearch resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        [self hideNavigationView];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha =0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

-(void)searchBarTextDidChange:(NSString *)str{
    NSLog(@"%@",str);
    self.blockChange(str);
}

@end
