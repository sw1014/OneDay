//
//  SearchDiaryViewController.m
//  OneDay
//
//  Created by sw on 2020/4/26.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "SearchDiaryViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "Diary.h"
#import "listDiaryViewController.h"
@interface SearchDiaryViewController ()
@property(nonatomic)UITextField *searcTF;
@property(nonatomic)NSString *weather;
@property(nonatomic)NSString *mood;
@property(nonatomic)NSString *event;
@property(nonatomic)UIButton *weatherbtn1;
@property(nonatomic)UIButton *weatherbtn2;
@property(nonatomic)UIButton *weatherbtn3;
@property(nonatomic)UIButton *weatherbtn4;
@property(nonatomic)UIButton *weatherbtn5;
@property(nonatomic)UIButton *weatherbtn6;
@property(nonatomic)UIButton *moodbtn1;
@property(nonatomic)UIButton *moodbtn2;
@property(nonatomic)UIButton *moodbtn3;
@property(nonatomic)UIButton *moodbtn4;
@property(nonatomic)UIButton *moodbtn5;
@property(nonatomic)UIButton *moodbtn6;
@property(nonatomic)UIButton *eventbtn1;
@property(nonatomic)UIButton *eventbtn2;
@property(nonatomic)UIButton *eventbtn3;
@property(nonatomic)UIButton *eventbtn4;
@property(nonatomic)UIButton *eventbtn5;
@property(nonatomic)UIButton *eventbtn6;
@end

