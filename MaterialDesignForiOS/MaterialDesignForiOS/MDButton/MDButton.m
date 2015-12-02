//
//  MDButton.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "MDButton.h"

@interface MDButton ()
@property (strong, nonatomic) CAShapeLayer *maskLayer;
@property (strong, nonatomic) CAShapeLayer *rippleLayer;
@end

@implementation MDButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.adjustsImageWhenHighlighted = NO;
    [self.layer addSublayer:self.maskLayer];
    [self.maskLayer addSublayer:self.rippleLayer];
    self.rippleStyle = MDRippleStyleDefault;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.rippleLayer.frame = self.bounds;
    self.maskLayer.frame = self.bounds;
    self.maskLayer.masksToBounds = YES;
}

#pragma mark - events response
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    self.maskLayer.hidden = NO;
    self.maskLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    UIBezierPath *beginPath;
    UIBezierPath *endPath;
    
    if (self.rippleStyle == MDRippleStyleDefault) {
        CGPoint center = [touch locationInView:self];
        CGFloat maxX = fabs(width - center.x) > center.x ? fabs(width - center.x) : center.x;
        CGFloat maxY = fabs(height - center.y) > center.y ? fabs(height - center.y) : center.y;
        CGFloat radiusMin = MIN(width - maxX, height - maxY);
        CGFloat radiusMax = sqrt(maxX * maxX + maxY * maxY);
        
        beginPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x - radiusMin, center.y - radiusMin, 2 * radiusMin, 2 * radiusMin)];
        endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x - radiusMax, center.y - radiusMax, 2 * radiusMax, 2 * radiusMax)];
    } else {
        CGPoint center = CGPointMake(width / 2.0, height / 2.0);
        CGFloat radius = MIN(width, height) / 2.0;
        beginPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x, center.y, 0, 0)];
        endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x - radius, center.y - radius, 2 * radius, 2 * radius)];
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 0.2;
    animation.fromValue = (__bridge id)beginPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.rippleLayer addAnimation:animation forKey:@"ripple"];
    self.rippleLayer.path = endPath.CGPath;
    
    if (self.floating) {
        self.layer.shadowRadius = 8.0;
        self.layer.shadowOpacity = 0.8;
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    self.maskLayer.hidden = YES;
    
    if (self.floating) {
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.5;
    }
}

#pragma mark - getters and setters
- (CAShapeLayer *)rippleLayer {
    if (!_rippleLayer) {
        _rippleLayer = [CAShapeLayer layer];
        _rippleLayer.fillColor = [UIColor colorWithWhite:0.75 alpha:0.4].CGColor;
    }
    return _rippleLayer;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.fillColor = [UIColor colorWithWhite:1.0 alpha:0.1].CGColor;
        _maskLayer.hidden = YES;
    }
    return _maskLayer;
}

- (void)setFloating:(BOOL)floating {
    _floating = floating;
    if (floating) {
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = NO;
    } else {
        self.layer.shadowOffset = CGSizeZero;
        self.layer.masksToBounds = YES;
    }
}

@end
