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
@property(nonatomic)UIImageView *imageview2;
@end

@implementation detailDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.topItem.title = @"";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"垃圾桶"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteDiary)];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 249, 414, 491)];
    imageview.image=[UIImage imageNamed:@"背景图2"];
    [self.view addSubview:imageview];
    //日记图片
    _imageview2=[[UIImageView alloc]init];
    [self.view addSubview:_imageview2];
    [_imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(144, 144));
        make.left.equalTo(self.view).offset(227);
        make.top.equalTo(self.view).offset(123);
    }];
    
    
    
    _textview1=[[UITextView alloc]init];
       _textview1.backgroundColor=[UIColor clearColor];
      // _textview1.text=@"jkhkhjhhhkj";
       _textview1.font=[UIFont systemFontOfSize:20];
       _textview1.tintColor=[UIColor blackColor];
    [self.view addSubview:_textview1];
       [_textview1 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.equalTo(self.view);
           make.top.equalTo(self.view).offset(276);
           make.size.mas_equalTo(CGSizeMake(322, 319));
       }];
    
    _titleLable = [[UILabel alloc] init];
  //  _titleLable.text =@"标题";
   // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _titleLable.font=[UIFont systemFontOfSize:28];
    _titleLable.textColor = [UIColor blackColor];
    [self.view addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 38));
        make.left.equalTo(self.view).offset(58);
        make.top.equalTo(self.view).offset(114);
    }];
    _dateLable = [[UILabel alloc] init];
  //  _dateLable.text =@"日期";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _dateLable.font=[UIFont systemFontOfSize:14];
    _dateLable.textColor = [UIColor grayColor];
    [self.view addSubview:_dateLable];
    [_dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 20));
        make.left.equalTo(self.view).offset(58);
        make.top.equalTo(self.view).offset(87);
    }];
    UIView *view=[[UIView alloc]init];
    view.layer.masksToBounds=YES;
    view.layer.borderColor=[UIColor grayColor].CGColor;
    view.layer.borderWidth=1;
    view.layer.cornerRadius=9;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(152, 86));
        make.left.equalTo(self.view).offset(58);
        make.top.equalTo(self.view).offset(170);
    }];
    
    _weatherLable = [[UILabel alloc] init];
 //   _weatherLable.text =@"天气:";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _weatherLable.font=[UIFont systemFontOfSize:14];
    _weatherLable.textColor = [UIColor grayColor];
    [view addSubview:_weatherLable];
    [_weatherLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 20));
        make.left.equalTo(view).offset(26);
        make.top.equalTo(view).offset(11);
    }];
    _moodLable = [[UILabel alloc] init];
   // _moodLable.text =@"心情:";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _moodLable.font=[UIFont systemFontOfSize:14];
    _moodLable.textColor = [UIColor grayColor];
    [view addSubview:_moodLable];
    [_moodLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 20));
        make.left.equalTo(view).offset(26);
        make.top.equalTo(view).offset(34);
    }];
    _eventLable = [[UILabel alloc] init];
   // _eventLable.text =@"事件:";
    // [titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
    _eventLable.font=[UIFont systemFontOfSize:14];
    _eventLable.textColor = [UIColor grayColor];
    [view addSubview:_eventLable];
    [_eventLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 20));
        make.left.equalTo(view).offset(26);
        make.top.equalTo(view).offset(58);
    }];

    [self initdata];
}
-(void)initdata
{
    _titleLable.text =_diarytitle;
    _weatherLable.text=[NSString stringWithFormat:@"天气：%@",_weather];
    _moodLable.text=[NSString stringWithFormat:@"心情：%@",_mood];
    _eventLable.text=[NSString stringWithFormat:@"事件：%@",_event];
    _dateLable.text=_date;
    _textview1.text=_content;
    if ([_picture isEqualToString:@"默认图片"])
    {
        _imageview2.image=[UIImage imageNamed:@"猫咪2"];
    }
    else
    {
        NSString *str2=@"http://localhost:8080";
        str2=[str2 stringByAppendingString:_picture];
        NSURL *urll=[NSURL URLWithString:str2];
        NSData *data=[NSData dataWithContentsOfURL:urll];
        _imageview2.image=[UIImage imageWithData:data];
    }

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
