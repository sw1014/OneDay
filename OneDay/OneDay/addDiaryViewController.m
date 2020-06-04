//
//  addDiaryViewController.m
//  OneDay
//
//  Created by sw on 2020/4/26.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "addDiaryViewController.h"
#import "Masonry.h"
#import "addDiaryMoodViewController.h"
@interface addDiaryViewController ()
@property(nonatomic)UIButton *weatherbtn1;
@property(nonatomic)UIButton *weatherbtn2;
@property(nonatomic)UIButton *weatherbtn3;
@property(nonatomic)UIButton *weatherbtn4;
@property(nonatomic)UIButton *weatherbtn5;
@property(nonatomic)UIButton *weatherbtn6;

@end

@implementation addDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";
    UILabel *textLable = [[UILabel alloc] init];
    textLable.text =@"主人，今天外面的天气怎么样呢？";
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
    _weatherbtn1=[[UIButton alloc]init];
    _weatherbtn1.titleLabel.text=@"晴";
    _weatherbtn1.layer.borderColor=[UIColor grayColor].CGColor;
    _weatherbtn1.layer.borderWidth=1;
    _weatherbtn1.layer.masksToBounds=YES;
    _weatherbtn1.layer.cornerRadius=9;
    [_weatherbtn1 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn1 setImage:[UIImage imageNamed:@"晴1"] forState:UIControlStateNormal];
    [_weatherbtn1 setImage:[UIImage imageNamed:@"晴2"] forState:UIControlStateSelected];
    [self.view addSubview:_weatherbtn1];
    [_weatherbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(77);
        make.top.equalTo(self.view).offset(211);
    }];
    _weatherbtn2=[[UIButton alloc]init];
    _weatherbtn2.layer.borderColor=[UIColor grayColor].CGColor;
    _weatherbtn2.layer.borderWidth=1;
    _weatherbtn2.titleLabel.text=@"阵雨";
    _weatherbtn2.layer.masksToBounds=YES;
    _weatherbtn2.layer.cornerRadius=9;
    [_weatherbtn2 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn2 setImage:[UIImage imageNamed:@"阵雨1"] forState:UIControlStateNormal];
    [_weatherbtn2 setImage:[UIImage imageNamed:@"阵雨2"] forState:UIControlStateSelected];
    [self.view addSubview:_weatherbtn2];
    [_weatherbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(169);
        make.top.equalTo(self.view).offset(211);
    }];
    _weatherbtn3=[[UIButton alloc]init];
    _weatherbtn3.layer.borderColor=[UIColor grayColor].CGColor;
    _weatherbtn3.layer.borderWidth=1;
    _weatherbtn3.titleLabel.text=@"晴转多云";
    _weatherbtn3.layer.masksToBounds=YES;
    _weatherbtn3.layer.cornerRadius=9;
    [_weatherbtn3 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn3 setImage:[UIImage imageNamed:@"晴转多云1"] forState:UIControlStateNormal];
    [_weatherbtn3 setImage:[UIImage imageNamed:@"晴转多云2"] forState:UIControlStateSelected];
    [self.view addSubview:_weatherbtn3];
    [_weatherbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(265);
        make.top.equalTo(self.view).offset(211);
    }];
    _weatherbtn4=[[UIButton alloc]init];
    _weatherbtn4.layer.borderColor=[UIColor grayColor].CGColor;
    _weatherbtn4.layer.borderWidth=1;
    _weatherbtn4.layer.masksToBounds=YES;
    _weatherbtn4.titleLabel.text=@"大风";
    _weatherbtn4.layer.cornerRadius=9;
    [_weatherbtn4 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn4 setImage:[UIImage imageNamed:@"大风1"] forState:UIControlStateNormal];
    [_weatherbtn4 setImage:[UIImage imageNamed:@"大风2"] forState:UIControlStateSelected];
    [self.view addSubview:_weatherbtn4];
    [_weatherbtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(77);
        make.top.equalTo(self.view).offset(308);
    }];
    _weatherbtn5=[[UIButton alloc]init];
    _weatherbtn5.layer.borderColor=[UIColor grayColor].CGColor;
    _weatherbtn5.layer.borderWidth=1;
    _weatherbtn5.layer.masksToBounds=YES;
    _weatherbtn5.layer.cornerRadius=9;
    _weatherbtn5.titleLabel.text=@"雾";
    [_weatherbtn5 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn5 setImage:[UIImage imageNamed:@"雾1"] forState:UIControlStateNormal];
    [_weatherbtn5 setImage:[UIImage imageNamed:@"雾2"] forState:UIControlStateSelected];
    [self.view addSubview:_weatherbtn5];
    [_weatherbtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(169);
        make.top.equalTo(self.view).offset(308);
    }];
    _weatherbtn6=[[UIButton alloc]init];
    _weatherbtn6.layer.borderColor=[UIColor grayColor].CGColor;
    _weatherbtn6.layer.borderWidth=1;
    _weatherbtn6.layer.masksToBounds=YES;
    _weatherbtn6.layer.cornerRadius=9;
    _weatherbtn6.titleLabel.text=@"多云";
    [_weatherbtn6 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    [_weatherbtn6 setImage:[UIImage imageNamed:@"多云1"] forState:UIControlStateNormal];
    [_weatherbtn6 setImage:[UIImage imageNamed:@"多云2"] forState:UIControlStateSelected];
    [self.view addSubview:_weatherbtn6];
    [_weatherbtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).offset(265);
        make.top.equalTo(self.view).offset(308);
    }];
    //标签
    UILabel *weatherlabel1=[[UILabel alloc]init];
    weatherlabel1.text=@"晴";
    weatherlabel1.font=[UIFont systemFontOfSize:14];
    weatherlabel1.textColor=[UIColor grayColor];
    [self.view addSubview:weatherlabel1];
    [weatherlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 20));
        make.left.equalTo(self.view).offset(105);
        make.top.equalTo(self.view).offset(281);
    }];
    UILabel *weatherlabel2=[[UILabel alloc]init];
    weatherlabel2.text=@"阵雨";
    weatherlabel2.font=[UIFont systemFontOfSize:14];
    weatherlabel2.textColor=[UIColor grayColor];
    [self.view addSubview:weatherlabel2];
    [weatherlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 20));
        make.centerX.equalTo(_weatherbtn2);
        make.top.equalTo(self.view).offset(281);
    }];
    UILabel *weatherlabel3=[[UILabel alloc]init];
    weatherlabel3.text=@"多云转晴";
    weatherlabel3.font=[UIFont systemFontOfSize:14];
    weatherlabel3.textColor=[UIColor grayColor];
    [self.view addSubview:weatherlabel3];
    [weatherlabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 20));
        make.centerX.equalTo(_weatherbtn3);
        make.top.equalTo(self.view).offset(281);
    }];
    UILabel *weatherlabel4=[[UILabel alloc]init];
    weatherlabel4.text=@"大风";
    weatherlabel4.font=[UIFont systemFontOfSize:14];
    weatherlabel4.textColor=[UIColor grayColor];
    [self.view addSubview:weatherlabel4];
    [weatherlabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 20));
        make.centerX.equalTo(_weatherbtn4);
        make.top.equalTo(self.view).offset(381);
    }];
    UILabel *weatherlabel5=[[UILabel alloc]init];
    weatherlabel5.text=@"雾";
    weatherlabel5.font=[UIFont systemFontOfSize:14];
    weatherlabel5.textColor=[UIColor grayColor];
    [self.view addSubview:weatherlabel5];
    [weatherlabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 20));
        make.left.equalTo(self.view).offset(197);
        make.top.equalTo(self.view).offset(381);
    }];
    UILabel *weatherlabel6=[[UILabel alloc]init];
    weatherlabel6.text=@"阴";
    weatherlabel6.font=[UIFont systemFontOfSize:14];
    weatherlabel6.textColor=[UIColor grayColor];
    [self.view addSubview:weatherlabel6];
    [weatherlabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 20));
        make.left.equalTo(self.view).offset(294);
        make.top.equalTo(self.view).offset(381);
    }];
    
    UIButton *submitbtn=[[UIButton alloc]init];
    submitbtn.layer.borderColor=[UIColor grayColor].CGColor;
    submitbtn.layer.borderWidth=2;
    submitbtn.layer.masksToBounds=YES;
    submitbtn.layer.cornerRadius=20;
    [submitbtn setTitle:@"今天的天气是这样" forState:UIControlStateNormal];
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
    NSString *weather=@"没有记录天气哦";
    [[NSUserDefaults standardUserDefaults] setObject:weather forKey:@"weather"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)selectmood
{
    addDiaryMoodViewController *vc=[[addDiaryMoodViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)changecolor:(UIButton *)btn
{
    
    if (btn.selected)
    {
        btn.backgroundColor=[UIColor whiteColor];
        btn.selected=NO;
        NSString *weather=@"没有记录天气哦";
        [[NSUserDefaults standardUserDefaults] setObject:weather forKey:@"weather"];
        [[NSUserDefaults standardUserDefaults] synchronize];
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
        btn.backgroundColor=[UIColor grayColor];
        btn.selected=YES;
        NSString *weather=btn.titleLabel.text;
           [[NSUserDefaults standardUserDefaults] setObject:weather forKey:@"weather"];
           [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
   // NSLog(btn.titleLabel.text);
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
