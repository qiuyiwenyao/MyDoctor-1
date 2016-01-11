/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */


#import "ChatListCell.h"
#import "UIImageView+HeadImage.h"
#import "MDConst.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface ChatListCell (){
    UILabel *_timeLabel;
    UILabel *_unreadLabel;
    UILabel *_detailLabel;
    UIView *_lineView;
    UIView * bgView;
}

@end

@implementation ChatListCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor clearColor];
        bgView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, appWidth-10, 80)];
        bgView.backgroundColor=[UIColor clearColor];
        
        //背景图层
        UIView * background=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth-10, 80)];
        background.backgroundColor=[UIColor whiteColor];
        background.alpha=0.6;
        [bgView addSubview:background];
        [self.contentView addSubview:bgView];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(bgView.frame.size.width - 110, 10, 110, 16)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_timeLabel];

        
        _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 3, 20, 20)];
        _unreadLabel.backgroundColor = [UIColor redColor];
        _unreadLabel.textColor = [UIColor whiteColor];
        
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.font = [UIFont systemFontOfSize:11];
        _unreadLabel.layer.cornerRadius = 10;
        _unreadLabel.clipsToBounds = YES;
        [bgView addSubview:_unreadLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 175, 20)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.textColor = [UIColor lightGrayColor];
        [bgView addSubview:_detailLabel];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        
//        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 1)];
//        _lineView.backgroundColor = RGBACOLOR(207, 210, 213, 0.7);
//        [self.contentView addSubview:_lineView];
        [bgView bringSubviewToFront:_unreadLabel];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = [UIColor redColor];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = [UIColor redColor];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.imageView.frame;
    
//    [self.imageView sd_setImageWithURL:_imageURL placeholderImage:_placeholderImage];
    [self.imageView imageWithUsername:_name placeholderImage:_placeholderImage];
    self.imageView.frame = CGRectMake(10, 10, 60, 60);
    [bgView addSubview:self.imageView];
    [bgView bringSubviewToFront:_unreadLabel];
//    self.textLabel.text = _name;
    [self.textLabel setTextWithUsername:_name];
    self.textLabel.frame = CGRectMake(80, 10, 175, 20);
    [bgView addSubview:self.textLabel];
    
    _detailLabel.text = _detailMsg;
    _timeLabel.text = _time;
    if (_unreadCount > 0) {
        if (_unreadCount < 9) {
            _unreadLabel.font = [UIFont systemFontOfSize:13];
        }else if(_unreadCount > 9 && _unreadCount < 99){
            _unreadLabel.font = [UIFont systemFontOfSize:12];
        }else{
            _unreadLabel.font = [UIFont systemFontOfSize:10];
        }
        [_unreadLabel setHidden:NO];
        [self.contentView bringSubviewToFront:_unreadLabel];
        _unreadLabel.text = [NSString stringWithFormat:@"%ld",(long)_unreadCount];
    }else{
        [_unreadLabel setHidden:YES];
    }
    
    frame = _lineView.frame;
    frame.origin.y = self.contentView.frame.size.height - 1;
    _lineView.frame = frame;
    
//    [self.contentView bringSubviewToFront:_unreadLabel];
}

-(void)setName:(NSString *)name{
    _name = name;
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
@end
