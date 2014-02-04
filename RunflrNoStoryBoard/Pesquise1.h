//
//  Pesquise1.h
//  DinamicTable
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pesquise1 : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *selector;
- (IBAction)seleciounouSelector:(id)sender;

@property (nonatomic , assign) id delegate;

@end
