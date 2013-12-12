//
//  Resultados.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 03/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "Resultados.h"
#import "SearchParser.h"
#import "Diarias.h"
#import "TableCell.h"

@interface Resultados ()
{
    NSString *result;
    NSString *tipo;
    
    BOOL isFirst; // SO NOT TO REST SELECTED TABLES
    
    BOOL doneSearch;
    
    BOOL isFiltered;
    
    BOOL orderPop;
    BOOL filter1;
    BOOL filter2;
    BOOL filter3;
    BOOL price1;
    BOOL price2;
    BOOL price3;
    BOOL price4;
    
    BOOL isTimeFilter;
    NSString *timeFilter;

}

@property (strong, nonatomic) NSMutableArray* filteredTableData;

@end

@implementation Resultados

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setResultado:(NSString *)resultado
{
    result = resultado;
}

-(void)setTipo:(NSString *)tip
{
    tipo = tip;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.labelResultado.text=result;
    self.labelTipo.text = tipo;
    [self.labelTipo setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:30]];
    
    if ([tipo isEqualToString:@"Favoritos"]) {
        //
        
        
         for (Restaurant *rest in [Globals user].favs) {
             NSLog(@"rest fav name %@", rest.name);
         }
         
        [self.tableRestaurantes reloadData];
    }else
        [self preperarPesquisa];
    [self changeFont:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)popAnterior:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)startFilters
{
    isFiltered = NO;
    
    orderPop = YES;
    filter1 = NO;
    filter2 = NO;
    filter3 = NO;
    price1 = NO;
    price2 = NO;
    price3 = NO;
    price4 = NO;
    
    isTimeFilter = NO;
    
    // para limpar tabelas
    //[self cleanCuisines];
    //[self cleanOptions];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    timeFilter= [formatter stringFromDate:date];
    
    
}


