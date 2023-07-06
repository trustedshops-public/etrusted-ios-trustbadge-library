//
//  Copyright (C) 2023 Trusted Shops GmbH
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
        createTrustbadgeViewWithTsId: @"X330A2E7D449E31E467D2F53A55DDD070"
        channelId: @"chl-b309535d-baa0-40df-a977-0b375379a3cc"
        productId: nil
        context: TrustbadgeContextShopGrade
        alignment: TrustbadgeViewAlignmentLeading
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
