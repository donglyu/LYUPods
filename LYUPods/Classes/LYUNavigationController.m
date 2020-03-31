//
//  LYUNavigationController.m
//  LYUPods
//
//  Created by donglyu on 2020/2/21.
//

#import "LYUNavigationController.h"
#import "LYUViewController.h"

@interface LYUNavigationController ()

@end

@implementation LYUNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {
        
        UIImage *image = [UIImage imageNamed:@"fanhui"];
        if (image) {
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(tapBackItem)];
            viewController.navigationItem.leftBarButtonItem = backItem;
        }else{
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(tapBackItem)];
            viewController.navigationItem.leftBarButtonItem = backItem;
        }
        
    }
}

- (void)tapBackItem{
    
    if ([self.viewControllers.lastObject isKindOfClass:[LYUViewController class]]) {
        LYUViewController *lyuvc = (LYUViewController*)self.viewControllers.lastObject;
        if (lyuvc.HackLeaveThePage) {
            [lyuvc LeaveThePage];
            return;
        }
    }
    
    
    
    NSArray *viewcontrollers=self.viewControllers;
    if (viewcontrollers.count == 1 || viewcontrollers == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }else{
        
        [self popViewControllerAnimated:YES];
    }
}

#pragma mark - 状态栏 & 旋转
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden{
    return self.topViewController;
}

/*
 
 - (BOOL)shouldAutorotate {
     return self.topViewController.shouldAutorotate;
 }

 - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
     return self.topViewController.supportedInterfaceOrientations;
 }

 - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
     return self.topViewController.preferredInterfaceOrientationForPresentation;
 }
 
 
 */

@end
