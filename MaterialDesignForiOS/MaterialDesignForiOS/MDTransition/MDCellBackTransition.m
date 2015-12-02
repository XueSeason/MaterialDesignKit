//
//  MDCellBackTransition.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "MDCellBackTransition.h"

@implementation MDCellBackTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    CGRect startFrame = [UIScreen mainScreen].bounds;
    CGRect finalFrame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) / 2.0, CGRectGetWidth([UIScreen mainScreen].bounds), 0);
    
    fromVC.view.frame = startFrame;
    fromVC.view.layer.shadowOffset = CGSizeMake(0, 5);
    fromVC.view.layer.shadowRadius = 5.0;
    fromVC.view.layer.shadowOpacity = 0.5;
    fromVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    fromVC.view.layer.masksToBounds = NO;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
