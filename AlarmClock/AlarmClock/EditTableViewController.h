//
//  EditTableViewController.h
//  AlarmClock
//
//  Created by lizhen on 17/2/27.
//  Copyright © 2017年 lizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^block)(NSString *time, NSInteger index);

@interface EditTableViewController : UITableViewController

@property (nonatomic ,copy)block option;

@end
