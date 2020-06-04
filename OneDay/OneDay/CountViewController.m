//
//  CountViewController.m
//  OneDay
//
//  Created by sw on 2020/4/25.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "CountViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "listDiaryViewController.h"
#import "JChartView.h"
@interface CountViewController ()
@property (nonatomic, weak) UIView *dateView;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) NSInteger firstDays;

@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSArray *diaryArray;

@property(nonatomic,strong)NSDate *currentDate;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic)UIView *weatherView;
@property (nonatomic, strong) NSMutableArray *weathvalueArray;
@property (nonatomic, strong) NSMutableArray *weathkeyArray;
@property (nonatomic, strong) NSMutableArray *moodvalueArray;
@property (nonatomic, strong) NSMutableArray *moodkeyArray;
@property (nonatomic, strong) NSMutableArray *eventvalueArray;
@property (nonatomic, strong) NSMutableArray *eventkeyArray;






@end
#define PGColor(r,g,b) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f]


@implementation CountViewController
- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}


- (NSMutableArray *)dateArray {
    if (!_dateArray) {
        
        _dateArray = [NSMutableArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    }
    return _dateArray;
}

// 获取日
- (NSInteger)getCurrentDay:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger day = [components day];
    return day;
}

// 获取月
- (NSInteger)getCurrentMonth:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger month = [components month];
    return month;
}

// 获取年
- (NSInteger)getCurrentYear:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger year = [components year];
    return year;
}

// 一个月有多少天
- (NSInteger)getTotalDaysInMonth:(NSDate *)date {
    
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

// 每月第一天
- (NSInteger)getFirstDayOfMonth:(NSDate *)date {
    
    NSInteger firstDayOfMonth = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    return firstDayOfMonth;
}

// 上个月
- (NSDate *)lastMonth:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

// 下个月
- (NSDate *)nextMonth:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate *)lastYear:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
- (NSDate *)nextYear:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"日记小结";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];

    //日历
    _currentDate=[NSDate date];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(61);
        make.height.mas_equalTo(57);
    }];
    //前一个月
    UIButton *preMBtn = [[UIButton alloc] init];
    [preMBtn setTitle:@"<" forState:UIControlStateNormal];
    [preMBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [preMBtn addTarget:self action:@selector(preMBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:preMBtn];
    [preMBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.left.equalTo(titleView).offset(80);
        make.centerY.equalTo(titleView);
    }];
    UIButton *preYBtn = [[UIButton alloc] init];
    [preYBtn setTitle:@"<<" forState:UIControlStateNormal];
    [preYBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [preYBtn addTarget:self action:@selector(preYBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:preYBtn];
    [preYBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.left.equalTo(titleView).offset(44);
        make.centerY.equalTo(titleView);
    }];
    
    //后一个月
    UIButton *nextMBtn = [[UIButton alloc] init];
    [nextMBtn setTitle:@">" forState:UIControlStateNormal];
    [nextMBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [nextMBtn addTarget:self action:@selector(nextMBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:nextMBtn];
    [nextMBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.right.equalTo(titleView).offset(-80);
        make.centerY.equalTo(titleView);
    }];
    UIButton *nextYBtn = [[UIButton alloc] init];
    [nextYBtn setTitle:@">>" forState:UIControlStateNormal];
    [nextYBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextYBtn addTarget:self action:@selector(nextYBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:nextYBtn];
    [nextYBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.right.equalTo(titleView).offset(-44);
        make.centerY.equalTo(titleView);
    }];

    //时间标签
    UILabel *titleLable = [[UILabel alloc] init];
    
    titleLable.text =[NSString stringWithFormat:@"%zd年%zd月%zd日",[self getCurrentYear:_currentDate],[self getCurrentMonth:_currentDate],[self getCurrentDay:_currentDate]];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = [UIColor blackColor];
    [titleView addSubview:titleLable];
    self.titleLable=titleLable;
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 40));
        make.centerX.equalTo(titleView);
        make.centerY.equalTo(titleView);
    }];
    _scrollView=[[UIScrollView alloc]init];
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+120);
    
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(118);
        make.bottom.equalTo(self.view);
    }];
    
    UIView *dateView = [[UIView alloc] init];
    dateView.backgroundColor = [UIColor whiteColor];
    dateView.layer.shadowColor=[UIColor grayColor].CGColor;
    dateView.layer.shadowOpacity=0.8;
    dateView.layer.shadowRadius=5;
    dateView.layer.shadowOffset=CGSizeMake(1, 2);
    [_scrollView addSubview:dateView];
    [dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView).offset(37);
        make.top.equalTo(_scrollView).offset(5);
        make.size.mas_equalTo(CGSizeMake(341, 250));
    }];
    self.dateView=dateView;
    for (int i = 0; i < self.dateArray.count; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20+i*40, 28, 40, 28)];
        label.text = self.dateArray[i];
        label.textColor =[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [dateView addSubview:label];
    }
    [self loadWithDate:_currentDate];
    
    //统计
    [self draw];
}


