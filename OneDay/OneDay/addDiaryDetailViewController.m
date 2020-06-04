//
//  addDiaryDetailViewController.m
//  OneDay
//
//  Created by sw on 2020/4/29.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "addDiaryDetailViewController.h"
#import "Diary.h"
#import "Masonry.h"
#import "CQTextView.h"
#import "PetViewController.h"
#import "AFNetworking.h"
@interface addDiaryDetailViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UITextField *textfield1;
@property(nonatomic,strong)CQTextView *textview1;
@end

@implementation addDiaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"保存"] style:UIBarButtonItemStylePlain target:self action:@selector(saveDiary)];
    
    _imageview=[[UIImageView alloc]init];
    _imageview.backgroundColor=[UIColor colorWithRed:232/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    _imageview.userInteractionEnabled=YES;
    
    [self.view addSubview:_imageview];
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(197);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(43);
    }];
    
    UIButton *photobtn=[[UIButton alloc]init];
    photobtn.layer.cornerRadius=35;
    photobtn.layer.masksToBounds=YES;
    photobtn.backgroundColor=[UIColor grayColor];
    [photobtn addTarget:self action:@selector(takephoto) forControlEvents:UIControlEventTouchDown];
    [photobtn setImage:[UIImage imageNamed:@"照相机"] forState:UIControlStateNormal];
    [_imageview addSubview:photobtn];
    [photobtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.centerX.equalTo(_imageview);
        make.top.equalTo(_imageview).offset(59);
    }];
    _textfield1=[[UITextField alloc]init];
    _textfield1.borderStyle=UITextBorderStyleNone;
    _textfield1.placeholder=@"给这篇日记取一个标题吧...";
    [self.view addSubview:_textfield1];
    [_textfield1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(283);
        make.left.equalTo(self.view).offset(30);
        make.size.mas_equalTo(CGSizeMake(251, 37));
    }];
    UIView *view2=[[UIView alloc]init];
    view2.backgroundColor=[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(316);
        make.left.equalTo(self.view).offset(33);
        make.size.mas_equalTo(CGSizeMake(231, 1));
    }];
    
   
    _textview1=[[CQTextView alloc]initWithFrame:CGRectMake(33, 336, 348, 70)];
    [self.view addSubview:_textview1];
    _textview1.backgroundColor=[UIColor clearColor];
    _textview1.font=[UIFont systemFontOfSize:16];
    _textview1.placeholder=@"快告诉大橘今天主人到底过的怎么样呢";
    
    
    
}
-(void)takephoto
{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    NSLog(@"取消拍照");
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    _imageview.image=image;
   
    
    
}
-(void)saveDiary
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"是否保存为日记"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"mood"];
                                                             [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"weather"];
                                                             [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"event"];
                                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                                             for(UIViewController*vc in self.navigationController.viewControllers) {
                                                                 
                                                                 if([vc isKindOfClass:[PetViewController class]]) {
                                                                     [self.navigationController popToViewController:vc animated:YES];
                                                                     
                                                                 }
                                                             }
                                                             
                                                             
                                                         }];
    
    
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action)
                                   {
                                       NSString *content=_textview1.textView.text;
                                       NSString *title=_textfield1.text;
        if ([title isEqualToString:@""])
        {
            title=@"标题为空";
        }
        if ([content isEqualToString:@""])
        {
            content=@"内容为空";
        }
        
                                       NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
                                       NSString *weather=[[NSUserDefaults standardUserDefaults]objectForKey:@"weather"];
                                       NSString *event=[[NSUserDefaults standardUserDefaults]objectForKey:@"event"];                          NSString *mood=[[NSUserDefaults standardUserDefaults]objectForKey:@"mood"];
                                       NSString *draft=@"false";
                                       NSDictionary *dic1=@{
                                                            @"phone":phone,
                                                            @"content":content,
                                                            @"weather":weather,
                                                            @"event":event,
                                                            @"mood":mood,
                                                            @"draft":draft,
                                                            @"title":title,
                                                            };
                                       
                                       AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
                                       
                                       manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                                       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                                       [manager POST:@"http://localhost:8080/OneDay/diary/newDiary" parameters:dic1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
                                        {
                                           if (_imageview.image)
                                           {
                                               NSData *data=UIImageJPEGRepresentation(_imageview.image, 0.7);
                                                                                          NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                                          formatter.dateFormat = @"yyyyMMddHHmmss";
                                                                                          NSString *str = [formatter stringFromDate:[NSDate date]];
                                                                                          NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                                                                                          //上传文件参数
                                                                                          [formData appendPartWithFileData:data name:@"picture" fileName:fileName mimeType:@"image/jpeg"];
                                           }
                                           else
                                           {
                                               UIImage *image=[UIImage imageNamed:@"猫咪2"];
                                               NSData *data=UIImageJPEGRepresentation(image, 0.7);
                                               NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                               formatter.dateFormat = @"yyyyMMddHHmmss";
                                               NSString *str = [formatter stringFromDate:[NSDate date]];
                                               NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                                               //上传文件参数
                                               [formData appendPartWithFileData:data name:@"picture" fileName:fileName mimeType:@"image/jpeg"];
                                           }
                                            
                                        } progress:^(NSProgress * _Nonnull uploadProgress) {
                                            
                                            //打印上传进度
                                            CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
                                            NSLog(@"%.2lf%%", progress);
                                            
                                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    
                                            //请求成功
                                            NSLog(@"请求成功：%@",responseObject);
                                            
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            
                                            //请求失败
                                            NSLog(@"请求失败：%@",error);
                                            
                                        }];
                                       [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"mood"];
                                       [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"weather"];
                                       [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"event"];
                                       [[NSUserDefaults standardUserDefaults] synchronize];
                                       
                                       for(UIViewController*vc in self.navigationController.viewControllers)
                                       {
                                           if([vc isKindOfClass:[PetViewController class]])
                                           {
                                               [self.navigationController popToViewController:vc animated:YES];
                                           }
                                           
                                       }
                                       
                                   }];
    
    
    
    
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"存为草稿" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                    
                                                           NSString *content=_textview1.textView.text;
                                                           NSString *title=_textfield1.text;
        if ([title isEqualToString:@""])
               {
                   title=@"标题为空";
               }
               if ([content isEqualToString:@""])
               {
                   content=@"内容为空";
               }
                                                           NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
                                                           NSString *weather=[[NSUserDefaults standardUserDefaults]objectForKey:@"weather"];
                                                           NSString *event=[[NSUserDefaults standardUserDefaults]objectForKey:@"event"];                                       NSString *mood=[[NSUserDefaults standardUserDefaults]objectForKey:@"mood"];
                                                           NSString *draft=@"true";
                                                           NSDictionary *dic1=@{
                                                                                @"phone":phone,
                                                                                @"content":content,
                                                                                @"weather":weather,
                                                                                @"event":event,
                                                                                @"mood":mood,
                                                                                @"draft":draft,
                                                                                @"title":title,
                                                                                };
                                                           
                                                           AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
                                                           
                                                           manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                                                           manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                           [manager POST:@"http://localhost:8080/OneDay/diary/newDiary" parameters:dic1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
                                                            {
                                                                
                                                                
                                                                NSData *data=UIImageJPEGRepresentation(_imageview.image, 0.7);
                                                                if (data!=nil)
                                                                {
                                                                    
                                                                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                    formatter.dateFormat = @"yyyyMMddHHmmss";
                                                                    NSString *str = [formatter stringFromDate:[NSDate date]];
                                                                    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                                                                    //上传文件参数
                                                                    [formData appendPartWithFileData:data name:@"picture" fileName:fileName mimeType:@"image/jpeg"];
                                                                    
                                                                    
                                                                }
                                                                
                                                               
                                                                
                                                            } progress:^(NSProgress * _Nonnull uploadProgress) {
                                                                
                                                                //打印上传进度
                                                                CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
                                                                NSLog(@"%.2lf%%", progress);
                                                                
                                                            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                
                                                                //请求成功
                                                                NSLog(@"请求成功：%@",responseObject);
                                                                
                                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                
                                                                //请求失败
                                                                NSLog(@"请求失败：%@",error);
                                                                
                                                            }];
                                                           [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"mood"];
                                                           [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"weather"];
                                                           [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"event"];
                                                           [[NSUserDefaults standardUserDefaults] synchronize];
                                                           
                                                           
                                                           for(UIViewController*vc in self.navigationController.viewControllers) {
                                                               
                                                               if([vc isKindOfClass:[PetViewController class]]) {
                                                                   [self.navigationController popToViewController:vc animated:YES];
                                                                   
                                                               }
                                                               
                                                           }
                                                       }];
    [alert addAction:saveAction];
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
