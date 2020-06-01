//
//  listDiaryTableViewCell.m
//  OneDay
//
//  Created by sw on 2020/5/6.
//  Copyright © 2020年 sw. All rights reserved.
//

#import "listDiaryTableViewCell.h"

@implementation listDiaryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius=9;
    self.contentView.layer.masksToBounds=YES;
    self.contentView.layer.borderColor=[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1].CGColor;
    self.contentView.layer.borderWidth=1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
