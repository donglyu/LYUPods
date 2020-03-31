//
//  LYUViewController.m
//  LYUPods
//
//  Created by donglyu on 02/19/2020.
//  Copyright (c) 2020 donglyu. All rights reserved.
//

#import "LYUDemoViewController.h"
#import <LYUPods.h>
@interface LYUDemoViewController ()

@end

@implementation LYUDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIColor *color = [UIColor colorWithHex:@"9999999"];
    
    NSString *dateStr = @"20:00";
    NSDate *time = [LYUDateKit DateFromString:dateStr Format:@"HH:mm"];
    NSLog(@"%@",time);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
