//
//  RootViewControllerObjectiveC.m
//  Example
//
//  Created by Prem Pratap Singh on 16/11/22.
//

#import "RootViewControllerObjectiveC.h"
#import <Trustylib/Trustylib-Swift.h>

@interface RootViewControllerObjectiveC ()
@end


@implementation RootViewControllerObjectiveC{
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    UIViewController *trustbadgeViewController = [
        TrustbadgeViewWrapper
            createTrustbadgeViewWithTsid:@"X330A2E7D449E31E467D2F53A55DDD070"
            channelId:@"chl-b309535d-baa0-40df-a977-0b375379a3cc"
            context: TrustbadgeContextShopGrade
    ];
    [self addChildViewController: trustbadgeViewController];
    [self.view addSubview: trustbadgeViewController.view];
    trustbadgeViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [trustbadgeViewController.view.centerYAnchor constraintEqualToAnchor: self.view.centerYAnchor].active = YES;
    [trustbadgeViewController.view.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 16].active = YES;
    [trustbadgeViewController.view.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: -16].active = YES;
    [trustbadgeViewController.view.heightAnchor constraintEqualToConstant: 75].active = YES;
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    const CGSize size = self.view.bounds.size;

    [label sizeToFit];
    label.frame = CGRectInset(label.frame, -10, -10);
    label.center = CGPointMake(size.width * 0.5, size.height * 0.5);
}

@end
