//
//  ViewController.m
//  ProgressViewDemo
//
//  Created by Seraph on 2015/6/20.
//  Copyright (c) 2015年 Seraph. All rights reserved.
//

#import "ViewController.h"
#import "ProgressController.h"

@interface ViewController ()

@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) ProgressController *progressVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    
//    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//    progressView.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/3*1);
//    progressView.trackTintColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
//    [self.view addSubview:progressView];
//    _progressView = progressView;
    
    UIButton *runButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [runButton setTitle:@"running" forState:UIControlStateNormal];
    [runButton addTarget:self action:@selector(running) forControlEvents:UIControlEventTouchUpInside];
    [runButton sizeToFit];
    runButton.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/4*1);
    [self.view addSubview:runButton];
    
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [presentButton setTitle:@"present" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(presenting) forControlEvents:UIControlEventTouchUpInside];
    [presentButton sizeToFit];
    presentButton.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/4*2);
    [self.view addSubview:presentButton];
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [dismissButton setTitle:@"dimsiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [dismissButton sizeToFit];
    dismissButton.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/4*3);
    [self.view addSubview:dismissButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)running {
    if (_progressView.progress == 1) {
        _progressView.progress = 0;
    } else {
        _progressView.progress += 0.1;
    }
}

- (void)presenting {
    _progressVC = [[ProgressController alloc] init];
    [_progressVC presentInView:self.view completion:nil];
    _progressVC.numberOfTasks = 9;
    _progressVC.completedTasks = 5;
}

- (void)dismiss {
    [_progressVC dismiss];
    _progressVC = nil;
}

@end
