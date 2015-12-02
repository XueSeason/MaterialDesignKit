//
//  MDSwitch.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "MDSwitch.h"

@interface MDSwitch ()

@property (strong, nonatomic) CAShapeLayer *slideLayer;
@property (strong, nonatomic) CAShapeLayer *trackLayer;
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
    [self.layer addSublayer:self.slideLayer];
}

- (void)layoutSubviews {
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - getters and setters
- (CAShapeLayer *)slideLayer {
    if (!_slideLayer) {
        _slideLayer = [CAShapeLayer layer];
        _slideLayer.fillColor = self.slideColor.CGColor;
        _slideLayer.frame = CGRectMake(0, 0, 30, 30);
        _slideLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 30, 30)].CGPath;
    }
    return _slideLayer;
}

@end
