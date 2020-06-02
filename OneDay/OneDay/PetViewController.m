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
@property(nonatomic)UIButton *colorbtn1;
@property(nonatomic)UIButton *colorbtn2;
@property(nonatomic)UIButton *colorbtn3;
@property(nonatomic)NSString *color;
@property(nonatomic)UIView *editview;
@property(nonatomic,strong)UITextField *textfield1;
@property(nonatomic,strong)UITextField *textfield2;
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
        _color=[[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
        NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%@_%02ld.png",name,_color,i] ofType:nil];
        NSString *stra=[NSString stringWithFormat:@"%@_%@_%02ld.png",name,_color,i];
        NSLog(@"%@",stra);
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
//加载动画
-(void) didClickWithBtnId:(NSInteger) btnId
{
    CCHtomCatModel * model = self.imgsArr[btnId-1];
   
    [self loadAninmationWithName:model.name andCount:model.count];
    [self loadSoundsWithName:model.sound];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
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
    textLable.text =@"你好啊 铲屎官～";
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
    _imgsAnimation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@猫咪",_color]]];
    [scrollView addSubview:_imgsAnimation];
    [_imgsAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 230));
        make.centerX.equalTo(scrollView);
        make.top.equalTo(scrollView).offset(200);
    }];
    UIButton *touchbtn=[[UIButton alloc]init];
      // [touchbtn setBackgroundImage:[UIImage imageNamed:@"触摸"] forState:UIControlStateNormal];
       [touchbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [touchbtn addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchDown];
       [scrollView addSubview:touchbtn];
       [touchbtn mas_makeConstraints:^(MASConstraintMaker *make) {
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

    UIButton *playbtn=[[UIButton alloc]init];
    [playbtn setBackgroundImage:[UIImage imageNamed:@"陪他玩"] forState:UIControlStateNormal];
    [playbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [playbtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:playbtn];
    [playbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(49, 47));
        make.left.equalTo(scrollView).offset(347);
        make.top.equalTo(scrollView).offset(272);
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
    
    UIButton *fish=[[UIButton alloc]init];
    [informationView addSubview:fish];
    [fish setImage:[UIImage imageNamed:@"香辣鱼干"] forState:UIControlStateNormal];
    [fish addTarget:self action:@selector(editinformation) forControlEvents:UIControlEventTouchDown];
    [fish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(49, 47));
        make.left.equalTo(informationView).offset(320);
        make.top.equalTo(informationView).offset(2);
    }];
    [self initdata];
    // Do any additional setup after loading the view.
}
//出现编辑面板
-(void)editinformation
{
    _editview=[[UIView alloc]initWithFrame:CGRectMake(18,200 , 380, 311)];
    _editview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_editview];
    _editview.layer.masksToBounds=YES;
    _editview.layer.cornerRadius=15;
    _editview.layer.borderColor=[UIColor colorWithRed:255.0/255 green:208.0/255 blue:129.0/255 alpha:1].CGColor;
    _editview.layer.borderWidth=1;
    UILabel *label1=[[UILabel alloc]init];
    [_editview addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(178, 40));
        make.centerX.equalTo(_editview);
        make.top.equalTo(_editview).offset(15);
    }];
    label1.font=[UIFont systemFontOfSize:28];
    label1.text=@"修改猫咪档案";
    
    UILabel *label2=[[UILabel alloc]init];
    [_editview addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(90, 36));
        make.top.equalTo(_editview).offset(74);
        make.left.equalTo(_editview).offset(61);
    }];
    label2.font=[UIFont systemFontOfSize:25];
    label2.text=@"喵名：";
    
    UILabel *label3=[[UILabel alloc]init];
    [_editview addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(90, 36));
        make.top.equalTo(_editview).offset(134);
        make.left.equalTo(_editview).offset(61);
    }];
    label3.font=[UIFont systemFontOfSize:25];
    label3.text=@"体重：";
    
    UILabel *label4=[[UILabel alloc]init];
    [_editview addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(90, 36));
        make.top.equalTo(_editview).offset(194);
        make.left.equalTo(_editview).offset(61);
    }];
    label4.font=[UIFont systemFontOfSize:25];
    label4.text=@"颜色：";
    
    _textfield1=[[UITextField alloc]init];
    [_editview addSubview:_textfield1];
    _textfield1.text=_petname;
    
    _textfield1.layer.masksToBounds=YES;
    _textfield1.layer.cornerRadius=9;
    _textfield1.borderStyle=UITextBorderStyleLine;
    _textfield1.layer.borderColor=[UIColor grayColor].CGColor;
    [_textfield1 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(197, 41));
        make.top.equalTo(_editview).offset(72);
        make.left.equalTo(_editview).offset(147);
    }];
    _textfield2=[[UITextField alloc]init];
    _textfield2.text=[NSString stringWithFormat:@"%ld",(long)_weight];
    [_editview addSubview:_textfield2];
    _textfield2.layer.masksToBounds=YES;
    _textfield2.layer.cornerRadius=9;
    _textfield2.borderStyle=UITextBorderStyleLine;
    _textfield2.layer.borderColor=[UIColor grayColor].CGColor;
    [_textfield2 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(197,41));
        make.top.equalTo(_editview).offset(131);
        make.left.equalTo(_editview).offset(147);
    }];
    
    _colorbtn1=[[UIButton alloc]init];
    [_colorbtn1 setTitle:@"gray" forState:UIControlStateNormal];
    _colorbtn1.layer.borderColor=[UIColor grayColor].CGColor;
    [_colorbtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _colorbtn1.layer.borderWidth=1;
    _colorbtn1.layer.masksToBounds=YES;
    _colorbtn1.layer.cornerRadius=4;
    [_colorbtn1 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    _colorbtn1.backgroundColor=[UIColor whiteColor];
    [_editview addSubview:_colorbtn1];
    [_colorbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(66, 41));
        make.left.equalTo(_editview).offset(146);
        make.top.equalTo(_editview).offset(194);
    }];
    _colorbtn2=[[UIButton alloc]init];
    [_colorbtn2 setTitle:@"orange" forState:UIControlStateNormal];
    [_colorbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _colorbtn2.layer.borderColor=[UIColor grayColor].CGColor;
    _colorbtn2.layer.borderWidth=1;
    _colorbtn2.layer.masksToBounds=YES;
    _colorbtn2.layer.cornerRadius=4;
    [_colorbtn2 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    _colorbtn2.backgroundColor=[UIColor whiteColor];
    [_editview addSubview:_colorbtn2];
    [_colorbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(66, 41));
        make.left.equalTo(_editview).offset(211);
        make.top.equalTo(_editview).offset(194);
    }];
    _colorbtn3=[[UIButton alloc]init];
    [_colorbtn3 setTitle:@"yellow" forState:UIControlStateNormal];
    [_colorbtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _colorbtn3.layer.borderColor=[UIColor grayColor].CGColor;
    _colorbtn3.layer.borderWidth=1;
    _colorbtn3.layer.masksToBounds=YES;
    _colorbtn3.layer.cornerRadius=4;
    [_colorbtn3 addTarget:self action:@selector(changecolor:) forControlEvents:UIControlEventTouchDown];
    _colorbtn3.backgroundColor=[UIColor whiteColor];
    [_editview addSubview:_colorbtn3];
    [_colorbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(66, 41));
        make.left.equalTo(_editview).offset(276);
        make.top.equalTo(_editview).offset(194);
    }];
    
    UIButton *editbtn=[[UIButton alloc]init];
    [editbtn setTitle:@"确定" forState:UIControlStateNormal];
    [editbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editbtn.layer.borderColor=[UIColor grayColor].CGColor;
    editbtn.layer.borderWidth=1;
    editbtn.layer.masksToBounds=YES;
    editbtn.layer.cornerRadius=12;
    [editbtn addTarget:self action:@selector(editpet) forControlEvents:UIControlEventTouchDown];
    editbtn.backgroundColor=[UIColor whiteColor];
    [_editview addSubview:editbtn];
    [editbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 45));
        make.left.equalTo(_editview).offset(69);
        make.top.equalTo(_editview).offset(249);
    }];
    
    UIButton *cancelbtn=[[UIButton alloc]init];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelbtn.layer.borderColor=[UIColor grayColor].CGColor;
    cancelbtn.layer.borderWidth=1;
    cancelbtn.layer.masksToBounds=YES;
    cancelbtn.layer.cornerRadius=12;
    [cancelbtn addTarget:self action:@selector(canceledit) forControlEvents:UIControlEventTouchDown];
    cancelbtn.backgroundColor=[UIColor whiteColor];
    [_editview addSubview:cancelbtn];
    [cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 45));
        make.left.equalTo(_editview).offset(226);
        make.top.equalTo(_editview).offset(249);
    }];
    
    
    
}
-(void)changecolor:(UIButton *)btn
{
    if (btn.selected)
    {
        btn.backgroundColor=[UIColor whiteColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.selected=NO;
    }
    else
    {
        _colorbtn1.selected=NO;
        _colorbtn2.selected=NO;
        _colorbtn3.selected=NO;
        _colorbtn1.backgroundColor=[UIColor whiteColor];
        _colorbtn2.backgroundColor=[UIColor whiteColor];
        _colorbtn3.backgroundColor=[UIColor whiteColor];
        btn.backgroundColor=[UIColor colorWithRed:255.0/255 green:208.0/255 blue:129.0/255 alpha:1];
        btn.selected=YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    _color=btn.titleLabel.text;
}




//编辑宠物档案
-(void)editpet
{
    
    
    _editview.frame=CGRectMake(-380, -311, _editview.bounds.size.width, _editview.bounds.size.height);
 NSDictionary *dic1=@{
                      @"phone":_phone,
                      @"petname":_textfield1.text
                      };
 AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
 manager1.requestSerializer = [AFJSONRequestSerializer serializer];
 manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
 [manager1 POST:@"http://localhost:8080/OneDay/pet/petName" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSLog(@"%@",responseObject);
     [[NSUserDefaults standardUserDefaults] setObject:_textfield1.text forKey:@"petname"];
     _petname=_textfield1.text;
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
                      @"phone":_phone,
                      @"weight":_textfield2.text,
                      };
 AFHTTPSessionManager *manager2=[AFHTTPSessionManager manager];
 manager2.requestSerializer = [AFJSONRequestSerializer serializer];
 manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
 [manager2 POST:@"http://localhost:8080/OneDay/pet/petWeight" parameters:dic2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSLog(@"%@",responseObject);
     [[NSUserDefaults standardUserDefaults] setObject:_textfield2.text forKey:@"weight"];
     _weight=[_textfield2.text integerValue];
     [[NSUserDefaults standardUserDefaults] synchronize];
     [self initdata];
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSError *err=error;
     NSLog(@"%@",err);
     UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败" preferredStyle:UIAlertControllerStyleAlert];
     [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
     [self presentViewController:alert animated:YES completion:nil];
 }];
    NSDictionary *dic3=@{
                         @"phone":_phone,
                         @"color":_color,
                         };
    AFHTTPSessionManager *manager3=[AFHTTPSessionManager manager];
    manager3.requestSerializer = [AFJSONRequestSerializer serializer];
    manager3.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager3 POST:@"http://localhost:8080/OneDay/pet/petColor" parameters:dic3 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [[NSUserDefaults standardUserDefaults] setObject:_color forKey:@"color"];
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
//取消编辑宠物档案
-(void)canceledit
{
    _editview.frame=CGRectMake(-380, -311, _editview.bounds.size.width, _editview.bounds.size.height);
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
        _color=[nsdic objectForKey:@"color"];
        [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"color"] forKey:@"color"];
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
        _imgsAnimation.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@猫咪",_color]];
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
