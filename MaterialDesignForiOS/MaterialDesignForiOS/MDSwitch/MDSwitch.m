//
//  MDSwitch.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "MDSwitch.h"

static CGFloat const switchWidth  = 45;
//static CGFloat const switchHeight = 20;
static CGFloat const slideRadius  = 10;
static CGFloat const trackRadius  = 7;

@interface MDSwitch ()

@property (strong, nonatomic) CALayer *slideLayer;
@property (strong, nonatomic) CAShapeLayer *trackLayer;
@property (strong, nonatomic) CAShapeLayer *fillLayer;

@property (strong, nonatomic) UIBezierPath *beginPath;
@property (strong, nonatomic) UIBezierPath *endPath;

@end

@implementation MDSwitch

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    [self.layer addSublayer:self.trackLayer];
    [self.trackLayer addSublayer:self.fillLayer];
    [self.layer addSublayer:self.slideLayer];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
}

- (void)drawRect:(CGRect)rect {
    if (self.switchState) {
        self.slideLayer.frame = CGRectMake(switchWidth - 2 * slideRadius, 0, 2 * slideRadius, 2 * slideRadius);
        self.fillLayer.path = self.endPath.CGPath;
    } else {
        self.slideLayer.frame = CGRectMake(0, 0, 2 * slideRadius, 2 * slideRadius);
        self.fillLayer.path = self.beginPath.CGPath;
    }
}

#pragma mark - events response
- (void)tap {
    self.switchState = !self.switchState;
}

#pragma mark - getters and setters
- (CALayer *)slideLayer {
    if (!_slideLayer) {
        _slideLayer = [CALayer layer];
        _slideLayer.cornerRadius = slideRadius;
        _slideLayer.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:110 / 255.0 blue:185 / 255.0 alpha:1.0].CGColor;
        
        _slideLayer.shadowOffset = CGSizeMake(0, 2);
        _slideLayer.shadowRadius = 5.0;
        _slideLayer.shadowOpacity = 0.5;
        _slideLayer.shadowColor = [UIColor blackColor].CGColor;
        _slideLayer.masksToBounds = NO;
    }
    return _slideLayer;
}

- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.lineWidth = 0.5f;
        _trackLayer.frame = CGRectMake(slideRadius, slideRadius - trackRadius, switchWidth - 2 * slideRadius, 2 * trackRadius);
        _trackLayer.path = [UIBezierPath bezierPathWithRoundedRect:_trackLayer.bounds cornerRadius:trackRadius].CGPath;
        _trackLayer.fillColor = [UIColor colorWithWhite:0.0 alpha:0.75].CGColor;
        _trackLayer.masksToBounds = YES;
    }
    return _trackLayer;
}

- (CAShapeLayer *)fillLayer {
    if (!_fillLayer) {
        _fillLayer = [CAShapeLayer layer];
        _fillLayer.lineWidth = 0.5;
        _fillLayer.fillColor = [UIColor colorWithWhite:1.0 alpha:0.8].CGColor;
        _fillLayer.frame = self.trackLayer.bounds;
        _fillLayer.cornerRadius = trackRadius;
        _fillLayer.masksToBounds = YES;
    }
    return _fillLayer;
}

- (UIBezierPath *)beginPath {
    if (!_beginPath) {
        _beginPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 0, 2 * trackRadius) cornerRadius:trackRadius];
    }
    return _beginPath;
}

- (UIBezierPath *)endPath {
    if (!_endPath) {
        _endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, switchWidth - 2 * slideRadius, 2 * trackRadius) cornerRadius:trackRadius];
    }
    return _endPath;
}

- (void)setSlideColor:(UIColor *)slideColor {
    _slideColor = slideColor;
    _slideLayer.backgroundColor = _slideColor.CGColor;
    [self setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    _fillLayer.fillColor = _fillColor.CGColor;
    [self setNeedsDisplay];
}

- (void)setSwitchState:(BOOL)switchState {
    _switchState = switchState;
    [self setNeedsDisplay];
    
    CFTimeInterval time = 0.2;
    CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    fillAnimation.duration = time;
    if (_switchState) {
        fillAnimation.fromValue = (__bridge id)self.beginPath.CGPath;
        fillAnimation.toValue = (__bridge id)self.endPath.CGPath;
    } else {
        fillAnimation.fromValue = (__bridge id)self.endPath.CGPath;
        fillAnimation.toValue = (__bridge id)self.beginPath.CGPath;
    }
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.fillLayer addAnimation:fillAnimation forKey:@"fill"];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnimation.duration = time;
    if (_switchState) {
        moveAnimation.fromValue = @(slideRadius);
        moveAnimation.toValue = @(switchWidth - slideRadius);
    } else {
        moveAnimation.fromValue = @(switchWidth - slideRadius);
        moveAnimation.toValue = @(slideRadius);
    }
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.slideLayer addAnimation:moveAnimation forKey:@"move"];
}

@end
