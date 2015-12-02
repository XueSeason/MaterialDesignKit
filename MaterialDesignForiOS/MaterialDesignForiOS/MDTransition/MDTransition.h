//
//  MDTransition.h
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDTransition : NSObject <UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) UIView *enterView;

- (instancetype)initWithEnterView:(UIView *)enterView;

@end
