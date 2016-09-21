//
//  KDViewController.m
//  KDNotification
//
//  Created by Kéké Dandois on 09/20/2016.
//  Copyright (c) 2016 Kéké Dandois. All rights reserved.
//

#import "KDViewController.h"
#import <KDNotification/KDNotification.h>
#import <KDNotification/KDToastNotification.h>

@interface KDViewController ()

@end

@implementation KDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [KDNotification setNotificionStyle:UIBlurEffectStyleDark];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressedShowNotification:(id)sender
{
    [KDNotification showWithText:@"This is a test notification. And what a long text I contain." duration:3.0 tapped:^{
        NSLog(@"tapped notification");
    }];
}

- (IBAction)pressedShowToastNotification:(id)sender
{
    [KDToastNotification showWithText:@"this is a toast. Who has the butter?" duration:3.0 tapped:^{
        NSLog(@"tapped toast");
    }];
}

@end
