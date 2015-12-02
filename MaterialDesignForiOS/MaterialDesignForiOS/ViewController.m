//
//  ViewController.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "ViewController.h"

#import "MDTransition.h"
#import "MDButton.h"

@interface ViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet MDButton *pushButton;
@property (strong, nonatomic) MDTransition *transition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
    
    self.transition = [[MDTransition alloc] initWithEnterView:self.pushButton];
    self.pushButton.rippleStyle = MDRippleStyleCircle;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return self.transition;
    } else {
        return nil;
    }
}

@end
