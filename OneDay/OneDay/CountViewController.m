//
//  CountViewController.m
//  OneDay
//
//  Created by sw on 2020/4/25.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "CountViewController.h"
#import "Masonry.h"
#import "FzhDrawChart.h"
#import "AFNetworking.h"
#import "listDiaryViewController.h"
#import "PGBarChart.h"
@interface CountViewController ()<PGBarChartDelegate, PGBarChartDataSource>
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
    

    _weatherView = [[UIView alloc] init];
  //  _weatherView.backgroundColor = [UIColor blackColor];
    [_scrollView addSubview:_weatherView];
    [_weatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView).offset(37);
        make.top.equalTo(dateView).offset(266);
        make.size.mas_equalTo(CGSizeMake(341, 188));
    }];
    
   /*
    //天气分布
    UIView *weatherView = [[UIView alloc] init];
    weatherView.backgroundColor = [UIColor whiteColor];
    weatherView.layer.shadowColor=[UIColor grayColor].CGColor;
    weatherView.layer.shadowOpacity=0.8;
    weatherView.layer.shadowRadius=5;
    weatherView.layer.shadowOffset=CGSizeMake(1, 2);
    [scrollView addSubview:weatherView];
    [weatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(37);
        make.top.equalTo(dateView).offset(266);
        make.size.mas_equalTo(CGSizeMake(341, 188));
    }];
    UILabel *weatherLabel=[[UILabel alloc]init];
    weatherLabel.text=@"天气分布";
    weatherLabel.font=[UIFont systemFontOfSize:13];
    [weatherView addSubview:weatherLabel];
    [weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weatherView);
        make.top.equalTo(weatherView).offset(12);
        make.size.mas_equalTo(CGSizeMake(55, 23));
    }];
    self.weatherDrawView = [[FzhDrawChart alloc]initWithFrame:CGRectMake(30, 45, 300, 120)];
    self.weatherDrawView.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:self.weatherDrawView];
    
    //事件分布
    UIView *eventView = [[UIView alloc] init];
    eventView.backgroundColor = [UIColor whiteColor];
    eventView.layer.shadowColor=[UIColor grayColor].CGColor;
    eventView.layer.shadowOpacity=0.8;
    eventView.layer.shadowRadius=5;
    eventView.layer.shadowOffset=CGSizeMake(1, 2);
    
    [scrollView addSubview:eventView];
    [eventView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(37);
        make.top.equalTo(weatherView).offset(204);
        make.size.mas_equalTo(CGSizeMake(341, 188));
    }];
    UILabel *eventLabel=[[UILabel alloc]init];
    eventLabel.text=@"事件分布";
    eventLabel.font=[UIFont systemFontOfSize:13];
    [eventView addSubview:eventLabel];
    [eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(eventView);
        make.top.equalTo(eventView).offset(12);
        make.size.mas_equalTo(CGSizeMake(55, 23));
    }];
    self.eventDrawView = [[FzhDrawChart alloc]initWithFrame:CGRectMake(30, 45, 300, 120)];
    self.eventDrawView.backgroundColor = [UIColor clearColor];
    [eventView addSubview:self.eventDrawView];
    
    
    //心情分布
    UIView *moodView = [[UIView alloc] init];
    moodView.backgroundColor = [UIColor whiteColor];
   
    moodView.layer.shadowColor=[UIColor grayColor].CGColor;
    moodView.layer.shadowOpacity=0.8;
    moodView.layer.shadowRadius=5;
    moodView.layer.shadowOffset=CGSizeMake(1, 2);
    [scrollView addSubview:moodView];
    [moodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(37);
        make.top.equalTo(eventView).offset(204);
        make.size.mas_equalTo(CGSizeMake(341, 188));
    }];
    UILabel *moodLabel=[[UILabel alloc]init];
    moodLabel.text=@"心情分布";
    moodLabel.font=[UIFont systemFontOfSize:13];
    [moodView addSubview:moodLabel];
    [moodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(moodView);
        make.top.equalTo(moodView).offset(12);
        make.size.mas_equalTo(CGSizeMake(55, 23));
    }];
    self.moodDrawView = [[FzhDrawChart alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-120, 25, 150, 180)];
    self.moodDrawView.backgroundColor = [UIColor clearColor];
    [moodView addSubview:self.moodDrawView];
    [self draw];
*/
}

/*
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
        
    
        [self.weatherDrawView drawZhuZhuangTu:_weathkeyArray and:_weathvalueArray];
        
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
        
        [self.eventDrawView drawZhuZhuangTu:_eventkeyArray and:_eventvalueArray];
        
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
      [self.moodDrawView drawBingZhuangTu:_moodkeyArray and:_moodvalueArray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
    }];

    
    
    
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    [self loadWithDate:_currentDate];
   // [self draw];
    
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
            [button addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchDown];
            //获取日期 判断是否在网络请求的数组中
            NSString *datestr=[NSString stringWithFormat:@"%zd-%02ld-%02d",[self getCurrentYear:date],(long)[self getCurrentMonth:date],i];
            if ([_dateArray containsObject:datestr])
            {
                button.backgroundColor =[UIColor grayColor];
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
    NSString *str=[NSString stringWithFormat:@"%zd-%02ld-%02d",[self getCurrentYear:_currentDate],(long)[self getCurrentMonth:_currentDate],day];
    listDiaryViewController *vc=[[listDiaryViewController alloc]init];
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
