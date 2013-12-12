//
//  MenuGeral.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 07/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "MenuGeral.h"
#import "TableCell.h"
#import "Tipo.h"

@interface MenuGeral ()

@end

@implementation MenuGeral

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegaates
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
 {
 return [Globals days].count;
 }
 
 
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 return 30;
 }
 
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 Menu *rest = (Menu *)[[Globals days] objectAtIndex:section];
 
 UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
 
 headerView.backgroundColor = [UIColor clearColor];
 
 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, tableView.bounds.size.width - 10, 28)];
 
 label.text = rest.tipod;
 label.font = [UIFont fontWithName:@"DKCrayonCrumble" size:24];
 
 label.textColor = [UIColor whiteColor];
 label.backgroundColor = [UIColor clearColor];
 [headerView addSubview:label];
 
 
 
 return headerView;
 }
 */


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
    // return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return  55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tipo *rest = (Tipo *)[self.dataSource objectAtIndex:indexPath.row];
    
    static NSString *simpleTableIdentifier = @"TableCell";
    
    TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
 
    cell.labeTitulo.font = [UIFont fontWithName:@"DKCrayonCrumble" size:30];
    
    cell.ThumbnailSeta.image = [UIImage imageNamed:@"seta.png"];
    cell.labeTitulo.text = [NSString stringWithFormat:@"%@", rest.tipoName];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.textLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:26]];
    cell.backgroundColor = [UIColor clearColor];
    
}

@end
