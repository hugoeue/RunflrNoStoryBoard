//
//  RootViewController.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 12/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaperFoldView.h"
#import "MenuRefugio.h"
#import "MainPage.h"

@interface RootViewController : UIViewController <PaperFoldViewDelegate>

@property (nonatomic, strong) PaperFoldView *paperFoldView;
@property (nonatomic, strong) MenuRefugio *menuRef;
@property (nonatomic, strong) MainPage *MainP;


@end
