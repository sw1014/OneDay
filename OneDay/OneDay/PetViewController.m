//
//  PetViewController.m
//  OneDay
//
//  Created by sw on 2020/4/25.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "PetViewController.h"
#import "SearchDiaryViewController.h"
#import "addDiaryViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#import "CCHtomCatModel.h"
#import "AFNetworking.h"
#define FILENAME @"cat.plist"
@interface PetViewController ()
@property(strong,nonatomic)UIImageView *imgsAnimation;
@property (nonatomic,strong) NSArray * imgsArr;
@property(nonatomic,strong) AVAudioPlayer * soundPlayer;
@property(nonatomic,strong)NSString *petname;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic)NSInteger weight;
@property(nonatomic)NSInteger intimacy;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UILabel *weightLable;
@property(nonatomic,strong)UILabel *numberLable2;
@property(nonatomic,strong)UILabel *textLable3;
@property(nonatomic,strong)NSDateFormatter *formatter;
@property(nonatomic,strong)NSDate *enddate;
@property(nonatomic,strong)NSDate *date2;
@property(nonatomic,strong)UILabel *timeLable;
enum btnType{
    PLAY=1,
    EAT,
    TOUCH,
    
};
@end

@implementation PetViewController




-(NSArray *)imgsArr
{
    NSMutableArray * tempArr= [NSMutableArray array];
    if (_imgsArr==nil) {
        NSString * path = [[NSBundle mainBundle] pathForResource:FILENAME ofType:nil];
        NSArray * arrInPlist= [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary * dic in arrInPlist) {
            CCHtomCatModel * model = [[CCHtomCatModel alloc] initWithDictionary:dic];
            [tempArr addObject:model];
            
        }
        
        _imgsArr=tempArr;
    }
    return _imgsArr;
}

