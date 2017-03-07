//
//  SoundTableViewController.m
//  AlarmClock
//
//  Created by lizhen on 17/2/27.
//  Copyright © 2017年 lizhen. All rights reserved.
//

#import "SoundTableViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface SoundTableViewController ()<AVAudioPlayerDelegate>
{
    AVAudioPlayer *avAudioPlayer;   //播放器player
}
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
    
    //播放音乐
    [self sharePlayerWithSoundName:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    
//    [self.navigationController popViewControllerAnimated:YES];
}


//初始化播放器
-(void)sharePlayerWithSoundName:(NSString *)soundName
{
    //从budle路径下读取音频文件　　这个文件名是你的歌曲名字,mp3是你的音频格式
    NSString *string = [[NSBundle mainBundle] pathForResource:soundName ofType:@"m4r"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    avAudioPlayer.delegate = self;
    
    //设置初始音量大小
    // avAudioPlayer.volume = 1;
    
    //设置音乐播放次数  -1为一直循环
    avAudioPlayer.numberOfLoops = 0;
    
    //预播放
    [avAudioPlayer prepareToPlay];
    
    [avAudioPlayer play];
}

#pragma mark 懒加载
-(NSMutableArray *)soundArray
{
    if (!_soundArray)
    {
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
