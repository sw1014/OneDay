//
//  listDiaryViewController.h
//  OneDay
//
//  Created by sw on 2020/5/6.
//  Copyright © 2020年 sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface listDiaryViewController : UIViewController
@property(nonatomic,strong)NSString *date;
@property(nonatomic)UITableView *tableview;
@property(nonatomic)NSMutableArray *datasource;
@property(nonatomic)BOOL draft;
-(void)initdata;
@end
