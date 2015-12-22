//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "MDConst.h"

@interface NIDropDown ()

@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize delegate;
@synthesize Offset;

- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr {
    
    btnSender = b;
//    if (self.Offset != 0) {
//        Offset = 45;
//    }
//    else
//    {
//        Offset = 0;
//    }

    self = [super init];
    if (self) {
        // Initialization code
        CGRect btn = b.frame;
        
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height+Offset, btn.size.width, 0);
        self.list = [NSArray arrayWithArray:arr];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.bounces = NO;
        table.backgroundColor = [UIColor clearColor];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if (*height>100) {
            *height=100;
        }
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height+Offset, btn.size.width, *height);
        
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        if (self.Offset != 0) {
            [b.superview.superview addSubview:self];
        }
        else
        {
            [b.superview addSubview:self];
        }

        
          [self addSubview:table];
    }
    return self;
}

-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height+Offset, btn.size.width, 0);
    table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}   


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.textLabel.font = [UIFont systemFontOfSize:self.font];
        
//        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        
        if (_textshowStyle == TextShowStyleLeft) {
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
        }
        else if (_textshowStyle == TextShowStyleRight)
        {
            cell.textLabel.textAlignment = NSTextAlignmentRight;

        }
        else
        {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;

        }
    }
    cell.textLabel.text =[list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:97/255 green:103/255 blue:111/255 alpha:1];
    cell.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = RedColor;
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:btnSender];
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate niDropDownDelegateMethod:self];   
}

-(void)dealloc {
    [super dealloc];
    [table release];
    [self release];
}

@end
