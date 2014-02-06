//
//  Filtros.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "TableDefenicoes.h"
#import "DefenicosHeader.h"
#import "DefenicoesNormal.h"
#import "DefenicoesCell.h"


@interface TableDefenicoes (){

    NSMutableArray      *arrayForBool;
    NSMutableDictionary *sectionContentDict;

    
//    Pesquise0 * headerView0;
//    Pesquise1 * headerView1;
    DefenicosHeader * headerViewOpen;
}

@end

@implementation TableDefenicoes

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
    
    
    
    if (!arrayForBool) {
        arrayForBool    = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           nil];
    }
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    

    
    
    // é so para saber se esta aberta ou fechada
    //BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];

    if (section == 0) {
        DefenicosHeader * headerView0 = [DefenicosHeader new];
        
        headerView0.view.tag = section;
        UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        [headerView0.view addGestureRecognizer:headerTapped];
        
        headerView0.labelHeader.text = @"Suporte ";
        headerView0.labelTitulo.text = [Language textForIndex:@"Sobre_Menu_Guru"];
        
        
        headerView0.imagem.image = [UIImage imageNamed:@"Menu_Refugio_0009_Circle.png"];
        
        return headerView0.view;
    }
    if (section == 1) {
        
        DefenicoesNormal * headerView1 = [DefenicoesNormal new];
      
        headerView1.view.tag = section;
        UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        [headerView1.view addGestureRecognizer:headerTapped];
        
        headerView1.labelTitulo.text = [Language textForIndex:@"Termos_condicoes"];
        
        headerView1.image.image = [UIImage imageNamed:@"b_termos_condicoes.png"];
        
        
        return headerView1.view;
    }
    if (section == 2) {
        DefenicoesNormal * headerView1 = [DefenicoesNormal new];
        
        headerView1.view.tag = section;
         UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        [headerView1.view addGestureRecognizer:headerTapped];
        
        headerView1.labelTitulo.text = [Language textForIndex:@"Politica_privacidade"];
         headerView1.image.image = [UIImage imageNamed:@"b_politica_privacidade.png"];
        
        return headerView1.view;
    }
    if (section == 3) {
        if(!headerViewOpen)
            headerViewOpen = [DefenicosHeader new];
        
        headerViewOpen.view.tag = section;
        UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        [headerViewOpen.view addGestureRecognizer:headerTapped];
        
        headerViewOpen.labelHeader.text = [Language textForIndex:@"Feedback"];
        headerViewOpen.labelTitulo.text = @"Espalha a Palavra APT";
        
        headerViewOpen.imagem.image = [UIImage imageNamed:@"b_partilhar2.png"];
        
        return headerViewOpen.view;
    }
    if (section == 4) {
        DefenicoesNormal * headerView1 = [DefenicoesNormal new];
        
        headerView1.view.tag = section;
        UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        [headerView1.view addGestureRecognizer:headerTapped];
        
        headerView1.labelTitulo.text =[Language textForIndex:@"Diz_que_pensas"];
        
        headerView1.image.image = [UIImage imageNamed:@"b_conversar.png"];
        
        return headerView1.view;
    }
    if (section == 5) {
        DefenicoesNormal * headerView1 = [DefenicoesNormal new];
        
        headerView1.view.tag = section;
        UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        [headerView1.view addGestureRecognizer:headerTapped];
        
        headerView1.labelTitulo.text = [Language textForIndex:@"Classifica_App"];
        headerView1.image.image = [UIImage imageNamed:@"Menu_Refugio_0000_Star-Icon.png"];

        
        
        return headerView1.view;
    }

    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 3) {
        return 87;
    }
    
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 120;
    }
    return 0;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    static NSString *simpleTableIdentifier = @"DefenicoesCell";
    
    DefenicoesCell *cell = (DefenicoesCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DefenicoesCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.delegate = self;
        cell.labelTitulo.text = [Language textForIndex:@"Partilha_com_amigos"];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSLog(@"selecionou indice %ld",(long)indexPath.row);
    
}

// nao preciso disto para nada

#pragma mark - gesture tapped
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    
    [self selecionado:[NSNumber numberWithDouble:indexPath.section]];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        
        if (indexPath.section == 3){
            [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
            [headerViewOpen RotateArrow:collapsed];
        }
        
    }
}


-(void)selecionado:(NSNumber *)selected
{
    
    
//    if ([selected isEqualToNumber:[NSNumber numberWithInteger:0]])
//    {
//        BOOL collapsed  = YES;
//    
//        NSIndexPath * index = [[NSIndexPath alloc] initWithIndex:1];
//        NSRange range   = NSMakeRange(1, 1);
//        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
//        
//        [arrayForBool replaceObjectAtIndex:index.section withObject:[NSNumber numberWithBool:collapsed]];
//        
//        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
//        
//      
//        
//    }else
//    {
//       
//        BOOL collapsed  = NO;
//        
//        NSIndexPath * index = [[NSIndexPath alloc] initWithIndex:1];
//        NSRange range   = NSMakeRange(1, 1);
//        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
//        
//        [arrayForBool replaceObjectAtIndex:index.section withObject:[NSNumber numberWithBool:collapsed]];
//        
//        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
//        
//        
//    }
    
    if (self.delegate) {
        [self.delegate performSelector:@selector(indexSelected:) withObject:selected ];
    }
    
    
}



//- (IBAction)clickFiltros:(id)sender {
//    if (self.delegate) {
//        [self.delegate performSelector:@selector(chamarPesquisa) withObject:nil];
//    }
//    
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    if(self.scroolDelegate)
//    {
//        [self.scroolDelegate performSelector:@selector(fezScroolTabela:) withObject:[NSNumber numberWithFloat:scrollView.contentOffset.y]];
//    }
//    
//}

@end
