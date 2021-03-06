//
//  listDiaryViewController.m
//  OneDay
//
//  Created by sw on 2020/5/6.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "listDiaryViewController.h"
#import "Diary.h"
#import "Masonry.h"
#import "listDiaryTableViewCell.h"
#import "detailDiaryViewController.h"
#import "AFNetworking.h"
#import "detailDraftViewController.h"
@interface listDiaryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)NSString *phone;
@end

@implementation listDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationItem.title=@"搜索结果";
    self.navigationController.navigationBar.topItem.title = @"";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    self.datasource=[[NSMutableArray alloc]init];
    _tableview=[[UITableView alloc]init];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.top.equalTo(self.view).offset(89);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view).offset(-17);
    }];
    
    if (_date==nil)
    {
        NSLog(@"不按日期搜索日记");
    }
    else
    {
        [self initdata];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initdata//通过网络请求初始化数据然后赋值给数据源
{
    _phone=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSDictionary *dic1=@{
                         @"phone":_phone,
                         @"date":_date,
                         };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager1 POST:@"http://localhost:8080/OneDay/diary/diaryByDate" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr=responseObject;
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
            
            [self.datasource addObject:diary];
        }
        [self.tableview reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datasource count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 186;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listDiaryTableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:@"cellid"];
    Diary *item=[_datasource objectAtIndex:indexPath.row];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"listDiaryTableViewCell" owner:nil options:nil] firstObject];
    }
        cell.date.text=item.date;
        cell.weather.text=item.weather;
        cell.event.text=item.event;
        cell.mood.text=item.mood;
        cell.title.text=item.title;
        cell.content=item.content;
        cell.idnumber=item.idnumber;
        cell.picurl=item.picture;
        NSString *str1=item.picture;
        if ([str1 isEqualToString:@"默认图片"])
        {
            cell.picture.image=[UIImage imageNamed:@"猫咪2"];
        }
        else
        {
            NSString *str2=@"http://localhost:8080";
            str2=[str2 stringByAppendingString:str1];
            NSURL *urll=[NSURL URLWithString:str2];
            NSData *data=[NSData dataWithContentsOfURL:urll];
            cell.picture.image=[UIImage imageWithData:data];
        }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    listDiaryTableViewCell *cell=[self.tableview cellForRowAtIndexPath:indexPath];
    if (_draft)
    {
        detailDraftViewController *vc=[[detailDraftViewController alloc]init];
        vc.diarytitle=cell.title.text;
        vc.event=cell.event.text;
        vc.weather=cell.weather.text;
        vc.mood=cell.mood.text;
        vc.date=cell.date.text;
        vc.content=cell.content;
        vc.idnumber=cell.idnumber;
        vc.picture=cell.picurl;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        detailDiaryViewController *vc=[[detailDiaryViewController alloc]init];
        vc.diarytitle=cell.title.text;
        vc.event=cell.event.text;
        vc.weather=cell.weather.text;
        vc.mood=cell.mood.text;
        vc.date=cell.date.text;
        vc.content=cell.content;
        vc.idnumber=cell.idnumber;
        vc.picture=cell.picurl;
        [self.navigationController pushViewController:vc animated:YES];
        //[self.tableview deselectRowAtIndexPath:indexPath animated:NO];
    }
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
