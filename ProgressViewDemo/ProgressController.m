//
//  ProgressController.m
//  ProgressViewDemo
//
//  Created by Seraph.Lin on 2015/6/24.
//  Copyright (c) 2015年 Seraph. All rights reserved.
//

#import "ProgressController.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define AnimationDuration 0.2

#pragma mark Class ProgressPannelView
@interface ProgressPannelView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UILabel *percentageLabel;
@property (strong, nonatomic) UILabel *portionLabel;
@property (assign, nonatomic) NSUInteger numberOfTasks;
@property (assign, nonatomic) NSUInteger completedTasks;

@end

@implementation ProgressPannelView

@synthesize numberOfTasks;
@synthesize completedTasks;

- (instancetype)init {
    if (self = [super init]) {
        
        BOOL blurEnable = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:blurEnable ? 0 : 0.95];
        self.frame = CGRectMake(0, 0, 280, 120);
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        
        if (blurEnable) {
            UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
            blurView.frame = self.bounds;
            [self addSubview:blurView];
        }
        
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        [self addMotionEffect:horizontalMotionEffect];
        [self addMotionEffect:verticalMotionEffect];
        
        UIColor *bgColor = [UIColor clearColor];
        CGRect lineRect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 40);
        lineRect = CGRectInset(lineRect, 20, 0);
        lineRect = CGRectOffset(lineRect, 0, 10);
        _titleLabel = [[UILabel alloc] initWithFrame:lineRect];
        _titleLabel.backgroundColor = bgColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:_titleLabel];
        
        _progressView = [[UIProgressView alloc] initWithFrame:lineRect];
        _progressView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _progressView.progress = 0.5;
        [self addSubview:_progressView];
        
        lineRect.origin.y = CGRectGetMaxY(self.bounds) - CGRectGetHeight(lineRect) - 10;
        _percentageLabel = [[UILabel alloc] initWithFrame:lineRect];
        _percentageLabel.backgroundColor = bgColor;
        _percentageLabel.textColor = [UIColor grayColor];
        _percentageLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_percentageLabel];
        
        _portionLabel = [[UILabel alloc] initWithFrame:lineRect];
        _portionLabel.backgroundColor = bgColor;
        _portionLabel.textColor = [UIColor grayColor];
        _portionLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_portionLabel];

    }
    return self;
}

- (void)viewWillLayoutSubviews {

}

- (void)setNumberOfTasks:(NSUInteger)newNumber {
    numberOfTasks = newNumber;
    [self updateProgress];
}

- (void)setCompletedTasks:(NSUInteger)newNumber {
    completedTasks = newNumber;
    [self updateProgress];
}

- (void)updateProgress {
    float progress = (self.numberOfTasks > 0) ? ((float)self.completedTasks/self.numberOfTasks) : 0;
    _progressView.progress = progress;
    _percentageLabel.text = [NSString stringWithFormat:@"%.0f%%", progress*100];
    _portionLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.completedTasks, self.numberOfTasks];
}

@end

#pragma mark - Class ProgressViewController
@interface ProgressController ()

@property (strong, nonatomic) ProgressPannelView *pannelView;


@end

@implementation ProgressController

@synthesize numberOfTasks;
@synthesize completedTasks;

- (instancetype)init {
    if (self = [super init]) {
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _pannelView = [[ProgressPannelView alloc] init];
        _pannelView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
        _pannelView.numberOfTasks = 0;
        _pannelView.completedTasks = 0;
        [self.view addSubview:_pannelView];
    }
    return self;
}

- (instancetype)initWIthTitle:(NSString *)title {
    if (self = [self init]) {
        _pannelView.titleLabel.text = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {

}

- (void)presentInView:(UIView *)presentingView completion:(void(^)(void))completion {
    self.view.center = CGPointMake(CGRectGetMidX(presentingView.bounds), CGRectGetMidY(presentingView.bounds));
    self.view.alpha = 0;
    [presentingView addSubview:self.view];
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.view.alpha = 1;
    }];
    if (completion) completion();
}

- (void)dismiss {
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
}

- (void)setNumberOfTasks:(NSUInteger)newNumber {
    numberOfTasks = newNumber;
    _pannelView.numberOfTasks = newNumber;
}

- (void)setCompletedTasks:(NSUInteger)newNumber {
    completedTasks = newNumber;
    _pannelView.completedTasks = newNumber;
}

@end
