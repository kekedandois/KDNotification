//
//  KDToastNotification.m
//  Pods
//
//  Created by Kéké Dandois on 20/09/16.
//
//

#import "KDToastNotification.h"

@interface KDNotification ()
    @property (strong, nonatomic) NSLayoutConstraint *animateConstraint;
@end

@implementation KDToastNotification

- (CGFloat) startPosition
{
    return -CGRectGetHeight(self.frame);
}

- (void) addConstraints
{
    NSMutableArray *allConstraints = [NSMutableArray array];
    
    NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=10-[notification]->=10-|" options:kNilOptions metrics:nil views:@{@"notification":self}];
    NSLayoutConstraint *horizontalCenter = [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.superview
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0];
    
    
    [allConstraints addObjectsFromArray:horizontal];
    [allConstraints addObject:horizontalCenter];
    
    NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[notification]-20-|" options:kNilOptions metrics:nil views:@{@"notification":self}];
    
    self.animateConstraint = vertical.firstObject;
    [allConstraints addObjectsFromArray:vertical];
    
    [NSLayoutConstraint activateConstraints:allConstraints];
}

@end
