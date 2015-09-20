//
//  FirstViewController.m
//  RLSearchBarDemo
//
//  Created by RichardLeung on 15/9/17.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import "FirstViewController.h"
#import "RLSearchButton.h"
#import "RLCustomSearchViewController.h"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,RLSearchButtonDelegate,RLCustomSearchViewControllerDelegate>

@property (weak,  nonatomic)IBOutlet UITableView *tableView;
@property (nonatomic,strong)RLSearchButton * mySearchBar;
@property (nonatomic,strong)RLCustomSearchViewController *searchVC;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self createTitle:@"仿原生"];
    [self createSearchBar];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
}

-(void)createTitle:(NSString *)title{
    self.title =title;
    UILabel *labelTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.text = title;
    labelTitle.font = [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = labelTitle;
}

-(void)createSearchBar{
    self.mySearchBar =[[RLSearchButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.mySearchBar.delelgate =self;
    self.tableView.tableHeaderView =self.mySearchBar;
    
    
    _searchVC =[[RLCustomSearchViewController alloc]initWithCurrentViewController:self
                                                      delegate:self];
    _searchVC.tableViewDisplay.delegate =self;
    _searchVC.tableViewDisplay.dataSource =self;
    [_searchVC.tableViewDisplay registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellSearchID"];
}

#pragma mark - RLSearchButtonDelegate
-(void)searchButtonClick{
    [_searchVC show];
    _searchVC.searchBar.textFieldSearch.text =nil;
}


#pragma mark - RLCustomSearchViewControllerDelegate
-(UIView *)searchViewControllerBuildBottomView:(RLCustomSearchViewController *)searchViewController{
    return nil;
}

-(void)searchViewControllerFinish:(NSString *)str{
    [_searchVC.tableViewDisplay reloadData];
}

-(void)searchViewControllerTextDidChange:(NSString *)str{
    [_searchVC.tableViewDisplay reloadData];
}

-(void)searchViewControllerButtonCancelClick{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_searchVC.tableViewDisplay]) {
        
        return 1;
    }
    else if ([tableView isEqual:self.tableView])
    {
        return 1;
        
    }else{
        
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==_tableView ) {
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        cell.textLabel.text =@"测试信息（首页）";
        return cell;
        
    }else{
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellSearchID" forIndexPath:indexPath];
        
        cell.textLabel.text =@"测试信息（搜索页）";
        return cell;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
