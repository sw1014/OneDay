//
//  InformationViewController.m
//  OneDay
//
//  Created by sw on 2020/4/25.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "InformationViewController.h"
#import "AFNetworking.h"
#import "SearchDiaryViewController.h"
#import "Masonry.h"
#import "information2ViewController.h"
#import "User.h"
#import "Diary.h"
#import "listDiaryViewController.h"
@interface InformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UITableView *tableview;
@property(nonatomic)NSMutableArray *datasource;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *upload;
@property(nonatomic,strong)NSString *lockkey;
@property(nonatomic)NSString *locked;

@end

@implementation InformationViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    _username=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    _phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    _upload=[[NSUserDefaults standardUserDefaults]objectForKey:@"upload"];
    [self.tableview reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor grayColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索"] style:UIBarButtonItemStylePlain target:self action:@selector(searchDiary)];
    
    
    self.datasource=[[NSMutableArray alloc]init];
    _datasource=@[@"同步日记到云端",@"使用密码锁",@"草稿箱",@"通知权限",@"版本更新",@"用户隐私说明",@"支持作者",@"用户帮助"];
    
    _tableview=[[UITableView alloc]init];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65);
        make.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
    {
        return 8;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }
    else
    {
        return 70;
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            information2ViewController *vc=[[information2ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:@"确定要同步云端吗？"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 NSDate *date=[NSDate date];
                                                                 NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                                                                 [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
                                                                 NSString *date2=[formatter stringFromDate:date];
                                                                
                                                                 NSDictionary *dic1=@{
                                                                                      @"phone":_phone,
                                                                                      @"upload":date2
                                                                                      };
                                            
                                                                 AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
                                                                 manager1.requestSerializer = [AFJSONRequestSerializer serializer];
                                                                 manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                                 [manager1 POST:@"http://localhost:8080/OneDay/user/updSetting" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                     NSString *nsdic=responseObject;
                                                                     NSLog(@"%@",nsdic);
                                                                     _upload=date2;
                                                                     [[NSUserDefaults standardUserDefaults] setObject:date2 forKey:@"upload"];
                                                                     [[NSUserDefaults standardUserDefaults] synchronize];
                                                                     [_tableview reloadData];
                                                                  
                                                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                     NSError *err=error;
                                                                     NSLog(@"%@",err);
                                                                 }];
                                                            
                                
                                                
                                                             }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                 }];
            [alert addAction:okAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if (indexPath.row==1)
        {
            _locked=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"locked"]];
            if ([_locked isEqualToString:@"0"])//没有锁
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                               message:@"请设置密码锁的密码"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                    
                                                                     _lockkey=alert.textFields[0].text;
                                                                     
                                                                     //修改设置
                                                                     NSDictionary *dic1=@{
                                                                                          @"phone":_phone,
                                                                                          @"locked":@"true",
                                                                                          @"lockkey":_lockkey,
                                                                                          };
                                                                     
                                                                     AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
                                                                     manager1.requestSerializer = [AFJSONRequestSerializer serializer];
                                                                     manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                                     [manager1 POST:@"http://localhost:8080/OneDay/user/updSetting" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                         NSString *nsdic=responseObject;
                                                                         NSLog(@"%@",nsdic);
                                                                         [[NSUserDefaults standardUserDefaults] setObject:_lockkey forKey:@"lockkey"];
                                                                         [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"locked"];
                                                                       
                                                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                                                         
                                                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                         NSError *err=error;
                                                                         NSLog(@"%@",err);
                                                                     }];
                                                                     
                                                                      
                                                                      }];
                                                                      UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                                      handler:^(UIAlertAction * action) {
                                                                      
                                                                      }];
                                                                      [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                                                                      textField.placeholder = @"请输入密码锁密码";
                                                                      }];
                                                                      [alert addAction:okAction];
                                                                      [alert addAction:cancelAction];
                                                                      [self presentViewController:alert animated:YES completion:nil];
                                                                      
                                                                      
            }
            else
            {
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                               message:@"确定要取消密码锁吗"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     NSDictionary *dic1=@{
                                                                                          @"phone":_phone,
                                                                                          @"locked":@"false",
                                                                                          };
                                                                     
                                                                     AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
                                                                     manager1.requestSerializer = [AFJSONRequestSerializer serializer];
                                                                     manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                                     [manager1 POST:@"http://localhost:8080/OneDay/user/updSetting" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                         NSString *nsdic=responseObject;
                                                                         NSLog(@"%@",nsdic);
                                                                         [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"locked"];
                                                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                                                         
                                                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                         NSError *err=error;
                                                                         NSLog(@"%@",err);
                                                                     }];
                                                                     
                                                    
                                                                    
                                                                 }];
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
                [alert addAction:okAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
            
        
        }
        else if (indexPath.row==2)
        {
            listDiaryViewController *vc=[[listDiaryViewController alloc]init];
            vc.draft=true;
            NSString *phone=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
            NSDictionary *dic1=@{
                                 @"phone":phone,
                                 @"draft":@"true",
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
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"cellid";
    if (indexPath.section==0)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"photo"];
        if ([str isEqualToString:@""])
        {
            cell.imageView.image=[UIImage imageNamed:@"默认头像"];
        }
        else
        {
            
            NSString *str2=@"http://localhost:8080";
            str2=[str2 stringByAppendingString:str];
            NSURL *urll=[NSURL URLWithString:str2];
            NSData *data=[NSData dataWithContentsOfURL:urll];
            cell.imageView.image=[UIImage imageWithData:data];
        }
        
        CGSize itemSize = CGSizeMake(45, 45);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        cell.imageView.layer.masksToBounds=YES;
        cell.imageView.layer.cornerRadius=22.5;
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.textLabel.text=_username;
        cell.detailTextLabel.text=@"账号管理";
        return cell;
    }
    else
    {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.textLabel.text=_datasource[indexPath.row];
        if (indexPath.row==0)
        {
            [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"上次更新:%@",_upload];
        }
        return cell;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchDiary
{
    SearchDiaryViewController *searchVC=[[SearchDiaryViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
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
