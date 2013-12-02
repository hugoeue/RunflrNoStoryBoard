//
//  DetailViewController.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 02/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