-(void) loadAninmationWithName:(NSString *) name andCount:(NSInteger ) count
{
    NSMutableArray *tempImgMarr =[NSMutableArray array ];
    for (NSInteger i=0; i<count; i++) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_grey_%02ld.png",name,i] ofType:nil];
        UIImage * tempImg=[UIImage imageWithContentsOfFile:path];
        if (tempImg)
        {
            [tempImgMarr addObject:tempImg];
        }
        else
        {
            NSLog(@"图片为空");
        }
    }
    //设置动画属性
    self.imgsAnimation.animationImages=tempImgMarr;
    self.imgsAnimation.animationDuration=5;
    self.imgsAnimation.animationRepeatCount=0;
    
    [self.imgsAnimation startAnimating];
    
    //释放内存
    [self.imgsAnimation performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:count*0.08];
    
}
#pragma mark  加载声音
-(void) loadSoundsWithName:(NSString *) name
{
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",name] ofType:nil];
    NSURL * url= [NSURL fileURLWithPath:path];
    if (url!=nil)
    {
        self.soundPlayer= [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [self.soundPlayer play];
    }
    else
    {
        NSLog(@"音频为空");
    }
}

-(void) didClickWithBtnId:(NSInteger) btnId
{
    CCHtomCatModel * model = self.imgsArr[btnId-1];
   
    [self loadAninmationWithName:model.name andCount:model.count];
 //   [self loadSoundsWithName:model.sound];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"OneDay";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"添加"] style:UIBarButtonItemStylePlain target:self action:@selector(addDiary)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索"] style:UIBarButtonItemStylePlain target:self action:@selector(searchDiary)];
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
    UILabel *textLable = [[UILabel alloc] init];
    textLable.text =@"早上好啊 铲屎官～";
    textLable.font=[UIFont systemFontOfSize:28];
    textLable.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [scrollView addSubview:textLable];
    [textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(236, 53));
        make.left.equalTo(scrollView).offset(50);
        make.top.equalTo(scrollView).offset(30);
    }];
    _timeLable = [[UILabel alloc] init];
    _timeLable.font=[UIFont systemFontOfSize:16];
    _timeLable.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [scrollView addSubview:_timeLable];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(169, 23));
        make.left.equalTo(scrollView).offset(64);
        make.top.equalTo(scrollView).offset(92);
    }];
    UIButton *imagebtn1=[[UIButton alloc]init];
    [imagebtn1 setBackgroundImage:[UIImage imageNamed:@"猫爪"] forState:UIControlStateNormal];
    [imagebtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    imagebtn1.userInteractionEnabled=NO;
    [scrollView addSubview:imagebtn1];
    [imagebtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 30));
        make.left.equalTo(scrollView).offset(305);
        make.top.equalTo(scrollView).offset(18);
    }];
    UIButton *imagebtn2=[[UIButton alloc]init];
    [imagebtn2 setBackgroundImage:[UIImage imageNamed:@"猫爪"] forState:UIControlStateNormal];
    [imagebtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    imagebtn2.userInteractionEnabled=NO;
    [scrollView addSubview:imagebtn2];
    [imagebtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 30));
        make.left.equalTo(scrollView).offset(364);
        make.top.equalTo(scrollView).offset(62);
    }];
    UIButton *imagebtn3=[[UIButton alloc]init];
    [imagebtn3 setBackgroundImage:[UIImage imageNamed:@"猫爪"] forState:UIControlStateNormal];
    [imagebtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    imagebtn3.userInteractionEnabled=NO;
    [scrollView addSubview:imagebtn3];
    [imagebtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 30));
        make.left.equalTo(scrollView).offset(298);
        make.top.equalTo(scrollView).offset(95);
    }];
    
    //猫咪模型
    _imgsAnimation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"猫咪"]];
    [scrollView addSubview:_imgsAnimation];
    [_imgsAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 230));
        make.centerX.equalTo(scrollView);
        make.top.equalTo(scrollView).offset(200);
    }];
    
    
    
    UIButton *eatbtn=[[UIButton alloc]init];
    [eatbtn setBackgroundImage:[UIImage imageNamed:@"猫粮"] forState:UIControlStateNormal];
    [eatbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [eatbtn addTarget:self action:@selector(eat) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:eatbtn];
    [eatbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(49, 47));
        make.left.equalTo(scrollView).offset(23);
        make.top.equalTo(scrollView).offset(272);
    }];
    UIButton *touchbtn=[[UIButton alloc]init];
    [touchbtn setBackgroundImage:[UIImage imageNamed:@"触摸"] forState:UIControlStateNormal];
    [touchbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [touchbtn addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:touchbtn];
    [touchbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 39));
        make.left.equalTo(scrollView).offset(337);
        make.top.equalTo(scrollView).offset(272);
    }];
    UIButton *playbtn=[[UIButton alloc]init];
    [playbtn setBackgroundImage:[UIImage imageNamed:@"陪他玩"] forState:UIControlStateNormal];
    [playbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [playbtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:playbtn];
    [playbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(49, 43));
        make.left.equalTo(scrollView).offset(184);
        make.top.equalTo(scrollView).offset(156);
    }];
    UIView *informationView = [[UIView alloc] init];
    informationView.backgroundColor = [UIColor whiteColor];
    informationView.layer.shadowColor=[UIColor grayColor].CGColor;
    informationView.layer.shadowOpacity=0.8;
    informationView.layer.shadowRadius=5;
    informationView.layer.shadowOffset=CGSizeMake(1, 2);
    [scrollView addSubview:informationView];
    [informationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scrollView);
        make.top.equalTo(scrollView).offset(465);
        make.size.mas_equalTo(CGSizeMake(371, 185));
    }];
    UILabel *textLable2 = [[UILabel alloc] init];
    textLable2.text =@"喵咪档案";
    textLable2.font=[UIFont systemFontOfSize:20];
    textLable2.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [informationView addSubview:textLable2];
    [textLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 29));
        make.centerX.equalTo(informationView);
        make.top.equalTo(informationView).offset(10);
    }];
    _textLable3 = [[UILabel alloc] init];
    _textLable3.textAlignment=NSTextAlignmentLeft;
    [_textLable3 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    _textLable3.textColor = [UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1];
    [informationView addSubview:_textLable3];
    [_textLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(185, 22));
        make.left.equalTo(informationView).offset(178);
        make.top.equalTo(informationView).offset(52);
    }];
    _nameLable = [[UILabel alloc] init];
    _nameLable.font=[UIFont systemFontOfSize:16];
    _nameLable.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [informationView addSubview:_nameLable];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(118, 22));
        make.left.equalTo(informationView).offset(26);
        make.top.equalTo(informationView).offset(52);
    }];
    _weightLable = [[UILabel alloc] init];
    _weightLable.font=[UIFont systemFontOfSize:16];
    _weightLable.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [informationView addSubview:_weightLable];
    [_weightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(118, 22));
        make.left.equalTo(informationView).offset(26);
        make.top.equalTo(informationView).offset(80);
    }];
    UILabel *hobbyLable = [[UILabel alloc] init];
    hobbyLable.text =@"爱好：逗人类玩";
    hobbyLable.font=[UIFont systemFontOfSize:16];
    hobbyLable.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [informationView addSubview:hobbyLable];
    [hobbyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(118, 22));
        make.left.equalTo(informationView).offset(26);
        make.top.equalTo(informationView).offset(108);
    }];
    UILabel *favoriteLable = [[UILabel alloc] init];
    favoriteLable.text =@"最爱：小鱼干";
    favoriteLable.font=[UIFont systemFontOfSize:16];
    favoriteLable.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [informationView addSubview:favoriteLable];
    [favoriteLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(118, 22));
        make.left.equalTo(informationView).offset(26);
        make.top.equalTo(informationView).offset(136);
    }];
    UILabel *numberLable = [[UILabel alloc] init];
    numberLable.text =@"亲密度";
    numberLable.textAlignment=NSTextAlignmentCenter;
    numberLable.font=[UIFont systemFontOfSize:18];
    numberLable.textColor = [UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    [informationView addSubview:numberLable];
    [numberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 25));
        make.left.equalTo(informationView).offset(238);
        make.top.equalTo(informationView).offset(91);
    }];
    _numberLable2 = [[UILabel alloc] init];
    _numberLable2.textAlignment=NSTextAlignmentCenter;
    [_numberLable2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    _numberLable2.textColor = [UIColor redColor];
    [informationView addSubview:_numberLable2];
    [_numberLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 25));
        make.centerX.equalTo(numberLable);
        make.top.equalTo(informationView).offset(125);
    }];
    UIButton *editbtn=[[UIButton alloc]init];
    editbtn.layer.shadowColor=[UIColor grayColor].CGColor;
    editbtn.layer.shadowOpacity=0.8;
    editbtn.layer.shadowRadius=5;
    editbtn.layer.shadowOffset=CGSizeMake(1, 2);
    editbtn.backgroundColor=[UIColor colorWithRed:227.0/255 green:168.0/255 blue:105.0/255 alpha:1];
    [editbtn setTitle:@"编辑猫咪档案" forState:UIControlStateNormal];
    [editbtn addTarget:self action:@selector(editpet) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:editbtn];
    [editbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(289, 41));
        make.centerX.equalTo(scrollView);
        make.top.equalTo(informationView).offset(210);
    }];
    [self initdata];
    // Do any additional setup after loading the view.
}
-(void)editpet
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"编辑猫咪档案"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         NSDictionary *dic1=@{
                                                                              @"phone":_phone, @"petname":alert.textFields[0].text
                                                                              };
                                                         AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
                                                         manager1.requestSerializer = [AFJSONRequestSerializer serializer];
                                                         manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                         [manager1 POST:@"http://localhost:8080/OneDay/pet/petName" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                             NSLog(@"%@",responseObject);
                                                             [[NSUserDefaults standardUserDefaults] setObject:alert.textFields[0].text forKey:@"petname"];
                                                             _petname=alert.textFields[0].text;
                                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                                             [self initdata];
                                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                             NSError *err=error;
                                                             NSLog(@"%@",err);
                                                             UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败" preferredStyle:UIAlertControllerStyleAlert];
                                                             [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                                                             [self presentViewController:alert animated:YES completion:nil];
                                                         }];
                                                         
                                                         
                                                         NSDictionary *dic2=@{
                                                                              @"phone":_phone, @"weight":alert.textFields[1].text
                                                                              };
                                                         AFHTTPSessionManager *manager2=[AFHTTPSessionManager manager];
                                                         manager2.requestSerializer = [AFJSONRequestSerializer serializer];
                                                         manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                         [manager2 POST:@"http://localhost:8080/OneDay/pet/petWeight" parameters:dic2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                             NSLog(@"%@",responseObject);
                                                             [[NSUserDefaults standardUserDefaults] setObject:alert.textFields[1].text forKey:@"weight"];
                                                             _weight=[alert.textFields[1].text integerValue];
                                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                                             [self initdata];
                                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                             NSError *err=error;
                                                             NSLog(@"%@",err);
                                                             UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败" preferredStyle:UIAlertControllerStyleAlert];
                                                             [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                                                             [self presentViewController:alert animated:YES completion:nil];
                                                         }];
                                                        
                                                         
                                                         
                                                         
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"喵名";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"体重";
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}
-(void)initdata
{
    _enddate=[NSDate date];
    _formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    _date2=[_formatter stringFromDate:_enddate];
     _timeLable.text =[NSString stringWithFormat:@"今天是 %@",_date2];
    //存储日期
    [[NSUserDefaults standardUserDefaults] setObject:_date2 forKey:@"date"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    NSDictionary *dic1=@{
                         @"phone":_phone,
                         };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager1 POST:@"http://localhost:8080/OneDay/pet" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *nsdic=responseObject;
        NSLog(@"%@",nsdic);
        _petname=[nsdic objectForKey:@"petname"];
        _birthday=[nsdic objectForKey:@"birthday"];
        _weight=[[nsdic objectForKey:@"weight"] integerValue];
        _intimacy=[[nsdic objectForKey:@"intimacy"] integerValue];
        [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"petname"] forKey:@"petname"];
        [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"birthday"] forKey:@"birthday"];
        [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"weight"] forKey:@"weight"];
        [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"intimacy"] forKey:@"intimacy"];
        _numberLable2.text =[NSString stringWithFormat:@"%ld%%",_intimacy];
        _weightLable.text =[NSString stringWithFormat:@"体重：%ld",_weight];
        NSDate *startdate=[_formatter dateFromString:_birthday];//日期加减
        NSCalendar *calendar=[NSCalendar currentCalendar];
        NSCalendarUnit unit=NSCalendarUnitDay;
        NSDateComponents *delta=[calendar components:unit fromDate:startdate toDate:_enddate options:0];
        _textLable3.text =[NSString stringWithFormat:@"它已经陪伴你%ld天了",delta.day];
        _nameLable.text =[NSString stringWithFormat:@"猫名：%@",_petname];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"同步数据失败" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    [self initdata];
}


