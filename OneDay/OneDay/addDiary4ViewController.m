//
//  addDiary4ViewController.m
//  OneDay
//
//  Created by sw on 2020/4/28.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "addDiary4ViewController.h"
#import "Masonry.h"
#import "addDiaryDetailViewController.h"
#import "PetViewController.h"
@interface addDiary4ViewController ()

@end

@implementation addDiary4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";
    UILabel *textLable1 = [[UILabel alloc] init];
    textLable1.text =@"看来今天发生了很多呢？";
    textLable1.font=[UIFont systemFontOfSize:20];
    textLable1.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [self.view addSubview:textLable1];
    [textLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(294, 20));
        make.left.equalTo(self.view).offset(51);
        make.top.equalTo(self.view).offset(84);
    }];
    UILabel *textLable2 = [[UILabel alloc] init];
    textLable2.text =@"要不要仔细跟我讲讲呢？";
    textLable2.font=[UIFont systemFontOfSize:20];
    textLable2.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [self.view addSubview:textLable2];
    [textLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(294, 20));
        make.left.equalTo(self.view).offset(51);
        make.top.equalTo(self.view).offset(124);
    }];
    UILabel *textLable3 = [[UILabel alloc] init];
    textLable3.text =@"大橘也想多听听主人的故事呢";
    textLable3.font=[UIFont systemFontOfSize:20];
    textLable3.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [self.view addSubview:textLable3];
    [textLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(294, 20));
        make.left.equalTo(self.view).offset(51);
        make.top.equalTo(self.view).offset(164);
    }];
    UIButton *imagebtn1=[[UIButton alloc]init];
    [imagebtn1 setBackgroundImage:[UIImage imageNamed:@"猫爪"] forState:UIControlStateNormal];
    [imagebtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    imagebtn1.userInteractionEnabled=NO;
    [self.view addSubview:imagebtn1];
    [imagebtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 30));
        make.left.equalTo(self.view).offset(318);
        make.top.equalTo(self.view).offset(78);
    }];
    UIButton *imagebtn2=[[UIButton alloc]init];
    [imagebtn2 setBackgroundImage:[UIImage imageNamed:@"猫爪"] forState:UIControlStateNormal];
    [imagebtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    imagebtn2.userInteractionEnabled=NO;
    [self.view addSubview:imagebtn2];
    [imagebtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 30));
        make.left.equalTo(self.view).offset(362);
        make.top.equalTo(self.view).offset(141);
    }];
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"猫咪2"]];
    [self.view addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(414, 197));
        make.top.equalTo(self.view).offset(232);
    }];
    UIButton *submitbtn1=[[UIButton alloc]init];
    submitbtn1.layer.borderColor=[UIColor grayColor].CGColor;
    submitbtn1.layer.borderWidth=2;
    submitbtn1.layer.masksToBounds=YES;
    submitbtn1.layer.cornerRadius=20;
    [submitbtn1 setTitle:@"好吧那你认真听" forState:UIControlStateNormal];
    [submitbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitbtn1 setBackgroundColor:[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1]];
    submitbtn1.titleLabel.font=[UIFont systemFontOfSize:16];
    [submitbtn1 addTarget:self action:@selector(detail) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submitbtn1];
    [submitbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(175, 52));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(475);
    }];
    UIButton *submitbtn2=[[UIButton alloc]init];
    submitbtn2.layer.borderColor=[UIColor grayColor].CGColor;
    submitbtn2.layer.borderWidth=2;
    submitbtn2.layer.masksToBounds=YES;
    submitbtn2.layer.cornerRadius=20;
    [submitbtn2 setTitle:@"离开" forState:UIControlStateNormal];
    [submitbtn2 setTitleColor:[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1] forState:UIControlStateNormal];
    submitbtn2.titleLabel.font=[UIFont systemFontOfSize:16];
    [submitbtn2 addTarget:self action:@selector(addDiary) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submitbtn2];
    [submitbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(175, 52));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(541);
    }];
}
-(void)detail
{
    addDiaryDetailViewController *vc=[[addDiaryDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)addDiary
{
    /*
    NSString *date=[[NSUserDefaults standardUserDefaults]objectForKey:@"date"];
    NSLog(@"%@",date);
    NSString *event=[[NSUserDefaults standardUserDefaults]objectForKey:@"event"];
    NSLog(@"%@",event);
    NSString *weather=[[NSUserDefaults standardUserDefaults]objectForKey:@"weather"];
    NSLog(@"%@",weather);
    NSString *mood=[[NSUserDefaults standardUserDefaults]objectForKey:@"mood"];
    NSLog(@"%@",mood);
    */
    for(UIViewController*vc in self.navigationController.viewControllers) {
        if([vc isKindOfClass:[PetViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];

        }
        
    }
    
    
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
