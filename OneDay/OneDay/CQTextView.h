//
//  CQTextView.h
//  OneDay
//
//  Created by sw on 2020/5/5.
//  Copyright © 2020年 sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQTextView : UIView
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UITextView *textView;
@end
