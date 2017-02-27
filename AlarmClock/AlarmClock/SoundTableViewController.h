//
//  SoundTableViewController.h
//  AlarmClock
//
//  Created by lizhen on 17/2/27.
//  Copyright © 2017年 lizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^soundBlock)(NSString *soundName, NSInteger index);

@interface SoundTableViewController : UITableViewController

@property (nonatomic ,copy)soundBlock soundOption;
@end
