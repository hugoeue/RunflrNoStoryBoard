//
//  Voucher.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 30/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Voucher : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;

- (id)initWithRestaurant:(Restaurant *)rest;
@property (weak, nonatomic) IBOutlet UILabel *voucher;

@end
