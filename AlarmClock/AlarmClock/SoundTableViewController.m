//
//  SoundTableViewController.m
//  AlarmClock
//
//  Created by lizhen on 17/2/27.
//  Copyright © 2017年 lizhen. All rights reserved.
//

#import "SoundTableViewController.h"

@interface SoundTableViewController ()
@property (nonatomic, strong) NSMutableArray *soundArray;

@end

@implementation SoundTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.soundArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"SoundTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.soundArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.soundOption)
    {
        self.soundOption(self.soundArray[indexPath.row],indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 懒加载
-(NSMutableArray *)soundArray
{
    if (!_soundArray) {
        
        _soundArray = [NSMutableArray arrayWithObjects:@"八音盒",
                       @"村庄的早晨",
                       @"滴答滴答",
                       @"海边小屋",
                       @"黑白琴键",
                       @"吉他扫弦",
                       @"经典滴滴声",
                       @"空谷回响",
                       @"马林巴琴",
                       @"美妙清晨",
                       @"木琴",
                       @"甜美舞曲",
                       @"自然晨曦", nil];
    }

    return _soundArray;
}

@end
