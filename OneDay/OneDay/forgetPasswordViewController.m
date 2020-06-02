//
//  forgetPasswordViewController.m
//  OneDay
//
//  Created by sw on 2020/4/26.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "forgetPasswordViewController.h"
#import "Masonry.h"
#import <SMS_SDK/SMSSDK.h>
#import "CountViewController.h"
#import "PetViewController.h"
#import "InformationViewController.h"
#import "AFNetworking.h"
#import "User.h"
@interface forgetPasswordViewController ()
@property(nonatomic)UITextField *phone;
@property(nonatomic)UITextField *password;
@property(nonatomic)UITextField *key;//验证码
@end

@implementation forgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //返回按钮
    UIButton *backbtn=[[UIButton alloc]init];
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backbtn];
    [backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(self.view).offset(1);
        make.top.equalTo(self.view).offset(26);
    }];
    //标签
    UILabel *label1=[[UILabel alloc]init];
    label1.text=@"验证码登录";
    label1.textAlignment=NSTextAlignmentLeft;
    label1.font=[UIFont systemFontOfSize:28];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(240, 40));
        make.left.equalTo(self.view).offset(44);
        make.top.equalTo(self.view).offset(102);
    }];
    UILabel *label2=[[UILabel alloc]init];
    label2.text=@"手机短信验证登录后，可于用户中心修改密码";
    label2.textAlignment=NSTextAlignmentLeft;
    label2.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(294, 20));
        make.left.equalTo(self.view).offset(44);
        make.top.equalTo(self.view).offset(149);
    }];
    //手机号输入框
    _phone=[[UITextField alloc]init];
    _phone.borderStyle=UITextBorderStyleNone;
    _phone.placeholder=@"请输入手机号";
    [self.view addSubview:_phone];
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(313, 29));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(218);
    }];
    UIView *view1=[[UIView alloc]init];
    view1.backgroundColor=[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_offset(313);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(255);
    }];
    
    _password=[[UITextField alloc]init];
    _password.borderStyle=UITextBorderStyleNone;
    _password.placeholder=@"请输入密码";
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(313, 29));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(300);
    }];
    UIView *view3=[[UIView alloc]init];
    view3.backgroundColor=[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    [self.view addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_offset(313);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(337);
    }];
    
    
    //验证码输入框
    _key=[[UITextField alloc]init];
    _key.borderStyle=UITextBorderStyleNone;
    _key.placeholder=@"请输入验证码";
    [self.view addSubview:_key];
    [_key mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 29));
        make.left.equalTo(view1);
        make.top.equalTo(self.view).offset(382);
    }];
    UIView *view2=[[UIView alloc]init];
    view2.backgroundColor=[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_offset(313);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(419);
    }];
    
    
    
    //验证码按钮
    UIButton *btn1=[[UIButton alloc]init];
    btn1.backgroundColor=[UIColor colorWithRed:255.0/255 green:222.0/255 blue:173.0/255 alpha:1];
    [btn1 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchDown];
    btn1.layer.cornerRadius=4;
    btn1.layer.masksToBounds=YES;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 29));
        make.left.equalTo(self.view).offset(243);
        make.top.equalTo(self.view).offset(382);
    }];
    //登录按钮
    UIButton *btn2=[[UIButton alloc]init];
    btn2.backgroundColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1];
    [btn2 setTitle:@"立即登录" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    btn2.layer.cornerRadius=4;
    btn2.layer.masksToBounds=YES;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(289, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(500);
    }];
    
    // Do any additional setup after loading the view.
}
-(void)login
{
    

   
    [SMSSDK commitVerificationCode:_key.text phoneNumber:_phone.text zone:@"86" result:^(NSError *error)
     {
         
         if (!error)
         {
             NSDictionary *dic1=@{
                                  @"phone":_phone.text,
                                  @"password":_password.text,
                                  };
             AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
             manager1.requestSerializer = [AFJSONRequestSerializer serializer];
             manager1.responseSerializer = [AFJSONResponseSerializer serializer];
             [manager1 POST:@"http://localhost:8080/OneDay/user/register" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSDictionary *nsdic=responseObject;
                 NSLog(@"%@",nsdic);
                 [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[nsdic objectForKey:@"phone"]] forKey:@"phone"];
                 //因为返回的phone是long类型 所以要做转化
                 [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"email"] forKey:@"email"];
                 [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"password"] forKey:@"password"];
                 if ([[nsdic objectForKey:@"photo"] isKindOfClass:[NSNull class]])
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"photo"];
                     //注册的话 返回null
                 }
                 else
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"photo"] forKey:@"photo"];
                 }
                 [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"username"] forKey:@"username"];
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
                 
                 
                 
                 
                 
                 
                 
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSError *err=error;
                 NSLog(@"%@",err);
                 UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败" preferredStyle:UIAlertControllerStyleAlert];
                 [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                 [self presentViewController:alert animated:YES completion:nil];
             }];
 
             
             
             
             
             
             
             
             
         
         }
         else
         {
             UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
             [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
             [self presentViewController:alert animated:YES completion:nil];
         }
         
     }];
   
        
   
    
    
    
    
    
    
    
}
-(void)getMessage
{
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phone.text zone:@"86"  result:^(NSError *error) {
        {
            if (!error)
            {
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"验证码已成功发送" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"验证码发送失败" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
