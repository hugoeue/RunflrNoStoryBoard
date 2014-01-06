//
//  Menus.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 04/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import "Restaurant.h"

@interface Menus :  UIViewController {
    IBOutlet UITableView *dataTableView;
    
    NSMutableArray *items;
    NSMutableArray *itemsTitle;
    NSMutableArray *itemsPrice;
}



@property Restaurant * restaurante;

@property (weak, nonatomic) IBOutlet FXImageView *imageMenu;

- (IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPreco;
@property (weak, nonatomic) IBOutlet UILabel *labelprecoAntigo;
@property (weak, nonatomic) IBOutlet UILabel *labelPrecoNovo;

@end
