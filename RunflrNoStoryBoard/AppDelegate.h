//
//  AppDelegate.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 02/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MenuRefugio.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate, PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
@property (strong, nonatomic) FBSession *session;

@property (nonatomic, strong) MenuRefugio *menuRef;

@property (nonatomic, strong) UIView *topView;


@end