@implementation SearchDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title=@"";
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.tabBarController.tabBar.hidden=YES;
    
    _mood=@"";
    _event=@"";
    _weather=@"";
    
    _searcTF=[[UITextField alloc]init];
    _searcTF.placeholder=@"请输入标题关键词";
    _searcTF.borderStyle=UITextBorderStyleNone;
    _searcTF.text=@"";
    _searcTF.layer.borderWidth=1.0f;
    _searcTF.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    [self.view addSubview:_searcTF];
    [_searcTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(83);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(289, 41));
        
    }];
    UIButton *btn2=[[UIButton alloc]init];
    btn2.backgroundColor=[UIColor redColor];
    [btn2 setTitle:@"确认" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchDown];
    btn2.layer.cornerRadius=4;
    btn2.layer.masksToBounds=YES;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(127, 51));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(613);
    }];
    
    _weatherbtn1=[[UIButton alloc]init];
    [_weatherbtn1 setTitle:@"晴" forState:UIControlStateNormal];
    _weatherbtn1.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _weatherbtn1.layer.borderWidth=1;
    _weatherbtn1.layer.masksToBounds=YES;
    _weatherbtn1.layer.cornerRadius=4;
    [_weatherbtn1 addTarget:self action:@selector(changecolor1:) forControlEvents:UIControlEventTouchDown];
     [_weatherbtn1 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_weatherbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _weatherbtn1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_weatherbtn1];
    [_weatherbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(42, 30));
        make.left.equalTo(self.view).offset(31);
        make.top.equalTo(self.view).offset(329);
    }];
    _weatherbtn2=[[UIButton alloc]init];
    _weatherbtn2.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _weatherbtn2.layer.borderWidth=1;
    [_weatherbtn2 setTitle:@"阵雨" forState:UIControlStateNormal];
    _weatherbtn2.layer.masksToBounds=YES;
    _weatherbtn2.layer.cornerRadius=4;
    [_weatherbtn2 addTarget:self action:@selector(changecolor1:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn2 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_weatherbtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_weatherbtn2];
    [_weatherbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(224);
        make.top.equalTo(self.view).offset(329);
    }];
    _weatherbtn3=[[UIButton alloc]init];
    _weatherbtn3.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _weatherbtn3.layer.borderWidth=1;
    [_weatherbtn3 setTitle:@"晴转多云" forState:UIControlStateNormal];
    _weatherbtn3.layer.masksToBounds=YES;
    _weatherbtn3.layer.cornerRadius=4;
    [_weatherbtn3 addTarget:self action:@selector(changecolor1:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn3 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_weatherbtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_weatherbtn3];
    [_weatherbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.left.equalTo(self.view).offset(99);
        make.top.equalTo(self.view).offset(329);
    }];
    _weatherbtn4=[[UIButton alloc]init];
    _weatherbtn4.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _weatherbtn4.layer.borderWidth=1;
    _weatherbtn4.layer.masksToBounds=YES;
    [_weatherbtn4 setTitle:@"大风" forState:UIControlStateNormal];
    _weatherbtn4.layer.cornerRadius=4;
    [_weatherbtn4 addTarget:self action:@selector(changecolor1:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn4 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_weatherbtn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
  
    [self.view addSubview:_weatherbtn4];
    [_weatherbtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(311);
        make.top.equalTo(self.view).offset(329);
    }];
    _weatherbtn5=[[UIButton alloc]init];
    _weatherbtn5.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _weatherbtn5.layer.borderWidth=1;
    _weatherbtn5.layer.masksToBounds=YES;
    _weatherbtn5.layer.cornerRadius=4;
    [_weatherbtn5 setTitle:@"雾" forState:UIControlStateNormal];
    [_weatherbtn5 addTarget:self action:@selector(changecolor1:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn5 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_weatherbtn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [self.view addSubview:_weatherbtn5];
    [_weatherbtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(31);
        make.top.equalTo(self.view).offset(371);
    }];
    _weatherbtn6=[[UIButton alloc]init];
    _weatherbtn6.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _weatherbtn6.layer.borderWidth=1;
    _weatherbtn6.layer.masksToBounds=YES;
    _weatherbtn6.layer.cornerRadius=4;
    [_weatherbtn6 setTitle:@"多云" forState:UIControlStateNormal];
    [_weatherbtn6 addTarget:self action:@selector(changecolor1:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn6 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_weatherbtn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [self.view addSubview:_weatherbtn6];
    [_weatherbtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(109);
        make.top.equalTo(self.view).offset(371);
    }];
    //标签
    UILabel *weatherlabel1=[[UILabel alloc]init];
    weatherlabel1.text=@"天气选择";
    weatherlabel1.font=[UIFont systemFontOfSize:20];
    weatherlabel1.textColor=[UIColor grayColor];
    [self.view addSubview:weatherlabel1];
    [weatherlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 14));
        make.left.equalTo(self.view).offset(22);
        make.top.equalTo(self.view).offset(296);
    }];
    UILabel *moodlabel1=[[UILabel alloc]init];
    moodlabel1.text=@"心情选择";
    moodlabel1.font=[UIFont systemFontOfSize:20];
    moodlabel1.textColor=[UIColor grayColor];
    [self.view addSubview:moodlabel1];
    [moodlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 14));
        make.left.equalTo(self.view).offset(22);
        make.top.equalTo(self.view).offset(173);
    }];
    UILabel *eventlabel1=[[UILabel alloc]init];
    eventlabel1.text=@"事件选择";
    eventlabel1.font=[UIFont systemFontOfSize:20];
    eventlabel1.textColor=[UIColor grayColor];
    [self.view addSubview:eventlabel1];
    [eventlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 14));
        make.left.equalTo(self.view).offset(22);
        make.top.equalTo(self.view).offset(426);
    }];
    
    _moodbtn1=[[UIButton alloc]init];
    [_moodbtn1 setTitle:@"开心" forState:UIControlStateNormal];
    _moodbtn1.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _moodbtn1.layer.borderWidth=1;
    _moodbtn1.layer.masksToBounds=YES;
    _moodbtn1.layer.cornerRadius=4;
    [_moodbtn1 addTarget:self action:@selector(changecolor2:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn1 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_moodbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn1];
    [_moodbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(31);
        make.top.equalTo(self.view).offset(209);
    }];
    _moodbtn2=[[UIButton alloc]init];
    _moodbtn2.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _moodbtn2.layer.borderWidth=1;
    [_moodbtn2 setTitle:@"惊喜" forState:UIControlStateNormal];
    _moodbtn2.layer.masksToBounds=YES;
    _moodbtn2.layer.cornerRadius=4;
    [_moodbtn2 addTarget:self action:@selector(changecolor2:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn2 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_moodbtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn2];
    [_moodbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(121);
        make.top.equalTo(self.view).offset(209);
    }];
    _moodbtn3=[[UIButton alloc]init];
    _moodbtn3.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _moodbtn3.layer.borderWidth=1;
    [_moodbtn3 setTitle:@"佛系" forState:UIControlStateNormal];
    _moodbtn3.layer.masksToBounds=YES;
    _moodbtn3.layer.cornerRadius=4;
    [_moodbtn3 addTarget:self action:@selector(changecolor2:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn3 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_moodbtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn3];
    [_moodbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(211);
        make.top.equalTo(self.view).offset(209);
    }];
    _moodbtn4=[[UIButton alloc]init];
    _moodbtn4.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _moodbtn4.layer.borderWidth=1;
    [_moodbtn4 setTitle:@"迷茫" forState:UIControlStateNormal];
    _moodbtn4.layer.masksToBounds=YES;
    _moodbtn4.layer.cornerRadius=4;
    [_moodbtn4 addTarget:self action:@selector(changecolor2:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn4 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_moodbtn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn4];
    [_moodbtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(301);
        make.top.equalTo(self.view).offset(209);
    }];
    _moodbtn5=[[UIButton alloc]init];
    _moodbtn5.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _moodbtn5.layer.borderWidth=1;
    [_moodbtn5 setTitle:@"烦躁" forState:UIControlStateNormal];
    _moodbtn5.layer.masksToBounds=YES;
    _moodbtn5.layer.cornerRadius=4;
    [_moodbtn5 addTarget:self action:@selector(changecolor2:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn5 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_moodbtn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn5];
    [_moodbtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(31);
        make.top.equalTo(self.view).offset(250);
    }];
    _moodbtn6=[[UIButton alloc]init];
    _moodbtn6.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _moodbtn6.layer.borderWidth=1;
    [_moodbtn6 setTitle:@"生气" forState:UIControlStateNormal];
    _moodbtn6.layer.masksToBounds=YES;
    _moodbtn6.layer.cornerRadius=4;
    [_moodbtn6 addTarget:self action:@selector(changecolor2:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn6 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_moodbtn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn6];
    [_moodbtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(121);
        make.top.equalTo(self.view).offset(250);
    }];
    
    
    _eventbtn1=[[UIButton alloc]init];
    [_eventbtn1 setTitle:@"学习" forState:UIControlStateNormal];
    _eventbtn1.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _eventbtn1.layer.borderWidth=1;
    _eventbtn1.layer.masksToBounds=YES;
    _eventbtn1.layer.cornerRadius=4;
    [_eventbtn1 addTarget:self action:@selector(changecolor3:) forControlEvents:UIControlEventTouchDown];
    [_eventbtn1 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_eventbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_eventbtn1];
    [_eventbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(31);
        make.top.equalTo(self.view).offset(459);
    }];
    _eventbtn2=[[UIButton alloc]init];
    _eventbtn2.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _eventbtn2.layer.borderWidth=1;
    [_eventbtn2 setTitle:@"游戏" forState:UIControlStateNormal];
    _eventbtn2.layer.masksToBounds=YES;
    _eventbtn2.layer.cornerRadius=4;
    [_eventbtn2 addTarget:self action:@selector(changecolor3:) forControlEvents:UIControlEventTouchDown];
    [_eventbtn2 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_eventbtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_eventbtn2];
    [_eventbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(121);
        make.top.equalTo(self.view).offset(459);
    }];
    _eventbtn3=[[UIButton alloc]init];
    _eventbtn3.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _eventbtn3.layer.borderWidth=1;
    [_eventbtn3 setTitle:@"美食" forState:UIControlStateNormal];
    _eventbtn3.layer.masksToBounds=YES;
    _eventbtn3.layer.cornerRadius=4;
    [_eventbtn3 addTarget:self action:@selector(changecolor3:) forControlEvents:UIControlEventTouchDown];
    [_eventbtn3 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_eventbtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_eventbtn3];
    [_eventbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(211);
        make.top.equalTo(self.view).offset(459);
    }];
    _eventbtn4=[[UIButton alloc]init];
    _eventbtn4.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _eventbtn4.layer.borderWidth=1;
    [_eventbtn4 setTitle:@"跑步" forState:UIControlStateNormal];
    _eventbtn4.layer.masksToBounds=YES;
    _eventbtn4.layer.cornerRadius=4;
    [_eventbtn4 addTarget:self action:@selector(changecolor3:) forControlEvents:UIControlEventTouchDown];
    [_eventbtn4 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_eventbtn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_eventbtn4];
    [_eventbtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(301);
        make.top.equalTo(self.view).offset(459);
    }];
    _eventbtn5=[[UIButton alloc]init];
    _eventbtn5.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _eventbtn5.layer.borderWidth=1;
    [_eventbtn5 setTitle:@"工作" forState:UIControlStateNormal];
    _eventbtn5.layer.masksToBounds=YES;
    _eventbtn5.layer.cornerRadius=4;
    [_eventbtn5 addTarget:self action:@selector(changecolor3:) forControlEvents:UIControlEventTouchDown];
    [_eventbtn5 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_eventbtn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_eventbtn5];
    [_eventbtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(31);
        make.top.equalTo(self.view).offset(500);
    }];
    _eventbtn6=[[UIButton alloc]init];
    _eventbtn6.layer.borderColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1].CGColor;
    _eventbtn6.layer.borderWidth=1;
    [_eventbtn6 setTitle:@"争吵" forState:UIControlStateNormal];
    _eventbtn6.layer.masksToBounds=YES;
    _eventbtn6.layer.cornerRadius=4;
    [_eventbtn6 addTarget:self action:@selector(changecolor3:) forControlEvents:UIControlEventTouchDown];
    [_eventbtn6 setTitleColor:[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
    [_eventbtn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.view addSubview:_eventbtn6];
    [_eventbtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(73, 30));
        make.left.equalTo(self.view).offset(121);
        make.top.equalTo(self.view).offset(500);
    }];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)changecolor2:(UIButton *)btn
{
    if (btn.selected)
    {
        btn.backgroundColor=[UIColor whiteColor];
        btn.selected=NO;
        _mood=@"";
    }
    else
    {
        _moodbtn1.selected=NO;
        _moodbtn2.selected=NO;
        _moodbtn3.selected=NO;
        _moodbtn4.selected=NO;
        _moodbtn5.selected=NO;
        _moodbtn6.selected=NO;
        _moodbtn1.backgroundColor=[UIColor whiteColor];
        _moodbtn2.backgroundColor=[UIColor whiteColor];
        _moodbtn3.backgroundColor=[UIColor whiteColor];
        _moodbtn4.backgroundColor=[UIColor whiteColor];
        _moodbtn5.backgroundColor=[UIColor whiteColor];
        _moodbtn6.backgroundColor=[UIColor whiteColor];
        btn.selected=YES;
        btn.backgroundColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1];
        _mood=btn.titleLabel.text;
    }
}
-(void)changecolor3:(UIButton *)btn
{
    if (btn.selected)
    {
        btn.backgroundColor=[UIColor whiteColor];
        btn.selected=NO;
        _event=@"";
    }
    else
    {
        _eventbtn1.selected=NO;
        _eventbtn2.selected=NO;
        _eventbtn3.selected=NO;
        _eventbtn4.selected=NO;
        _eventbtn5.selected=NO;
        _eventbtn6.selected=NO;
        _eventbtn1.backgroundColor=[UIColor whiteColor];
        _eventbtn2.backgroundColor=[UIColor whiteColor];
        _eventbtn3.backgroundColor=[UIColor whiteColor];
        _eventbtn4.backgroundColor=[UIColor whiteColor];
        _eventbtn5.backgroundColor=[UIColor whiteColor];
        _eventbtn6.backgroundColor=[UIColor whiteColor];
        btn.selected=YES;
        btn.backgroundColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1];
        _event=btn.titleLabel.text;
    }
}

