//
//  stuinfocell.m
//  学生信息管理系统
//
//  Created by Mac-21 on 15/5/25.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "stuinfocell.h"

@implementation stuinfocell

- (void)awakeFromNib {
    // Initialization code
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor blackColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerX = 0;
    CGFloat dividerH = 1;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIteminfo:(NSString *)n
{
    if (![n isEqualToString:_iteminfo]) {
        _iteminfo = [n copy];
        self.infolable.text = _iteminfo;
    }
}

@end
