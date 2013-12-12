//
//  MenuDoDia.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 07/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "MenuDoDia.h"
#import "Menu.h"
#import "TableCell.h"

@interface MenuDoDia ()

@end

@implementation MenuDoDia

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
    return [Globals days].count;
   // return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return  160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Menu *rest = (Menu *)[[Globals days] objectAtIndex:indexPath.row];
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    NSString *text1;
    NSString *text2;
    NSString *text3;

    
    
    text1 = rest.dish;
    text2 = rest.extra;
    text3 = rest.description;
 
    
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    cell.textLabel.text= [NSString stringWithFormat:@"• %@ \n• %@ ", text1,text2];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"• %@", text3];

    
    
    cell.textLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:5];
    cell.detailTextLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:14];
    
    return cell;
    
    */
    
    static NSString *simpleTableIdentifier = @"TableCell";
    
    TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    
    
    
    NSString *text1 = rest.dish;
    NSString *text2 = rest.extra;
    NSString *text3 = rest.description;
    
    cell.label1.font = [UIFont fontWithName:@"DKCrayonCrumble" size:15];
    cell.labeTitulo.font = [UIFont fontWithName:@"DKCrayonCrumble" size:30];
    
    cell.label1.text = [NSString stringWithFormat:@"%@\n%@\n%@", text1,text2,text3];
    //cell.label2.text = [NSString stringWithFormat:@"• %@", text3];
    
    
    cell.labeTitulo.text = [NSString stringWithFormat:@"%@", rest.tipod];
    if (!rest.tipod ) {
        cell.labeTitulo.text = @"Sem menu do dia";
    }
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.textLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:26]];
    cell.backgroundColor = [UIColor clearColor];
    
}


@end
