//
//  TableViewController.m
//  AlarmClock
//
//  Created by lizhen on 17/2/27.
//  Copyright © 2017年 lizhen. All rights reserved.
//

#import "TableViewController.h"

#import <UserNotifications/UserNotifications.h>

#import "myTableViewCell.h"
#import "EditTableViewController.h"
#import "NSDate+LZ.h"



@interface TableViewController ()

@property (nonatomic, assign) int index;

@property (nonatomic, strong) NSMutableArray *timeArray;

@end

@implementation TableViewController

-(void)add
{
    EditTableViewController *VC = [[EditTableViewController alloc] init];
    
    __weak typeof(self) weakSelf = self;
    VC.option = ^(NSString *time, NSInteger index)
    {
        [weakSelf localNotificationForIOS1OWithTimeStr:time WithIndexSound:index];
        [weakSelf.timeArray addObject:time];
        [weakSelf.tableView reloadData];
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 100;
    self.navigationItem.title = @"闹钟";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *timeStr = self.timeArray[indexPath.row];
    
    myTableViewCell *cell = [myTableViewCell cellWithTableView:tableView];    
    cell.textLabel.text = [NSDate timeWithTimestamp:timeStr withTimeFormart:@"HH:mm"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditTableViewController *VC = [[EditTableViewController alloc] init];
   
    __weak typeof(self) weakSelf = self;
    VC.option = ^(NSString *time, NSInteger index)
    {
        [weakSelf localNotificationForIOS1OWithTimeStr:time WithIndexSound:index];
        [weakSelf.timeArray addObject:time];
        [weakSelf.tableView reloadData];
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)localNotificationForIOS1OWithTimeStr:(NSString *)timeStr WithIndexSound:(NSInteger )index
{
    // 申请通知权限
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted)
        {
            // 1、创建通知内容，注：这里得用可变类型的UNMutableNotificationContent，否则内容的属性是只读的
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            
            // 内容
            content.body = @"主人起床了";
            
            
            // 通知的提示声音，这里用的默认的声音
            NSString *soundName = [NSString stringWithFormat:@"%ld.m4r",index];
            content.sound =[UNNotificationSound soundNamed:soundName];
            
            NSLog(@"%@",soundName);
            
            content.categoryIdentifier = @"categoryIdentifier";
            
            
            // 2、创建通知触发
            NSDateComponents* date = [[NSDateComponents alloc] init];
//            date.year = [[NSDate timeWithTimestamp:timeStr withTimeFormart:@"YYYY"] integerValue];
//            date.month = [[NSDate timeWithTimestamp:timeStr withTimeFormart:@"MM"] integerValue];
//            date.day = [[NSDate timeWithTimestamp:timeStr withTimeFormart:@"dd"] integerValue];
            date.hour = [[NSDate timeWithTimestamp:timeStr withTimeFormart:@"HH"] integerValue];
            date.minute = [[NSDate timeWithTimestamp:timeStr withTimeFormart:@"mm"] integerValue];
            
            NSLog(@"所选时间为:%ld-%ld-%ld-%ld-%ld",date.year,date.month,date.day,date.hour,date.minute);
            
            UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger
                                                      triggerWithDateMatchingComponents:date repeats:YES];

            
//            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
            
            /* 触发器分三种：
             UNTimeIntervalNotificationTrigger : 在一定时间后触发，如果设置重复的话，timeInterval不能小于60
             UNCalendarNotificationTrigger : 在某天某时触发，可重复
             UNLocationNotificationTrigger : 进入或离开某个地理区域时触发
             */
            
            // 3、创建通知请求
            NSString *requestWithIdentifier = [NSString stringWithFormat:@"KFGroupNotification%ld",index];
            UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:requestWithIdentifier content:content trigger:trigger];
            
            // 4、将请求加入通知中心
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
                if (error == nil)
                {
                    NSLog(@"已成功加推送%@",notificationRequest.identifier);
                }
            }];
        }
    }];
}

#pragma mark 懒加载
-(NSMutableArray *)timeArray{

    if (!_timeArray) {
        
        _timeArray = [NSMutableArray array];
    }

    return _timeArray;
}

@end
