//
//  Filtros.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Filtros.h"
#import "Pesquise0.h"
#import "Pesquise1.h"
#import "Pesquise2.h"
#import "pesquiseCell.h"

@interface Filtros (){

    NSMutableArray      *sectionTitleArray;
    NSMutableArray      *arrayForBool;
    NSMutableDictionary *sectionContentDict;

    
    Pesquise0 * headerView0;
    Pesquise1 * headerView1;
    Pesquise2 * headerView2;
    pesquiseCell *cell;
}

@end

@implementation Filtros

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
    
    
    if (!sectionTitleArray) {
        sectionTitleArray = [NSMutableArray arrayWithObjects:@"Aachen", @"Berlin", @"Düren", @"Essen", @"Münster", nil];
    }
    if (!arrayForBool) {
        arrayForBool    = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:YES],
                           [NSNumber numberWithBool:NO]
                           , nil];
    }
    if (!sectionContentDict) {
        sectionContentDict  = [[NSMutableDictionary alloc] init];
        NSArray *array1     = [NSArray arrayWithObjects:@"bla 1", @"bla 2", @"bla 3", @"bla 4", nil];
        [sectionContentDict setValue:array1 forKey:[sectionTitleArray objectAtIndex:0]];
        NSArray *array2     = [NSArray arrayWithObjects:@"wurst 1", @"käse 2", @"keks 3", nil];
        [sectionContentDict setValue:array2 forKey:[sectionTitleArray objectAtIndex:1]];
        NSArray *array3     = [NSArray arrayWithObjects:@"banane", @"auto2", @"haus", @"eidechse", nil];
        [sectionContentDict setValue:array3 forKey:[sectionTitleArray objectAtIndex:2]];
        NSArray *array4     = [NSArray arrayWithObjects:@"hoden", @"pute", @"eimer", @"wichtel", @"karl", @"dreirad", nil];
        [sectionContentDict setValue:array4 forKey:[sectionTitleArray objectAtIndex:3]];
        NSArray *array5     = [NSArray arrayWithObjects:@"Ei", @"kanone", nil];
        [sectionContentDict setValue:array5 forKey:[sectionTitleArray objectAtIndex:4]];
    }
    
    //[self.tableView setContentInset:UIEdgeInsetsMake(40, 0, 0, 0)];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    // é so para saber se esta aberta ou fechada
    //BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];

    if (section== 0) {
        headerView0 = [Pesquise0 new];
        
        headerView0.view.tag = section;
        //UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        //[headerView0.view addGestureRecognizer:headerTapped];
        
        return headerView0.view;
    }
    if (section== 1) {
        if (!headerView1)
            headerView1 = [Pesquise1 new];
        headerView1.delegate = self;
        headerView1.view.tag = section;
       // UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        //[headerView1.view addGestureRecognizer:headerTapped];
        
        return headerView1.view;
    }
    if (section== 2) {
        headerView2 = [Pesquise2 new];
        
        headerView2.view.tag = section;
        //UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        //[headerView2.view addGestureRecognizer:headerTapped];
        
        return headerView2.view;
    }

    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 150;
    }
    return 0;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    static NSString *simpleTableIdentifier = @"pesquiseCell";
    
    cell = (pesquiseCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"pesquiseCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
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
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        
//        if (indexPath.section == 1)
//            [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(void)selecionado:(NSNumber *)selected
{
    
    
    if ([selected isEqualToNumber:[NSNumber numberWithInteger:0]])
    {
        BOOL collapsed  = YES;
    
        NSIndexPath * index = [[NSIndexPath alloc] initWithIndex:1];
        NSRange range   = NSMakeRange(1, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [arrayForBool replaceObjectAtIndex:index.section withObject:[NSNumber numberWithBool:collapsed]];
        
        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
        
      
        
    }else
    {
       
        BOOL collapsed  = NO;
        
        NSIndexPath * index = [[NSIndexPath alloc] initWithIndex:1];
        NSRange range   = NSMakeRange(1, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [arrayForBool replaceObjectAtIndex:index.section withObject:[NSNumber numberWithBool:collapsed]];
        
        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    
}
 


- (IBAction)clickFiltros:(id)sender {
    // tenho de mandar cenas aqui por causa da pesquisa
    BOOL collapsed  = [[arrayForBool objectAtIndex:1] boolValue];
    
    NSString * especial;
    if (!collapsed) {
        especial = @"com especial";
    }else
    {
        especial = @"sem especial";
    }
    
    

    
    NSString * preco = @"0";
    if(cell.preco)
        preco =  cell.preco;
    
    
    
    
    
    
    BOOL abertoBool = headerView2.AbertoFechado.on;
    
    NSString * abertoString;
    if (abertoBool) {
        abertoString = @"Aberto";
    }else
    {
        abertoString = @"fechado";
    }

    
    NSString * texto = cell.textField.text;
    
    NSString * restauranteOuPrato;
    if (cell.selector.selectedSegmentIndex == 1) {
        restauranteOuPrato = @"Prato";
    }else
    {
        restauranteOuPrato = @"Restaurante";
    }
    
    NSLog(@"pesquisa %@ preço = %@ e o restaurante esta %@ pesquisa por %@ com texto %@", especial, preco,abertoString, restauranteOuPrato, texto );
    
    // aberto para saber se é especial ou nao
    // as cidades tem de ser gravado no globals e depois depende na pesquisa
    // o preço diz o preço se o especial estiver fechado
    
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    [dict setObject:especial forKey:@"especial"];
    [dict setObject:preco forKey:@"preco"];
    [dict setObject:abertoString  forKey:@"aberto"];
    [dict setObject:restauranteOuPrato  forKey:@"restauranteouprato"];
    [dict setObject:texto  forKey:@"texto"];
    
    if (self.delegate)
    {
        [self.delegate performSelector:@selector(PesquisaFiltros:) withObject:dict];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.scroolDelegate)
    {
        [self.scroolDelegate performSelector:@selector(fezScroolTabela:) withObject:[NSNumber numberWithFloat:scrollView.contentOffset.y]];
    }
}

@end
