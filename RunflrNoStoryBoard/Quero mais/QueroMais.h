//
//  QueroMais.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 29/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueroMais : UIViewController

-(id)initWithRestaurant:(Restaurant *)rest;

@property (weak, nonatomic) IBOutlet UIImageView *imgDia;
@property (weak, nonatomic) IBOutlet UIImageView *imgEsp;
@property (weak, nonatomic) IBOutlet UIImageView *imgEme;

- (IBAction)clickDia:(id)sender;
- (IBAction)clickEsp:(id)sender;
- (IBAction)clickEme:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *textArea;


@end
