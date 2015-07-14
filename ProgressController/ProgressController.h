//
//  ProgressController.h
//  ProgressViewDemo
//
//  Created by Seraph.Lin on 2015/6/24.
//  Copyright (c) 2015年 Seraph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressController : UIViewController

/** Total number of tasks, defaults to 0. */
@property (assign, nonatomic) NSUInteger numberOfTasks;
/** Number of completed tasks, defaults to 0. */
@property (assign, nonatomic) NSUInteger completedTasks;

- (instancetype)initWIthTitle:(NSString *)title;
- (void)presentInView:(UIView *)presentingView completion:(void(^)(void))completion;
- (void)dismiss;

@end
