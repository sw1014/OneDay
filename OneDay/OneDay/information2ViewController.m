//
//  information2ViewController.m
//  OneDay
//
//  Created by sw on 2020/5/6.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "information2ViewController.h"
#import "Masonry.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "User.h"
@interface information2ViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic)UITableView *tableview;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic)NSMutableArray *datasource1;
@property(nonatomic)NSMutableArray *datasource2;
@property(nonatomic,strong)UIImagePickerController *imagepicker;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *photo;

@end

@implementation information2ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"photo"];
    if ([str isEqualToString:@""])
    {
        _imageview.image=[UIImage imageNamed:@"默认头像"];
    
    }
    else
    {
        
        NSString *str2=@"http://localhost:8080";
        str2=[str2 stringByAppendingString:str];
        NSURL *urll=[NSURL URLWithString:str2];
        NSData *data=[NSData dataWithContentsOfURL:urll];
        _imageview.image=[UIImage imageWithData:data];
    }
    _username=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    _password=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    _phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    _email=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    _photo=[[NSUserDefaults standardUserDefaults]objectForKey:@"photo"];
    [self.tableview reloadData];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.topItem.title = @"";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:88/255.0 green:87/255.0 blue:86/255.0 alpha:1];
    _imageview=[[UIImageView alloc]init];
    _imageview.layer.masksToBounds=YES;
    _imageview.layer.cornerRadius=50;
    _imageview.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changephoto)];
    [_imageview addGestureRecognizer:tap];
    [self.view addSubview:_imageview];
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(75);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    

    
    _tableview=[[UITableView alloc]init];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(185);
        make.height.mas_equalTo(280);
    }];
    
    UIButton *btn1=[[UIButton alloc]init];
    btn1.backgroundColor=[UIColor redColor];
    [btn1 setTitle:@"切换账号" forState:UIControlStateNormal];
    btn1.layer.cornerRadius=4;
    btn1.layer.masksToBounds=YES;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(changeid) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(289, 41));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(459);
    }];
    
    // Do any additional setup after loading the view.
}
-(void)changephoto
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"更换头像" preferredStyle:UIAlertControllerStyleActionSheet];
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
    NSLog(@"放弃换头像");
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    _imageview.image=image;
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://localhost:8080/OneDay/user/profilePhoto" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        NSData *data1=[_phone  dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:data1 name:@"phone"];
        NSData *data=UIImageJPEGRepresentation(image, 0.7);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        //上传文件参数
        [formData appendPartWithFileData:data name:@"photo" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%.2lf%%", progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //成功之后修改phone
        NSDictionary *dic1=@{
         @"phone":_phone,
         @"password":_password,
         };
        AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
        manager1.requestSerializer = [AFJSONRequestSerializer serializer];
        manager1.responseSerializer = [AFJSONResponseSerializer serializer];
         [manager1 POST:@"http://localhost:8080/OneDay/user/login" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *nsdic=responseObject;
         NSLog(@"%@",nsdic);
             [[NSUserDefaults standardUserDefaults] setObject:[nsdic objectForKey:@"photo"] forKey:@"photo"];
             [[NSUserDefaults standardUserDefaults] synchronize];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSError *err=error;
             NSLog(@"%@",err);

             }];
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
        
    }];
    
    
}
-(void)changeid
{
    LoginViewController *vc=[[LoginViewController alloc]init];
    vc.modalPresentationStyle=UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2)//修改密码
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"修改密码"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                        //修改密码 可以对旧密码进行一下验证
                                                             
                                                             NSDictionary *dic1=@{
                                                                                  @"phone":_phone,
                                                                            @"password":alert.textFields[1].text
                                                                                  };
                                                             AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
                                                             manager1.requestSerializer = [AFJSONRequestSerializer serializer];
                                                             manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                             [manager1 POST:@"http://localhost:8080/OneDay/user/password" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                 NSLog(@"%@",responseObject);
                                                                 [[NSUserDefaults standardUserDefaults] setObject:alert.textFields[1].text forKey:@"password"];
                                                                 [[NSUserDefaults standardUserDefaults] synchronize];
                                                                 
                                                                 
                                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                 NSError *err=error;
                                                                 NSLog(@"%@",err);
                                                                 UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改密码失败" preferredStyle:UIAlertControllerStyleAlert];
                                                                 [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                                                                 [self presentViewController:alert animated:YES completion:nil];
                                                             }];
                                                             
                                                         }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"请输入旧密码";
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"请输入新密码";
            textField.secureTextEntry = YES;
        }];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if(indexPath.row==1)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"修改邮箱"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                             //修改邮箱 可以对旧邮箱进行一下验证
                                                             NSDictionary *dic1=@{
                                                                                  @"phone":_phone, @"email":alert.textFields[0].text
                                                                                  };
                                                             AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
                                                             manager1.requestSerializer = [AFJSONRequestSerializer serializer];
                                                             manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                             [manager1 POST:@"http://localhost:8080/OneDay/user/email" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                 NSLog(@"%@",responseObject);
                                                                 [[NSUserDefaults standardUserDefaults] setObject:alert.textFields[0].text forKey:@"email"];
                                                                 _email=alert.textFields[0].text;
                                                                 [[NSUserDefaults standardUserDefaults] synchronize];
                                                                 [self.tableview reloadData];
                                                                 
                                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                 NSError *err=error;
                                                                 NSLog(@"%@",err);
                                                                 UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改邮箱失败" preferredStyle:UIAlertControllerStyleAlert];
                                                                 [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                                                                 [self presentViewController:alert animated:YES completion:nil];
                                                             }];
                                                             
                                                             
                                                             
                                                         }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"请输入新邮箱";
        }];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (indexPath.row==0)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"修改昵称"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                             //修改邮箱 可以对旧邮箱进行一下验证
                                                             NSDictionary *dic1=@{
                                                                                  @"phone":_phone, @"username":alert.textFields[0].text
                                                                                  };
                                                             NSLog(@"!!!!");
                                                             NSLog(@"%@",_phone);
                                                             AFHTTPSessionManager *manager1=[AFHTTPSessionManager manager];
                                                             manager1.requestSerializer = [AFJSONRequestSerializer serializer];
                                                             manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
                                                             [manager1 POST:@"http://localhost:8080/OneDay/user/username" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                 NSLog(@"%@",responseObject);
                                                                 [[NSUserDefaults standardUserDefaults] setObject:alert.textFields[0].text forKey:@"username"];
                                                                 _username=alert.textFields[0].text;
                                                                 [[NSUserDefaults standardUserDefaults] synchronize];
                                                                 [self.tableview reloadData];
                                                                 
                                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                 NSError *err=error;
                                                                 NSLog(@"%@",err);
                                                                 UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"修改昵称失败" preferredStyle:UIAlertControllerStyleAlert];
                                                                 [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                                                                 [self presentViewController:alert animated:YES completion:nil];
                                                             }];
                                                             
                                                             
                                                             
                                                             
                                                         }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"请输入新昵称";
        }];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"cellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    self.datasource1=[[NSMutableArray alloc]init];
    _datasource1=@[@"修改昵称",@"邮箱",@"密码"];
    self.datasource2=[[NSMutableArray alloc]init];
    _datasource2=@[_username,_email,@"修改密码"];
    cell.textLabel.text=_datasource1[indexPath.row];
    cell.detailTextLabel.text=_datasource2[indexPath.row];
    return cell;
    
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
