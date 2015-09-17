//
//  SecondViewController.m
//  RLSearchBarDemo
//
//  Created by RichardLeung on 15/9/17.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import "SecondViewController.h"
#import "RLSearchView.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTitle:@"QQ音乐"];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:rgba(45, 185, 105, 1) size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self createRightButton:@"查找" withDone:@"buttonClick" withImageName:nil];
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

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


-(void)buttonClick{
    RLSearchView *searchView =[[RLSearchView alloc]initWithCallBack:^(NSString *str) {

    }];
    searchView.tableViewDisplay.delegate =self;
    [searchView.tableViewDisplay registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellSearchID"];
    [searchView show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==_tableView) {
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        cell.textLabel.text =@"测试信息（首页）";
        return cell;
    }else{
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellSearchID" forIndexPath:indexPath];
        cell.textLabel.text =@"测试信息（搜索）";
        return cell;
    }
    
}

//右按钮
- (void)createRightButton:(NSString *)Btntitle withDone:(NSString *)DoneFunction withImageName:(NSString *)imageName
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * img = nil;
    UIImage * img2 = nil;
    if(!imageName){
        img = [UIImage imageNamed:@""];
    }else{
        img = [UIImage imageNamed:imageName];
        img2 = [UIImage imageNamed:[NSString stringWithFormat:@"%@_pressed",imageName]];
    }
    img = [img stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    [button setBackgroundImage:img2 forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; //Btn 的字体颜色
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:Btntitle forState:UIControlStateNormal];
    if (Btntitle && ![Btntitle isEqualToString:@""])
    {
        CGSize size;
        NSDictionary* dic =@{NSFontAttributeName: button.titleLabel.font};
        size = [button.titleLabel.text boundingRectWithSize:CGSizeMake(100, 100)  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        if (size.width < 40)
        {
            size.width = 40;
        }
        button.frame = CGRectMake(0, 0, size.width + 10, 30);
    }
    [button setBackgroundImage:img forState:UIControlStateNormal];
    button.titleLabel.font =[UIFont systemFontOfSize:17];
    button.adjustsImageWhenHighlighted = NO;
    SEL func = NSSelectorFromString(DoneFunction);
    [button addTarget:self action:func forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                        target:nil
                                        action:nil];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,rightBarButton, nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
