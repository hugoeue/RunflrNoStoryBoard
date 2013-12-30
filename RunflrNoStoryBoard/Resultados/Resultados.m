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
#import "UserParser.h"
#import "WebServiceSender.h"
#import "Restaurant.h"
#import "CollectionGuru.h"

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
    
    WebServiceSender *webResultado;
    NSMutableArray *restaurantes;
    CollectionGuru * colececao;

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
 
  
    
   
        [self preperarPesquisa];
  
}

-(void)sendCompleteWithResult:(NSDictionary*)resulti withError:(NSError*)error{
    
    
    if (!error)
    {
//        int tag=[WebServiceSender getTagFromWebServiceSenderDict:resulti];
//        switch (tag)
//        {
//            case 1:
//            {
                NSLog(@"resultado da pesquisa por nome =>%@", resulti.description);
                
                
                restaurantes = [NSMutableArray new];
                
                for(NSMutableDictionary * dict in [resulti objectForKey:@"res"]){
                    Restaurant * rest = [Restaurant new];
                    
                    
                    //NSString *dist = [dict objectForKey:@"dist"];
                    NSString * restName = [dict objectForKey:@"nome"];
                    NSString * resId = [dict objectForKey:@"id"];
                    NSString * lati = [dict objectForKey:@"lat"];
                    NSString * longi = [dict objectForKey:@"lon"];
                    NSString * imagem = [dict objectForKey:@"imagem"];
                    NSString * alturaI = [dict objectForKey:@"height_i"];
                    NSString * larguraI = [dict objectForKey:@"width_i"];
                    NSString * freguesia = [dict objectForKey:@"cidade"];
                    
                    
                    
                    
                    
                    
                    rest.cuisinesResultText = @"";
                    for (NSMutableDictionary *cosinhas in [dict objectForKey:@"cozinhas"])
                    {
                        rest.cuisinesResultText =[NSString stringWithFormat:@"%@, %@",[cosinhas objectForKey:@"cozinhas_nome"],rest.cuisinesResultText] ;
                    }
                    
                    //rest.cuisinesResultText =[NSString stringWithFormat:@"%@\n%@",freguesia,rest.cuisinesResultText] ;
                    
                    rest.address = freguesia;
                    
                    rest.lat =[lati doubleValue];
                    rest.lon =[longi doubleValue];
                    rest.name = restName;
                    rest.dbId = [resId integerValue];
                    if(alturaI != [NSNull new] && [alturaI floatValue]>0)
                        rest.tamanhoImagem =  CGSizeMake([larguraI floatValue], [alturaI floatValue]);
                    
                    rest.featuredImageString = imagem;
                    //rest.name =   @"fabrica das verdadeiras queijadas da sapa";
                    
                    [restaurantes addObject:rest];
                }
                
                
                
                colececao = [CollectionGuru new];
                
                [colececao CarregarRestaurantes:restaurantes];
                 colececao.view.frame = self.viewContainer.frame;
                
                [self.view addSubview:colececao.view];
                
                
//                                break;
//            }
//                
//        }
    }else
    {
        NSLog(@"error webserviceSender %@",error);
        
    }
    
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)popAnterior:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)preperarPesquisa
{
    doneSearch = NO;
    
 
    
    if ([tipo isEqualToString:@"Restaurants"]) {
        webResultado = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_rest_nome.php" method:@"" tag:1];
        webResultado.delegate = self;
        
        NSMutableDictionary * dict = [NSMutableDictionary new];
//        
//        $body['lang'];
//        $body['nomeparte'];
        
        [dict setObject:result forKey:@"nomeparte"];
        [dict setObject:[Globals lang] forKey:@"lang"];
        
        [webResultado sendDict:dict];
    }
    else
    {
        webResultado = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_rest_cidade_nome.php" method:@"" tag:2];
        webResultado.delegate = self;
        
        NSMutableDictionary * dict = [NSMutableDictionary new];
        //
        //        $body['lang'];
        //        $body['nomeparte'];
        
        [dict setObject:result forKey:@"nomeparte"];
        [dict setObject:[Globals lang] forKey:@"lang"];
        
        [webResultado sendDict:dict];
    }
    
    
    
   
}



@end
