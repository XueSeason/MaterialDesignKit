//
//  MDButton.h
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MDRippleStyle) {
    MDRippleStyleDefault = 0,
    MDRippleStyleCircle
};

IB_DESIGNABLE
@interface MDButton : UIButton
@property (assign, nonatomic) IBInspectable BOOL floating;
@property (assign, nonatomic) MDRippleStyle rippleStyle;
@end