-(void)preperarPesquisa
{
    doneSearch = NO;
    
    
    // LETS CREATE THE HOST URL STRING
    int cityId = [Globals cityId];
    if ([Globals otherCityId] != 0) {
        cityId = [Globals otherCityId];
    }
    
     NSString *getData;
    NSMutableString *host;
    
    if ([tipo isEqualToString:@"Restaurants"]) {
        getData = [NSString stringWithFormat:@"&search=%@&city_id=%@&rest_name=%@", [@"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"17" , [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        host = [NSMutableString stringWithString:[Globals hostWithFile:@"search_restaurante.php" andGetData:getData]];
    }
    else
    {
        getData = [NSString stringWithFormat:@"&search=%@&city_id=%@&rest_name=%@", [@"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"17" , [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        host = [NSMutableString stringWithString:[Globals hostWithFile:@"search_cidades.php" andGetData:getData]];
    }
    
    
    
   
    
    
    if (orderPop) {
        [host appendString:@"&order=pop"];
    } else {
        [host appendString:@"&order=vote"];
    }
    
    if (filter1) {
        [host appendString:@"&filter1=1"];
    } else {
        [host appendString:@"&filter1=0"];
    }
    
    if (filter2) {
        [host appendString:@"&filter2=1"];
    } else {
        [host appendString:@"&filter2=0"];
    }
    
    if (filter3) {
        [host appendString:@"&filter3=1"];
    } else {
        [host appendString:@"&filter3=0"];
    }
    
    for (Cuisine *cuis in [Globals cuisines]) {
        if (cuis.selected) {
            [host appendFormat:@"&cuisineid[]=%d", cuis.dbId];
        }
    }
    
    if (price1) {
        [host appendString:@"&price1=1"];
    } else {
        [host appendString:@"&price1=0"];
    }
    
    if (price2) {
        [host appendString:@"&price2=1"];
    } else {
        [host appendString:@"&price2=0"];
    }
    
    if (price3) {
        [host appendString:@"&price3=1"];
    } else {
        [host appendString:@"&price3=0"];
    }
    
    if (price4) {
        [host appendString:@"&price4=1"];
    } else {
        [host appendString:@"&price4=0"];
    }
    
    for (Option *opt in [Globals options]) {
        if (opt.selected) {
            [host appendFormat:@"&optionid[]=%d", opt.dbId];
        }
    }
    
    if (isTimeFilter) {
        [host appendString:@"&timefilter="];
        [host appendString:timeFilter];
    }
    
    // STRING DONE
    
    NSLog(@"HOST STRING: %@", host);
    
    [NSThread detachNewThreadSelector:@selector(loadSearch:) toTarget:self withObject:host];

}

#pragma mark - THREADED PARSERS

- (void)loadSearch:(NSMutableString *)host
{
    SearchParser *searchParser = [[SearchParser alloc] initXMLParser];
    
    NSURL *url = [[NSURL alloc] initWithString: host];
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
    [nsXmlParser setDelegate:searchParser];
    
    BOOL success = [nsXmlParser parse];
    
    if (success) {
        
        doneSearch = YES;
        /*
        for (Restaurant *rest in [Globals searchResult]) {
            NSLog(@"rest name %@", rest.name);
        }
        */
        [self performSelectorOnMainThread:@selector(doneSearch) withObject:nil waitUntilDone:NO];
        
        
    } else {
        
        NSError *error = [nsXmlParser parserError];
        
        NSLog(@"erro get restaurantes %@", error.description);
        
        [self performSelectorOnMainThread:@selector(noConnect) withObject:nil waitUntilDone:NO];
    }
    
    
}

- (void)doneSearch
{
    doneSearch = YES;
    
    [self.tableRestaurantes reloadData];
    if (isFirst) {
        isFirst = NO;
      //  [self.optionsTable reloadData];
       // [self.cuisinesTable reloadData];
    }
    
    if ([Globals searchResult].count > 0) {
       // [self.labelNotice removeFromSuperview];
    }
    
   // [self.loadingView hideAlert];
    
}

- (void)noConnect
{
    
    UIAlertView *alertBoo = [[UIAlertView alloc]
                             initWithTitle:[Language textForIndex:@"GlobalComErrorTitle"]
                             message:[Language textForIndex:@"GlobalComErrorText"]
                             delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    
    [alertBoo show];
}

#pragma mark - UITableView Delegaates

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    //if (!doneSearch)
     //   return 0;
    
   if ([tipo isEqualToString:@"Favoritos"])
       return [Globals user].favs.count;
        
        return [[Globals searchResult] count];
        
        
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if (tableView == self.tableRestaurantes) {
        
        return 1;
        
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
        return 55;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Restaurant *rest;
    
    if ([tipo isEqualToString:@"Favoritos"])
    {
        rest = [[Globals user].favs objectAtIndex:indexPath.row];
        
    }
    else{
        rest= (Restaurant *)[[Globals searchResult] objectAtIndex:indexPath.row];
    }
    

    
    static NSString *simpleTableIdentifier = @"TableCell";
    
    TableCell *cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    
    cell.labeTitulo.font = [UIFont fontWithName:@"DKCrayonCrumble" size:30];
    
    cell.ThumbnailSeta.image = [UIImage imageNamed:@"seta.png"];
    cell.labeTitulo.text = [NSString stringWithFormat:@"%@", rest.name];
    
    return cell;

        
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        
        [self ResultsTableView:tableView didSelectRowAtIndexPath:indexPath];
        
}

#pragma mark - RESULTS TABLE DELEGATE METHODS


- (void)ResultsTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Restaurant *rest;
    
    if ([tipo isEqualToString:@"Favoritos"])
    {
        rest = [[Globals user].favs objectAtIndex:indexPath.row];
        
    }
    else{
        rest= (Restaurant *)[[Globals searchResult] objectAtIndex:indexPath.row];
    }

    
    int dbId = rest.dbId;
    
    [Globals setRestaurantId:dbId];
    
    
    
    // faz cenas para abrir menu do dia
    //[self performSegueWithIdentifier:@"resultsToRestaurant" sender:nil];
    
    Diarias *c = [[Diarias alloc] init];
    
    
    [c loadRestaurant:rest];
    
    [self.navigationController pushViewController:c animated:YES];
    PP_RELEASE(c);
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.textLabel setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:26]];
    cell.backgroundColor = [UIColor clearColor];
    
}


- (void)showClock:(id)sender
{
   // [self showClock];
}
-(void)changeFont:(UIView *) view{
    for (id View in [view subviews]) {
        if ([View isKindOfClass:[UILabel class]]) {
            [View setFont:[UIFont fontWithName:@"DKCrayonCrumble" size:26]];
            //view.textColor = [UIColor blueColor];
            [View setBackgroundColor:[UIColor clearColor]];
        }
        if ([View isKindOfClass:[UIView class]]) {
            [self changeFont:View];
        }
    }
}









@end
