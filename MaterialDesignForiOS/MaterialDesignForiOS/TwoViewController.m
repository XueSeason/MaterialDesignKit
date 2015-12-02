//
//  TwoViewController.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "TwoViewController.h"
#import "MDCellBackTransition.h"
@interface TwoViewController () <UINavigationControllerDelegate>
@property (strong, nonatomic) MDCellBackTransition *cellTransition;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.cellTransition = [[MDCellBackTransition alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop ) {
        return self.cellTransition;
    }else {
        return nil;
    }
}

@end
