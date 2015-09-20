//
//  RLCustomSearchViewController.m
//  CustomSearchBarDemo
//
//  Created by RichardLeung on 15/7/15.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import "RLCustomSearchViewController.h"
#import "RLSearchRecordCell.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface RLCustomSearchViewController ()<RLCustomSearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *navigationView;

@property(nonatomic,strong)UIView *containView;

@property(strong,nonatomic)UITableView *tableViewList;

@property(nonatomic,strong)NSMutableArray *arrayList;

@property(nonatomic,strong)NSString *tableName;

@property(nonatomic,strong)NSString *dbName;

@property(nonatomic)BOOL isNavHidden;

@property(nonatomic)BOOL isLoaded;

@end

@implementation RLCustomSearchViewController

- (instancetype)initWithCurrentViewController:(UIViewController *)viewController
                                     delegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.delegate =delegate;
        self.view.hidden =YES;
        [viewController addChildViewController:self];
        [viewController.view addSubview:self.view];
    }
    return self;
}

-(void)show{
    self.view.hidden =NO;
    [self.view setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _isNavHidden =self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [_tableViewList reloadData];
    _searchBar.textFieldSearch.textAlignment =NSTextAlignmentLeft;
    [_searchBar.textFieldSearch becomeFirstResponder];
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_navigationView setFrame:CGRectMake(0, 0, ScreenWidth, 64)];
                         _searchBar.layoutViewLeft.constant =5;
                         _searchBar.viewBackground.alpha =1;
                         [_searchBar setNeedsUpdateConstraints];
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         
                     }];
}

-(void)dismiss{
    [self.searchBar.textFieldSearch resignFirstResponder];
    self.view.hidden =YES;
    [self.navigationController setNavigationBarHidden:_isNavHidden animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isLoaded ==YES) {
        if (self.view.hidden ==NO) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }else{
            [self.navigationController setNavigationBarHidden:_isNavHidden animated:YES];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    _isLoaded =YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:_isNavHidden animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDefaultData];
    [self createCustomSearchBar];
    [self createTableView];
    [self createBottomView];
    
    NSLog(@"%@",self.delegate);

    if (_bottomView) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

-(void)createBottomView{
    if ([self.delegate respondsToSelector:@selector(searchViewControllerBuildBottomView:)]) {
        if ([self.delegate searchViewControllerBuildBottomView:self]) {
            _bottomView =(UIView *)[self.delegate searchViewControllerBuildBottomView:self];
            _bottomView.frame =CGRectMake(0, ScreenHeight-50, ScreenWidth, 50);
            [self.view addSubview:_bottomView];
            _containView.frame =CGRectMake(0, _navigationView.frame.size.height, ScreenWidth, ScreenHeight-_navigationView.frame.size.height-50);
            _tableViewDisplay.frame =_containView.bounds;
        }
    }
}


-(void)createTableView{
    _containView =[[UIView alloc]initWithFrame:CGRectMake(0, _navigationView.frame.size.height, ScreenWidth, ScreenHeight-_navigationView.frame.size.height)];
    [self.view addSubview:_containView];

    
    _tableViewDisplay =[[UITableView alloc]initWithFrame:_containView.bounds style:UITableViewStylePlain];
    _tableViewDisplay.tableFooterView =[[UIView alloc]init];
    [_containView addSubview:_tableViewDisplay];
}

-(void)dealloc{
    if ([self.delegate respondsToSelector:@selector(searchViewControllerBuildBottomView:)]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

-(void)initDefaultData{
    _isLoaded =NO;
}


-(void)createCustomSearchBar{
    _navigationView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navigationView.backgroundColor =rgba(220, 220, 220, 1);
    [self.view addSubview:_navigationView];

    _searchBar =[RLCustomSearchBar searchBar];
    _searchBar.frame =CGRectMake(0, 20, ScreenWidth, 44);
    [_searchBar initWithBackgroundColor:rgba(220, 220, 220, 1)
                    textBackgroundColor:[UIColor whiteColor]
                              textColor:[UIColor blackColor]
                              tintColor:[UIColor lightGrayColor]
                            placeHolder:@"搜索"
                       placeHolderColor:[UIColor colorWithRed:((0xbbbbbb>>16) & 0xff)/255.0 green:((0xbbbbbb>>8) & 0xff)/255.0 blue:(0xbbbbbb & 0xff)/255.0 alpha:1]
                              imageMark:@"search_icon_Green"
                              imageFunc:nil];
    _searchBar.delelgate =self;
    _searchBar.textFieldSearch.textAlignment =NSTextAlignmentCenter;
    [_navigationView addSubview:_searchBar];
}

-(void)buttonFuncClick:(UIButton *)button{
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary * info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    float y =[[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    NSLog(@"键盘高度改变, 键盘 width = %f, height = %f~~~~~~~~~~~~~~%f",
          kbSize.width, kbSize.height,y);
    // 在这里调整UI位置
    if (_bottomView) {
        [UIView animateWithDuration:0.25 animations:^{
            _bottomView.frame =CGRectMake(0, y-50, ScreenWidth, 50);
        }];
    }
}

-(void)buttonCancelClick:(UIButton *)button{
    [_searchBar.textFieldSearch resignFirstResponder];
    [self dismiss];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    NSDictionary * info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    float y =[[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    NSLog(@"键盘高度改变, 键盘 width = %f, height = %f~~~~~~~~~~~~~~%f",
          kbSize.width, kbSize.height,y);
    if (_bottomView) {
        
        [UIView animateWithDuration:0.25 animations:^{
            _bottomView.frame =CGRectMake(0, y-50, ScreenWidth, 50);
        }];
    }
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar.textFieldSearch resignFirstResponder];
}

#pragma mark -RLCustomSearchDelegate
/**
 *  取消按钮点击
 */
-(void)searchBarButtonCancelDidClick{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(searchViewControllerButtonCancelClick)]) {
        [self.delegate searchViewControllerButtonCancelClick];
    }
   
}

/**
 *  搜索按钮点击
 *  @param str 输入信息
 */
-(void)searchBarButtonSearchDidClick:(NSString *)str{
    if ([self.delegate respondsToSelector:@selector(searchViewControllerFinish:)]) {
        [self.delegate searchViewControllerFinish:str];
    }
    [_tableViewList reloadData];
}


-(void)searchBarTextDidBegin{
    NSLog(@"开始编辑");
}

-(void)searchBarTextDidChange:(NSString *)str{
    if ([self.delegate respondsToSelector:@selector(searchViewControllerTextDidChange:)]) {
        [self.delegate searchViewControllerTextDidChange:str];
    }
    NSLog(@"当前输入：%@",str);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