-(void)changecolor1:(UIButton *)btn
{
    if (btn.selected)
    {
        btn.backgroundColor=[UIColor whiteColor];
        btn.selected=NO;
        _weather=@"";
    }
    else
    {
        _weatherbtn1.selected=NO;
        _weatherbtn2.selected=NO;
        _weatherbtn3.selected=NO;
        _weatherbtn4.selected=NO;
        _weatherbtn5.selected=NO;
        _weatherbtn6.selected=NO;
        _weatherbtn1.backgroundColor=[UIColor whiteColor];
        _weatherbtn2.backgroundColor=[UIColor whiteColor];
        _weatherbtn3.backgroundColor=[UIColor whiteColor];
        _weatherbtn4.backgroundColor=[UIColor whiteColor];
        _weatherbtn5.backgroundColor=[UIColor whiteColor];
        _weatherbtn6.backgroundColor=[UIColor whiteColor];
        btn.backgroundColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1];
        btn.selected=YES;
         _weather=btn.titleLabel.text;
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
-(void)search
{
    listDiaryViewController *vc=[[listDiaryViewController alloc]init];
    vc.draft=false;
    NSString *phone=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSString *title=_searcTF.text;
    
    NSDictionary *dic1=@{
                         @"phone":phone,
                         @"title":title,
                         @"mood":_mood,
                         @"event":_event,
                         @"weather":_weather,
                         };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager1 POST:@"http://localhost:8080/OneDay/diary/diaryByItems" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr=responseObject;
        NSLog(@"%@", arr);
        for (int i=0; i<arr.count; i++)
        {
            NSDictionary *dic=arr[i];
            NSString *phone=[NSString stringWithFormat:@"%@",[dic objectForKey:@"phone"]];
            NSString *title=[[NSString alloc]init];
            NSString *weather=[[NSString alloc]init];
            NSString *event=[[NSString alloc]init];
            NSString *mood=[[NSString alloc]init];
            NSString *picture=[[NSString alloc]init];
            NSString *content=[[NSString alloc]init];
            NSString *date=[dic objectForKey:@"date"];
            NSString *draft=[NSString stringWithFormat:@"%@",[dic objectForKey:@"draft"]];
            NSString *idnumber=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            if ([[dic objectForKey:@"title"] isKindOfClass:[NSNull class]]||[[dic objectForKey:@"title"] isEqualToString:@""])
            {
                title=@"这是一篇没有标题的日记";
            }
            else
            {
                title=[dic objectForKey:@"title"];
            }
            if ([[dic objectForKey:@"weather"] isKindOfClass:[NSNull class]]||[[dic objectForKey:@"weather"] isEqualToString:@""])
            {
                weather=@"这是一篇没有天气的日记";
            }
            else
            {
                weather=[dic objectForKey:@"weather"];
            }
            if ([[dic objectForKey:@"mood"] isKindOfClass:[NSNull class]]||[[dic objectForKey:@"mood"] isEqualToString:@""])
            {
                mood=@"这是一篇没有心情的日记";
            }
            else
            {
                mood=[dic objectForKey:@"mood"];
            }
            if ([[dic objectForKey:@"event"] isKindOfClass:[NSNull class]]||[[dic objectForKey:@"event"] isEqualToString:@""])
            {
                 event=@"这是一篇没有事件的日记";
            }
            else
            {
                event=[dic objectForKey:@"event"];
            }
            if ([[dic objectForKey:@"picture"] isKindOfClass:[NSNull class]]||[[dic objectForKey:@"picture"] isEqualToString:@""])
            {
                picture=@"默认图片";
            }
            else
            {
                picture=[dic objectForKey:@"picture"];
            }
            if ([[dic objectForKey:@"content"] isKindOfClass:[NSNull class]]||[[dic objectForKey:@"content"] isEqualToString:@""])
            {
                content=@"无";
            }
            else
            {
                content=[dic objectForKey:@"content"];
            }
            Diary *diary=[[Diary alloc]initWithUserphone:phone Pic:picture Date:date Title:title Weather:weather Mood:mood Event:event Draft:draft Content:content Id:idnumber];
            [vc.datasource addObject:diary];
        
        }
        [vc.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
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
