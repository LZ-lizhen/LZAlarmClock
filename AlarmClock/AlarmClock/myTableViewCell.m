
//
//  myTableViewCell.m
//  AlarmClock
//
//  Created by lizhen on 17/2/27.
//  Copyright © 2017年 lizhen. All rights reserved.
//

#import "myTableViewCell.h"

@interface myTableViewCell ()

@end

@implementation myTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"myTableViewCell";
    myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[myTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self setupUI];
    
    return self;
}

-(void)setupUI{
    
    self.textLabel.text = @"70:40";
    self.textLabel.font = [UIFont systemFontOfSize:50];
    self.detailTextLabel.text = @"闹钟，每个工作日";
    self.detailTextLabel.font = [UIFont systemFontOfSize:16];
}

@end
