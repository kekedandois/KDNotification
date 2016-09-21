//
//  KDNotification.h
//  KDNotification
//
//  Created by Kéké Dandois on 20/09/16.
//  Copyright © 2016 Kéké Dandois. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KDNotificationTapped)(void);

@interface KDNotification : UIVisualEffectView

+ (void) setNotificionStyle:(UIBlurEffectStyle)style;

+ (instancetype) showWithText:(NSString *)text tapped:(KDNotificationTapped)tapped;
+ (instancetype) showWithText:(NSString *)text duration:(NSTimeInterval)duration tapped:(KDNotificationTapped)tapped;

- (void) dismiss;

@end
