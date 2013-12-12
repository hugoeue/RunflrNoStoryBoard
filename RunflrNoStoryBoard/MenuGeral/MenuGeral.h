//
//  MenuGeral.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 07/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuGeral : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *dataSource;

@property (nonatomic ,assign ) id delegate;

@end
