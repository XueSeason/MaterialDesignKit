//
//  MDCellTransition.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "MDCellTransition.h"

@implementation MDCellTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];

    CGRect startFrame = [containerView convertRect:self.enterView.frame fromView:self.enterView.superview];
    CGRect finalFrame = [UIScreen mainScreen].bounds;
    
    toVC.view.frame = startFrame;
    
    toVC.view.layer.shadowOffset = CGSizeMake(0, 5);
    toVC.view.layer.shadowRadius = 5.0;
    toVC.view.layer.shadowOpacity = 0.5;
    toVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    toVC.view.layer.masksToBounds = NO;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
