//
//  LoginViewController.m
//  OneDay
//
//  Created by sw on 2020/4/25.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "LoginViewController.h"
#import "PetViewController.h"
#import "CountViewController.h"
#import "InformationViewController.h"
#import "forgetPasswordViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "User.h"
@interface LoginViewController ()
@property(nonatomic,strong)UITextField *phone;
@property(nonatomic,strong)UITextField *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
      [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 147, 414, 589)];
    imageview.image=[UIImage imageNamed:@"背景图"];
    [self.view addSubview:imageview];
    //oneday标签
    UILabel *label1=[[UILabel alloc]init];
    label1.text=@"OneDay";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:60];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(265, 62));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(75);
    }];
    
    UILabel *label2=[[UILabel alloc]init];
    label2.text=@"记录你的每个日常";
    label2.textAlignment=NSTextAlignmentCenter;
    label2.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(265, 62));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(178);
    }];
    
    //手机号输入框
    _phone=[[UITextField alloc]init];
    _phone.borderStyle=UITextBorderStyleNone;
    _phone.layer.borderWidth=1.0f;
    _phone.layer.borderColor=[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
    _phone.layer.cornerRadius=5;
    _phone.layer.masksToBounds=YES;
    _phone.placeholder=@"手机号";
    [self.view addSubview:_phone];
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(289, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(304);
    }];
    
    //密码输入框
    _password=[[UITextField alloc]init];
    _password.borderStyle=UITextBorderStyleNone;
    _password.layer.borderWidth=1.0f;
    _password.layer.borderColor=[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1].CGColor;
    _password.layer.cornerRadius=5;
    _password.layer.masksToBounds=YES;
    _password.placeholder=@"密码";
    _password.secureTextEntry=YES;
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(289, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(370);
    }];
    

    //登录按钮
    UIButton *btn1=[[UIButton alloc]init];
    btn1.backgroundColor=[UIColor redColor];
    [btn1 setTitle:@"登录" forState:UIControlStateNormal];
    btn1.layer.cornerRadius=4;
    btn1.layer.masksToBounds=YES;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(289, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(431);
    }];
    //忘记密码按钮
    UIButton *btn2=[[UIButton alloc]init];
    [btn2 setTitle:@"忘记密码" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchDown];
    btn2.titleLabel.font=[UIFont systemFontOfSize:14];
    btn2.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(67, 20));
        make.left.equalTo(self.view).offset(285);
        make.top.equalTo(self.view).offset(486);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)forgetPassword
{
    forgetPasswordViewController *vc=[[forgetPasswordViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
-(void)login
{
    NSDictionary *dic1=@{
     @"phone":_phone.text,
     @"password":_password.text,
     };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFJSONResponseSerializer serializer];
     [manager1 POST:@"http://localhost:8080/OneDay/user/login" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSDictionary *nsdic=responseObject;
     NSLog(@"%@",nsdic);
         if (nsdic==NULL)
         {
             UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
             [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
             [self presentViewController:alert animated:YES completion:nil];
         }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"id"] forKey:@"id"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[nsdic objectForKey:@"phone"]] forKey:@"phone"];
            //因为返回的phone是long类型 所以要做转化
            [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"email"] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"password"] forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"username"] forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"photo"] forKey:@"photo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
             NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
            
             NSDictionary *dic1=@{
             @"phone":phone,
             };
             AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
             manager1.requestSerializer = [AFJSONRequestSerializer serializer];
             manager1.responseSerializer = [AFJSONResponseSerializer serializer];
             [manager1 POST:@"http://localhost:8080/OneDay/user/setting" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *nsdic=responseObject;
                 NSLog(@"%@", nsdic);
            [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"upload"] forKey:@"upload"];
            [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"locked"] forKey:@"locked"];
                 if ([[nsdic objectForKey:@"lockkey"] isKindOfClass:[NSNull class]])
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:@"默认" forKey:@"lockkey"];
                 }
                 else
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"lockkey"] forKey:@"lockkey"];
                 }
             [[NSUserDefaults standardUserDefaults] synchronize];
                 //跳转后的界面
                 CountViewController *countVC=[[CountViewController alloc]init];
                 PetViewController *petVC=[[PetViewController alloc]init];
                 InformationViewController *infVC=[[InformationViewController alloc]init];
                 UITabBarController *tab=[[UITabBarController alloc]init];
                 UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:countVC];
                 UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:petVC];
                 UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:infVC];
                 nav1.tabBarItem.image=[UIImage imageNamed:@"线-统计"];
                 nav2.tabBarItem.image=[UIImage imageNamed:@"线-笔记本"];
                 nav3.tabBarItem.image=[UIImage imageNamed:@"线-人物"];
                 nav1.tabBarItem.selectedImage=[UIImage imageNamed:@"面-统计"];
                 nav2.tabBarItem.selectedImage=[UIImage imageNamed:@"面-笔记本"];
                 nav3.tabBarItem.selectedImage=[UIImage imageNamed:@"面-人物"];
                 tab.tabBar.tintColor=[UIColor grayColor];
                 tab.viewControllers=@[nav1,nav2,nav3];
                 tab.modalPresentationStyle=UIModalPresentationFullScreen;
                 [self presentViewController:tab animated:YES completion:nil];
                 
                 
                 
                 
                 
             }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSError *err=error;
             NSLog(@"%@",err);
             }];
        
        
            
            
            
        }
         

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSError *err=error;
         NSLog(@"%@",err);
             UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
             [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
             [self presentViewController:alert animated:YES completion:nil];
         }];
    

   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
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
