//
//  Filtros.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableDefenicoes : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) id scroolDelegate;

@end
