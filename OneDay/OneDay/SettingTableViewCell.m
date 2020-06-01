//
//  SettingTableViewCell.m
//  OneDay
//
//  Created by sw on 2020/5/7.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.masksToBounds=YES;
    self.btn.layer.cornerRadius=16;
    [self.btn setBackgroundImage:[UIImage imageNamed:@"开关 关"] forState:UIControlStateNormal];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"开关 开"] forState:UIControlStateSelected];
    [self.btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDown];
    // Initialization code
}
-(void)change:(UIButton *)btn
{
    [btn setSelected:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
