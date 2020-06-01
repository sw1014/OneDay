//
//  addDiaryEventViewController.m
//  OneDay
//
//  Created by sw on 2020/4/28.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "addDiaryEventViewController.h"
#import "Masonry.h"
#import "addDiary4ViewController.h"
@interface addDiaryEventViewController ()
@property(nonatomic)UIButton *moodbtn1;
@property(nonatomic)UIButton *moodbtn2;
@property(nonatomic)UIButton *moodbtn3;
@property(nonatomic)UIButton *moodbtn4;
@property(nonatomic)UIButton *moodbtn5;
@property(nonatomic)UIButton *moodbtn6;
@end

@implementation addDiaryEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";
    UILabel *textLable = [[UILabel alloc] init];
    textLable.text =@"是什么事情让你感到生气啊？";
    textLable.numberOfLines=0;
    [textLable setLineBreakMode:UILineBreakModeWordWrap];
    textLable.font=[UIFont systemFontOfSize:28];
    textLable.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [self.view addSubview:textLable];
    [textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(294, 96));
        make.left.equalTo(self.view).offset(45);
        make.top.equalTo(self.view).offset(80);
    }];
    UIButton *imagebtn1=[[UIButton alloc]init];
    [imagebtn1 setBackgroundImage:[UIImage imageNamed:@"猫爪"] forState:UIControlStateNormal];
    [imagebtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    imagebtn1.userInteractionEnabled=NO;
    [self.view addSubview:imagebtn1];
    [imagebtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 30));
        make.left.equalTo(self.view).offset(348);
        make.top.equalTo(self.view).offset(80);
    }];
    UIButton *imagebtn2=[[UIButton alloc]init];
    [imagebtn2 setBackgroundImage:[UIImage imageNamed:@"猫爪"] forState:UIControlStateNormal];
    [imagebtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    imagebtn2.userInteractionEnabled=NO;
    [self.view addSubview:imagebtn2];
    [imagebtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 30));
        make.left.equalTo(self.view).offset(281);
        make.top.equalTo(self.view).offset(152);
    }];
    //选择按钮
    _moodbtn1=[[UIButton alloc]init];
    _moodbtn1.titleLabel.text=@"学习";
    _moodbtn1.layer.borderColor=[UIColor grayColor].CGColor;
    _moodbtn1.layer.borderWidth=1;
    _moodbtn1.layer.masksToBounds=YES;
    _moodbtn1.layer.cornerRadius=9;
    [_moodbtn1 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn1 setImage:[UIImage imageNamed:@"学习1"] forState:UIControlStateNormal];
    [_moodbtn1 setImage:[UIImage imageNamed:@"学习2"] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn1];
    [_moodbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(77);
        make.top.equalTo(self.view).offset(211);
    }];
    _moodbtn2=[[UIButton alloc]init];
    _moodbtn2.layer.borderColor=[UIColor grayColor].CGColor;
    _moodbtn2.layer.borderWidth=1;
    _moodbtn2.layer.masksToBounds=YES;
    _moodbtn2.titleLabel.text=@"游戏";
    _moodbtn2.layer.cornerRadius=9;
    [_moodbtn2 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn2 setImage:[UIImage imageNamed:@"游戏1"] forState:UIControlStateNormal];
    [_moodbtn2 setImage:[UIImage imageNamed:@"游戏2"] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn2];
    [_moodbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(169);
        make.top.equalTo(self.view).offset(211);
    }];
    _moodbtn3=[[UIButton alloc]init];
    _moodbtn3.layer.borderColor=[UIColor grayColor].CGColor;
    _moodbtn3.layer.borderWidth=1;
    _moodbtn3.layer.masksToBounds=YES;
    _moodbtn3.layer.cornerRadius=9;
    _moodbtn3.titleLabel.text=@"美食";
    [_moodbtn3 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn3 setImage:[UIImage imageNamed:@"美食1"] forState:UIControlStateNormal];
    [_moodbtn3 setImage:[UIImage imageNamed:@"美食2"] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn3];
    [_moodbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(265);
        make.top.equalTo(self.view).offset(211);
    }];
    _moodbtn4=[[UIButton alloc]init];
    _moodbtn4.layer.borderColor=[UIColor grayColor].CGColor;
    _moodbtn4.layer.borderWidth=1;
    _moodbtn4.layer.masksToBounds=YES;
    _moodbtn4.layer.cornerRadius=9;
    _moodbtn4.titleLabel.text=@"跑步";
    [_moodbtn4 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn4 setImage:[UIImage imageNamed:@"跑步1"] forState:UIControlStateNormal];
    [_moodbtn4 setImage:[UIImage imageNamed:@"跑步2"] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn4];
    [_moodbtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(77);
        make.top.equalTo(self.view).offset(308);
    }];
    _moodbtn5=[[UIButton alloc]init];
    _moodbtn5.layer.borderColor=[UIColor grayColor].CGColor;
    _moodbtn5.layer.borderWidth=1;
    _moodbtn5.layer.masksToBounds=YES;
    _moodbtn5.layer.cornerRadius=9;
    _moodbtn5.titleLabel.text=@"工作";
    [_moodbtn5 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn5 setImage:[UIImage imageNamed:@"工作1"] forState:UIControlStateNormal];
    [_moodbtn5 setImage:[UIImage imageNamed:@"工作2"] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn5];
    [_moodbtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(169);
        make.top.equalTo(self.view).offset(308);
    }];
    _moodbtn6=[[UIButton alloc]init];
    _moodbtn6.layer.borderColor=[UIColor grayColor].CGColor;
    _moodbtn6.layer.borderWidth=1;
    _moodbtn6.layer.masksToBounds=YES;
    _moodbtn6.layer.cornerRadius=9;
    _moodbtn6.titleLabel.text=@"争吵";
    [_moodbtn6 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_moodbtn6 setImage:[UIImage imageNamed:@"争吵1"] forState:UIControlStateNormal];
    [_moodbtn6 setImage:[UIImage imageNamed:@"争吵2"] forState:UIControlStateSelected];
    [self.view addSubview:_moodbtn6];
    [_moodbtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(265);
        make.top.equalTo(self.view).offset(308);
    }];
    //标签
    UILabel *moodlabel1=[[UILabel alloc]init];
    moodlabel1.text=@"学习";
    moodlabel1.font=[UIFont systemFontOfSize:14];
    moodlabel1.textColor=[UIColor grayColor];
    [self.view addSubview:moodlabel1];
    [moodlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 20));
        make.centerX.equalTo(_moodbtn1);
        make.top.equalTo(self.view).offset(281);
    }];
    UILabel *moodlabel2=[[UILabel alloc]init];
    moodlabel2.text=@"游戏";
    moodlabel2.font=[UIFont systemFontOfSize:14];
    moodlabel2.textColor=[UIColor grayColor];
    [self.view addSubview:moodlabel2];
    [moodlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 20));
        make.centerX.equalTo(_moodbtn2);
        make.top.equalTo(self.view).offset(281);
    }];
    UILabel *moodlabel3=[[UILabel alloc]init];
    moodlabel3.text=@"美食";
    moodlabel3.font=[UIFont systemFontOfSize:14];
    moodlabel3.textColor=[UIColor grayColor];
    [self.view addSubview:moodlabel3];
    [moodlabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 20));
        make.centerX.equalTo(_moodbtn3);
        make.top.equalTo(self.view).offset(281);
    }];
    UILabel *moodlabel4=[[UILabel alloc]init];
    moodlabel4.text=@"跑步";
    moodlabel4.font=[UIFont systemFontOfSize:14];
    moodlabel4.textColor=[UIColor grayColor];
    [self.view addSubview:moodlabel4];
    [moodlabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 20));
        make.centerX.equalTo(_moodbtn4);
        make.top.equalTo(self.view).offset(381);
    }];
    UILabel *moodlabel5=[[UILabel alloc]init];
    moodlabel5.text=@"工作";
    moodlabel5.font=[UIFont systemFontOfSize:14];
    moodlabel5.textColor=[UIColor grayColor];
    [self.view addSubview:moodlabel5];
    [moodlabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 20));
        make.centerX.equalTo(_moodbtn5);
        make.top.equalTo(self.view).offset(381);
    }];
    UILabel *moodlabel6=[[UILabel alloc]init];
    moodlabel6.text=@"争吵";
    moodlabel6.font=[UIFont systemFontOfSize:14];
    moodlabel6.textColor=[UIColor grayColor];
    [self.view addSubview:moodlabel6];
    [moodlabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 20));
        make.centerX.equalTo(_moodbtn6);
        make.top.equalTo(self.view).offset(381);
    }];
    
    UIButton *submitbtn=[[UIButton alloc]init];
    submitbtn.layer.borderColor=[UIColor grayColor].CGColor;
    submitbtn.layer.borderWidth=2;
    submitbtn.layer.masksToBounds=YES;
    submitbtn.layer.cornerRadius=20;
    [submitbtn setTitle:@"今天的心情是这样" forState:UIControlStateNormal];
    [submitbtn setTitleColor:[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1] forState:UIControlStateNormal];
    submitbtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [submitbtn addTarget:self action:@selector(selectmood) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submitbtn];
    [submitbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(175, 52));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(432);
    }];
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"猫咪2"]];
    [self.view addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(414, 197));
        make.top.equalTo(self.view).offset(512);
    }];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)selectmood
{
    addDiary4ViewController *vc=[[addDiary4ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)changecolor:(UIButton *)btn
{
    if (btn.selected)
    {
        btn.backgroundColor=[UIColor whiteColor];
        btn.selected=NO;
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
        btn.backgroundColor=[UIColor grayColor];
    }
    NSString *event=btn.titleLabel.text;
    [[NSUserDefaults standardUserDefaults] setObject:event forKey:@"event"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
