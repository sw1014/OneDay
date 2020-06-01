//
//  detailDiaryViewController.m
//  OneDay
//
//  Created by sw on 2020/5/6.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "detailDiaryViewController.h"
#import "CountViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
@interface detailDiaryViewController ()
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *dateLable;
@property(nonatomic,strong)UILabel *weatherLable;
@property(nonatomic,strong)UILabel *eventLable;
@property(nonatomic,strong)UILabel *moodLable;
@property(nonatomic,strong)UITextView *textview1;
@end

@implementation detailDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationItem.title=@"我的日记";
    self.navigationController.navigationBar.topItem.title = @"";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"垃圾桶"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteDiary)];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 320, 414, 468)];
    imageview.image=[UIImage imageNamed:@"背景图2"];
    [self.view addSubview:imageview];
    
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(63);
        make.bottom.equalTo(self.view);
    }];
    _titleLable = [[UILabel alloc] init];
    _titleLable.text =@"标题";
   // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _titleLable.font=[UIFont systemFontOfSize:28];
    _titleLable.textColor = [UIColor blackColor];
    [scrollView addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 38));
        make.left.equalTo(scrollView).offset(66);
        make.top.equalTo(scrollView).offset(50);
    }];
    _dateLable = [[UILabel alloc] init];
    _dateLable.text =@"日期";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _dateLable.font=[UIFont systemFontOfSize:16];
    _dateLable.textColor = [UIColor blackColor];
    [scrollView addSubview:_dateLable];
    [_dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 23));
        make.left.equalTo(scrollView).offset(66);
        make.top.equalTo(scrollView).offset(98);
    }];
    _weatherLable = [[UILabel alloc] init];
    _weatherLable.text =@"天气:";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _weatherLable.font=[UIFont systemFontOfSize:16];
    _weatherLable.textColor = [UIColor blackColor];
    [scrollView addSubview:_weatherLable];
    [_weatherLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 23));
        make.left.equalTo(scrollView).offset(66);
        make.top.equalTo(scrollView).offset(131);
    }];
    _moodLable = [[UILabel alloc] init];
    _moodLable.text =@"心情:";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _moodLable.font=[UIFont systemFontOfSize:16];
    _moodLable.textColor = [UIColor blackColor];
    [scrollView addSubview:_moodLable];
    [_moodLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 23));
        make.left.equalTo(scrollView).offset(66);
        make.top.equalTo(scrollView).offset(164);
    }];
    _eventLable = [[UILabel alloc] init];
    _eventLable.text =@"事件:";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _eventLable.font=[UIFont systemFontOfSize:16];
    _eventLable.textColor = [UIColor blackColor];
    [scrollView addSubview:_eventLable];
    [_eventLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 23));
        make.left.equalTo(scrollView).offset(66);
        make.top.equalTo(scrollView).offset(197);
    }];
    UILabel *Lable = [[UILabel alloc] init];
    Lable.text =@"正文";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    Lable.font=[UIFont systemFontOfSize:16];
    Lable.textColor = [UIColor blackColor];
    [scrollView addSubview:Lable];
    [Lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 23));
        make.left.equalTo(scrollView).offset(66);
        make.top.equalTo(scrollView).offset(230);
    }];
    _textview1=[[UITextView alloc]init];
    _textview1.backgroundColor=[UIColor clearColor];
    _textview1.text=@"jkhkhjhhhkj";
    _textview1.font=[UIFont systemFontOfSize:20];
    _textview1.tintColor=[UIColor blackColor];
    [scrollView addSubview:_textview1];
    [_textview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(66);
        make.top.equalTo(scrollView).offset(263);
        make.height.mas_equalTo(300);
        make.width.mas_equalTo(298);
    }];
    
    
    
    
    [self initdata];
}
-(void)initdata
{
    _titleLable.text =_diarytitle;
    _weatherLable.text=_weather;
    _moodLable.text=_mood;
    _eventLable.text=_event;
    _dateLable.text=_date;
    _textview1.text=_content;
}
-(void)deleteDiary
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"是否删除日记"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             for(UIViewController*vc in self.navigationController.viewControllers) {
                                                                 
                                                                 if([vc isKindOfClass:[CountViewController class]]) {
                                                                     [self.navigationController popToViewController:vc animated:YES];
                                                                     
                                                                 }
                                                             }
                                                             
                                                             
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //删除日记
                                                             NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
                                                             NSDictionary *dic1=@{
                                                                                  @"phone":phone,
                                                                                  @"id":_idnumber,
                                                                                  };
                                                             
                                                             AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
                                                             manager1.requestSerializer = [AFJSONRequestSerializer serializer];
                                                             manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                             [manager1 POST:@"http://localhost:8080/OneDay/diary/delDiary" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                 NSString *nsdic=responseObject;
                                                                 NSLog(@"%@",nsdic);
                                                                 
                                                                 
                                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                 NSError *err=error;
                                                                 NSLog(@"%@",err);
                                                             }];
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             [self.navigationController popToRootViewControllerAnimated:YES];
                                                                 
                                                             }];
                                                             

    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
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
