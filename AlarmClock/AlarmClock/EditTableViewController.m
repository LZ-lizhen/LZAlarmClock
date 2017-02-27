//
//  EditTableViewController.m
//  AlarmClock
//
//  Created by lizhen on 17/2/27.
//  Copyright © 2017年 lizhen. All rights reserved.
//

#import "EditTableViewController.h"
#import "NSDate+LZ.h"
#import "SoundTableViewController.h"

@interface EditTableViewController ()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIDatePicker *picter;
@property (nonatomic, strong) NSString *timeStr;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *soundName;

@end

@implementation EditTableViewController

-(void)save
{
    NSLog(@"保存");
    
    if (self.option) {
        
        self.option(self.timeStr, self.index);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dataChange:(UIDatePicker *)datePicker
{ //立项时间    
    // 创建日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"YYYY-MM-dd HH:mm"; //yyyy-MM-dd HH:mm:ss
//    NSString *time = [fmt stringFromDate:datePicker.date];

    NSString *timeStr =[NSDate timestampWithDate:datePicker.date WithFormat:@"YYYY-MM-dd HH:mm"];
    self.timeStr = timeStr;

    NSLog(@"返回的时间戳为:%@",timeStr );
    NSLog(@"返回的时间为:%@", [NSDate timeWithTimestamp:timeStr withTimeFormart:@"YYYY-MM-dd HH:mm"]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"编辑闹钟";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"存储" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.bounces = NO;
    
    //设置默认值
    _timeStr = [NSDate getCurrentTimestamp];
    _index = 1;
    _soundName = @"八音盒";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"selectProjectICellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"重复";
            cell.detailTextLabel.text = @"每一天";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"标签";
            cell.detailTextLabel.text = @"闹钟";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"铃声";
            cell.detailTextLabel.text = _soundName;
        }
            break;
        case 3:
        {
            
        }
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoundTableViewController *VC = [[SoundTableViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    VC.soundOption = ^(NSString *soundName, NSInteger index)
    {
        _index = index;
        _soundName = soundName;
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 懒加载
-(UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        [_headerView addSubview:self.picter];
    }
    
    return _headerView;
}

-(UIDatePicker *)picter
{
    if (!_picter)
    {
        _picter = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        _picter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _picter.datePickerMode = UIDatePickerModeCountDownTimer;
        [_picter addTarget:self action:@selector(dataChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _picter;
}



@end