-(void)searchDiary
{
    SearchDiaryViewController *searchVC=[[SearchDiaryViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
-(void)addDiary
{
    addDiaryViewController *addVC=[[addDiaryViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}
-(void)eat
{
    [self didClickWithBtnId:EAT];
    //修改亲密度
    _intimacy=_intimacy+1;
    NSDictionary *dic1=@{
                         @"phone":_phone,
                         @"intimacy":[NSNumber numberWithInteger:_intimacy],
                         };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager1 POST:@"http://localhost:8080/OneDay/pet/petIntimacy" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_intimacy] forKey:@"intimacy"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self initdata];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
    
    
    
    
    
    
    
}
-(void)play
{
    [self didClickWithBtnId:PLAY];
    _intimacy=_intimacy+1;
    NSDictionary *dic1=@{
                         @"phone":_phone,
                         @"intimacy":[NSNumber numberWithInteger:_intimacy],
                         };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager1 POST:@"http://localhost:8080/OneDay/pet/petIntimacy" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_intimacy] forKey:@"intimacy"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self initdata];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}
-(void)touch
{
    [self didClickWithBtnId:TOUCH];
    _intimacy=_intimacy+1;
    NSDictionary *dic1=@{
                         @"phone":_phone,
                         @"intimacy":[NSNumber numberWithInteger:_intimacy],
                         };
    AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager1 POST:@"http://localhost:8080/OneDay/pet/petIntimacy" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_intimacy] forKey:@"intimacy"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self initdata];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *err=error;
        NSLog(@"%@",err);
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
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
