//
//  LYUViewController.h
//  LYUPods
//
//  Created by donglyu on 2020/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUViewController : UIViewController

/// 离开当前页面（pop or dismiss）
- (void)LeaveThePage;

/// return YES: 继续离开页面, return NO, 返回不做任何操作.
@property (nonatomic, copy, nullable) BOOL (^HackLeaveThePage)(void);

@end

NS_ASSUME_NONNULL_END
