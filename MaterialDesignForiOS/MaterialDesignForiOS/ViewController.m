//
//  ViewController.m
//  MaterialDesignForiOS
//
//  Created by 薛纪杰 on 15/12/2.
//  Copyright © 2015年 XueSeason. All rights reserved.
//

#import "ViewController.h"

#import "MDTransition.h"
#import "MDCellTransition.h"
#import "MDButton.h"

#import "OneViewController.h"
#import "TwoViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MDButton *pushButton;
@property (strong, nonatomic) MDTransition *transition;
@property (strong, nonatomic) MDCellTransition *cellTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transition = [[MDTransition alloc] initWithEnterView:self.pushButton];
    self.cellTransition = [[MDCellTransition alloc] init];

    self.pushButton.rippleStyle = MDRippleStyleCircle;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush && [toVC isKindOfClass:[OneViewController class]]) {
        return self.transition;
    } else if (operation == UINavigationControllerOperationPush && [toVC isKindOfClass:[TwoViewController class]]) {
        return self.cellTransition;
    } else {
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.cellTransition.enterView = [tableView cellForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:[[TwoViewController alloc] init] animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Hello World.";
    return cell;
}

@end
