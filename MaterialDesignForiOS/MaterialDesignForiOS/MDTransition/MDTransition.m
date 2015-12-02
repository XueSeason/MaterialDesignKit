//
//  MDTransition.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "MDTransition.h"

@interface MDTransition ()
@property (strong, nonatomic) id<UIViewControllerContextTransitioning>transitionContext;
@end

@implementation MDTransition

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"initial error" reason:@"use initWithEnterView: please" userInfo:nil];
    return nil;
}

- (instancetype)initWithEnterView:(UIView *)enterView {
    self = [super init];
    if (self) {
        self.enterView = enterView;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    // calculate
    CGFloat width   = [UIScreen mainScreen].bounds.size.width;
    CGFloat height  = [UIScreen mainScreen].bounds.size.height;
    CGFloat centerX = self.enterView.center.x;
    CGFloat centerY = self.enterView.center.y;
    CGFloat maxX    = fabs(width - centerX) > centerX ? fabs(width - centerX) : centerX;
    CGFloat maxY    = fabs(height - centerY) > centerY ? fabs(height - centerY) : centerY;
    CGFloat radius  = sqrt(maxX * maxX + maxY * maxY);
    
    UIBezierPath *startCircle = [UIBezierPath bezierPathWithOvalInRect:self.enterView.frame];
    UIBezierPath *finalCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.enterView.frame, -radius, -radius)];
    
    // 创建 CAShaperLayer 遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalCircle.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    // 创建 CABasicAnimation 动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startCircle.CGPath);
    maskLayerAnimation.toValue   = (__bridge id _Nullable)(finalCircle.CGPath);
    maskLayerAnimation.duration  = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate  = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"basic"];
}

#pragma mark - CABasicAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
