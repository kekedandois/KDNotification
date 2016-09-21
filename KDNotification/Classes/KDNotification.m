//
//  KDNotification.m
//  KDNotification
//
//  Created by Kéké Dandois on 20/09/16.
//  Copyright © 2016 Kéké Dandois. All rights reserved.
//

#import "KDNotification.h"

static KDNotification *currentNotification = nil;
static UIBlurEffectStyle blurEffectStyle = UIBlurEffectStyleLight;

@interface KDNotification ()

@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) NSLayoutConstraint *animateConstraint;
@property (copy, nonatomic, nullable) KDNotificationTapped tapped;

@end

@implementation KDNotification

#pragma mark - Constructors

+ (void) setNotificionStyle:(UIBlurEffectStyle)style
{
    blurEffectStyle = style;
}

+ (instancetype) notification
{
    KDNotification *notification = [[[self bundle] loadNibNamed:NSStringFromClass([self class])
                                                          owner:nil
                                                        options:nil] objectAtIndex:0];
    
    return notification;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    {
        [self setup];
    }
    
    return self;
}

- (void) setup
{
    self.effect = [UIBlurEffect effectWithStyle:blurEffectStyle];
    self.layoutMargins = UIEdgeInsetsZero;
    self.contentView.layoutMargins = UIEdgeInsetsZero;
    self.translatesAutoresizingMaskIntoConstraints = false;
    self.layer.cornerRadius = 10.0;
    self.layer.masksToBounds = true;
}

- (void) styleNotification
{
    UIColor *textColor = blurEffectStyle == UIBlurEffectStyleDark ? [UIColor whiteColor] : [UIColor blackColor];
    self.titleLabel.textColor = textColor;
    self.textLabel.textColor = textColor;
    self.titleLabel.text = [self appName];
    self.appIcon.image = [self appIconImage];
    self.appIcon.layer.cornerRadius = 4.0;
    self.appIcon.layer.masksToBounds = true;
}

#pragma mark - Tapping the notification
- (void) addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedNotification)];
    
    [self addGestureRecognizer:tapGesture];
}

- (void) tappedNotification
{
    if (self.tapped)
    {
        self.tapped();
    }
    
    [self dismiss];
}

+ (instancetype) showWithText:(NSString *)text tapped:(KDNotificationTapped)tapped
{
    if (currentNotification) {
        [currentNotification dismiss];
    }

    KDNotification *notification = [self notification];

    [[self notificationWindow] addSubview:notification];

    notification.tapped = tapped;
    notification.textLabel.text = text;

    [notification styleNotification];
    [notification addConstraints];
    [notification addTapGesture];
    [notification showNotificationAnimation];

    currentNotification = notification;

    return notification;
}

+ (instancetype) showWithText:(NSString *)text duration:(NSTimeInterval)duration tapped:(KDNotificationTapped)tapped
{
    KDNotification *notification = [self showWithText:text tapped:tapped];
    
    [notification dismissNotificationAfter:duration];
    
    return notification;
}

- (void) showNotificationAnimation
{
    self.animateConstraint.constant = [self startPosition];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.animateConstraint.constant = 20;
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.superview layoutIfNeeded];
        } completion:nil];
        
    });
}

- (void) dismissNotificationAfter:(NSTimeInterval)interval
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

- (void) dismiss
{
    self.animateConstraint.constant = [self startPosition];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (currentNotification == self) {
            currentNotification = nil;
        }
        [self removeFromSuperview];
    }];
 
}

#pragma mark - Constraints and positioning

- (CGFloat) startPosition
{
    return -CGRectGetHeight(self.frame);
}

- (void) addConstraints
{
    NSMutableArray *allConstraints = [NSMutableArray array];

    if ([self isTablet]) {

        NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"[notification(500)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"notification":self}];

        NSLayoutConstraint *horizontalCenter = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];


        [allConstraints addObjectsFromArray:horizontal];
        [allConstraints addObject:horizontalCenter];

    }
    else {
        NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[notification]-10-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"notification":self}];

        [allConstraints addObjectsFromArray:horizontal];
    }

    
    NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[notification]"
                                                                options:kNilOptions
                                                                metrics:nil
                                                                  views:@{@"notification":self}];
    
    self.animateConstraint = vertical.firstObject;
    [allConstraints addObjectsFromArray:vertical];
    
    [NSLayoutConstraint activateConstraints:allConstraints];
}


#pragma mark - Helper methods
- (UIImage *) appIconImage
{
    UIImage *appIcon = [UIImage imageNamed: [[[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIcons"] objectForKey:@"CFBundlePrimaryIcon"] objectForKey:@"CFBundleIconFiles"] objectAtIndex:0]];
    
    return appIcon;
}

- (NSString *) appName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (UIWindow *) notificationWindow
{
    return [[UIApplication sharedApplication] keyWindow];
}

+ (NSBundle *) bundle
{
    NSBundle *podBundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [podBundle URLForResource:@"KDNotification" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];

    return bundle;
}

- (BOOL) isTablet
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

@end
