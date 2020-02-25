//
//  LYUViewController.m
//  LYUPods
//
//  Created by donglyu on 2020/2/21.
//

#import "LYUViewController.h"

@interface LYUViewController ()

@end

@implementation LYUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)LeaveThePage{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count == 1 || viewcontrollers == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
