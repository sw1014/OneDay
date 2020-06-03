//
//  listDiaryTableViewCell.h
//  OneDay
//
//  Created by sw on 2020/5/6.
//  Copyright © 2020年 sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface listDiaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *event;
@property (weak, nonatomic) IBOutlet UILabel *mood;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property(nonatomic)NSString *content;
@property(nonatomic)NSString *idnumber;
@property(nonatomic)NSString *picurl;
@end