-(void)draw
{
    _phone=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSDictionary *dic1=@{
                         @"phone":_phone,
                         };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager1 POST:@"http://localhost:8080/OneDay/diary/weather" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=responseObject;
        NSLog(@"%@",dic);
        _weathvalueArray=[[NSMutableArray alloc]init];
        _weathkeyArray=[[NSMutableArray alloc]init];
        NSArray *arrkeys=[dic allKeys];
        for (int i=0; i<arrkeys.count; i++)
        {
            NSString *key=arrkeys[i];
            NSString *value=[dic valueForKey:key];
            [_weathkeyArray addObject:key];
            [_weathvalueArray addObject:value];
        }
        JChartView* chartView = [[JChartView alloc] initWithFrame:CGRectMake(37, 266, 341, 188)];
        chartView.backgroundColor = [UIColor whiteColor];
        chartView.warningColor = [UIColor colorWithRed:124/255.0 green:228/255.0 blue:255/255.0 alpha:1];
        chartView.warningValue = 100;
        chartView.xyLineColor = [UIColor colorWithRed:178/255.0 green:255/255.0 blue:156/255.0 alpha:1];
        chartView.perWidth = 45;
        chartView.cylindColor = [UIColor colorWithRed:124/255.0 green:228/255.0 blue:255/255.0 alpha:1];
        chartView.maxValue = 100;
        chartView.lineChartYLabelArray = @[@"0",@"25",@"50",@"75",@"100"];
        chartView.lineChartXLabelArray =_weathkeyArray;
        chartView.lineChartDataArray = _weathvalueArray;
        [_scrollView addSubview:chartView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
    }];
    
    

    NSDictionary *dic2=@{
                         @"phone":_phone,
                         };
    AFHTTPSessionManager *manager2=[AFHTTPSessionManager manager];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager2 POST:@"http://localhost:8080/OneDay/diary/event" parameters:dic2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=responseObject;
        NSLog(@"%@",dic);
        _eventvalueArray=[[NSMutableArray alloc]init];
        _eventkeyArray=[[NSMutableArray alloc]init];
        NSArray *arrkeys=[dic allKeys];
        for (int i=0; i<arrkeys.count; i++)
        {
            NSString *key=arrkeys[i];
            NSString *value=[dic valueForKey:key];
            [_eventkeyArray addObject:key];
            [_eventvalueArray addObject:value];
        }
        JChartView* chartView = [[JChartView alloc] initWithFrame:CGRectMake(37, 464, 341, 188)];
               chartView.backgroundColor = [UIColor whiteColor];
               chartView.warningColor = [UIColor colorWithRed:124/255.0 green:228/255.0 blue:255/255.0 alpha:1];
               chartView.warningValue = 100;
               chartView.xyLineColor = [UIColor colorWithRed:178/255.0 green:255/255.0 blue:156/255.0 alpha:1];
               chartView.perWidth = 45;
               chartView.cylindColor = [UIColor colorWithRed:124/255.0 green:228/255.0 blue:255/255.0 alpha:1];
               chartView.maxValue = 100;
               chartView.lineChartYLabelArray = @[@"0",@"25",@"50",@"75",@"100"];
               chartView.lineChartXLabelArray =_eventkeyArray;
               chartView.lineChartDataArray = _eventvalueArray;
               [_scrollView addSubview:chartView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
    }];
    
    
    NSDictionary *dic3=@{
                         @"phone":_phone,
                         };
    AFHTTPSessionManager *manager3=[AFHTTPSessionManager manager];
    manager3.requestSerializer = [AFJSONRequestSerializer serializer];
    manager3.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager3 POST:@"http://localhost:8080/OneDay/diary/weather" parameters:dic3 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=responseObject;
        NSLog(@"%@",dic);
        _moodvalueArray=[[NSMutableArray alloc]init];
        _moodkeyArray=[[NSMutableArray alloc]init];
        NSArray *arrkeys=[dic allKeys];
        for (int i=0; i<arrkeys.count; i++)
        {
            NSString *key=arrkeys[i];
            NSString *value=[dic valueForKey:key];
            [_moodkeyArray addObject:key];
            [_moodvalueArray addObject:value];
        }
        JChartView* chartView = [[JChartView alloc] initWithFrame:CGRectMake(37, 662, 341, 188)];
                      chartView.backgroundColor = [UIColor whiteColor];
                      chartView.warningColor = [UIColor colorWithRed:124/255.0 green:228/255.0 blue:255/255.0 alpha:1];
                      chartView.warningValue = 100;
                      chartView.xyLineColor = [UIColor colorWithRed:178/255.0 green:255/255.0 blue:156/255.0 alpha:1];
                      chartView.perWidth = 45;
                      chartView.cylindColor = [UIColor colorWithRed:124/255.0 green:228/255.0 blue:255/255.0 alpha:1];
                      chartView.maxValue = 100;
                      chartView.lineChartYLabelArray = @[@"0",@"25",@"50",@"75",@"100"];
                      chartView.lineChartXLabelArray =_eventkeyArray;
                      chartView.lineChartDataArray = _eventvalueArray;
                      [_scrollView addSubview:chartView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
    }];

    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    [self loadWithDate:_currentDate];
    [self draw];
    
}
- (void)loadWithDate:(NSDate *)date {
    
    // 移除所有
    if (self.buttonArray) {
        [self.buttonArray removeAllObjects];
    }
    
    if (self.dateView.subviews.count > 0)//移除之前的日期
    {
        for(UIView *mylabelview in [self.dateView subviews])
        {
            if ([mylabelview isKindOfClass:[UIButton class]]) {
                [mylabelview removeFromSuperview];
            }
        }
    }
 
    // 获取当月有多少天
    _days = [self getTotalDaysInMonth:date];
    _firstDays = [self getFirstDayOfMonth:date];
    
    self.titleLable.text = [NSString stringWithFormat:@"%zd年%zd月%zd日",[self getCurrentYear:date],[self getCurrentMonth:date],[self getCurrentDay:date]];
    
    NSInteger row = (_firstDays % 7 + _days + 6) / 7;
    NSInteger colum = 7;
    CGFloat buttonH = 28;
    CGFloat buttonW = 42;
   
    
    _phone=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSDictionary *dic1=@{
                         @"phone":_phone,
                         };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager1 POST:@"http://localhost:8080/OneDay/diary/dates" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dateArray=responseObject;
        for (int i = 1; i <= _days; i++)
        {
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:[NSString stringWithFormat:@"%zd",i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:12];
            //获取日期 判断是否在网络请求的数组中
            NSString *datestr=[NSString stringWithFormat:@"%zd-%02ld-%02d",[self getCurrentYear:date],(long)[self getCurrentMonth:date],i];
            if ([_dateArray containsObject:datestr])
            {
                [button addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchDown];
                button.layer.masksToBounds=YES;
                button.layer.cornerRadius=10;
                button.backgroundColor =[UIColor colorWithRed:124/255.0 green:228/255.0 blue:255/255.0 alpha:0.7];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
            [self.dateView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.dateView).offset(20+(_firstDays % 7 + i) % colum * buttonW);
                make.top.equalTo(self.dateView).offset(56+(_firstDays % 7 + i) / colum * buttonH);
                make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
            }];
            [self.buttonArray addObject:button];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
    }];
    

}
-(void)search:(UIButton *)btn//按日期查询
{
    NSInteger day=[btn.titleLabel.text integerValue];
    NSString *str=[NSString stringWithFormat:@"%zd-%02ld-%02ld",[self getCurrentYear:_currentDate],(long)[self getCurrentMonth:_currentDate],(long)day];
    NSLog(@"这篇日记的日期是：%@",str);
    listDiaryViewController *vc=[[listDiaryViewController alloc]init];
    vc.draft=false;
    vc.date=str;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)preMBtnClick
{
    
    NSDate *preDate = [self lastMonth:_currentDate];
    [self loadWithDate:preDate];
    
    [self.view setNeedsLayout];
    
    _currentDate = preDate;
    
}
- (void)preYBtnClick
{
    
    NSDate *preDate = [self lastYear:_currentDate];
    [self loadWithDate:preDate];
    
    [self.view setNeedsLayout];
    
    _currentDate = preDate;
    
}
- (void)nextYBtnClick {
    
    NSDate *nextDate = [self nextYear:_currentDate];
    [self loadWithDate:nextDate];
    
    [self.view setNeedsLayout];//可以修改
    
    _currentDate = nextDate;
}
- (void)nextMBtnClick {
    
    NSDate *nextDate = [self nextMonth:_currentDate];
    [self loadWithDate:nextDate];
    
    [self.view setNeedsLayout];//可以修改
    
    _currentDate = nextDate;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
