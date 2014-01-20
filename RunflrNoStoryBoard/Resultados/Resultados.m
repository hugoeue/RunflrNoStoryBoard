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
#import "SemDados.h"
#import "AnimationController.h"
#import <FacebookSDK/FacebookSDK.h>

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
    AnimationController * animation;

}

@property (strong, nonatomic) NSMutableArray* filteredTableData;

@end

@implementation Resultados
@synthesize locationManager;

-(void)dealloc
{
    if (webResultado) {
        [webResultado cancel];
    }
}

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
    NSString *txt = result;
    
   
    
    animation = [AnimationController new];
    
    animation.view.frame = CGRectMake(0, 0, 320,self.viewContainer.frame.size.height);
    [self.viewContainer addSubview:animation.view];
    [animation.viewFundo setAlpha:1];
    [animation.viewFundo setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1]];
    
    if(result.length>0)
        txt = [txt stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[txt substringToIndex:1] uppercaseString]];
    
    self.labelResultado.text=txt;
 
    [self preperarPesquisa];
    
    if(result.length == 0)
    {
        self.labelResultado.text=[Language textForIndex:@"Todos"];
    }
  
}

-(void)sendCompleteWithResult:(NSDictionary*)resulti withError:(NSError*)error{
    
    
    if (!error)
    {
//        int tag=[WebServiceSender getTagFromWebServiceSenderDict:resulti];
//        switch (tag)
//        {
//            case 1:
//            {
                NSLog(@"resultado da pesquisa por qualquer coisa =>%@", resulti.description);
                
                
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
                    NSString * telefone = [dict objectForKey:@"telefone"];
                    NSString * cidade = [dict objectForKey:@"cidade"];
                    NSString * freguesia = [dict objectForKey:@"freg_nome"];
                    NSNumber * seguir = [dict objectForKey:@"seguidores"];
                    NSString * pagante = [dict objectForKey:@"pag"];
                    
                    rest.cuisinesResultText = @"";
                    for (NSMutableDictionary *cosinhas in [dict objectForKey:@"cozinhas"])
                    {
                        rest.cuisinesResultText =[NSString stringWithFormat:@"%@, %@",[cosinhas objectForKey:@"cozinhas_nome"],rest.cuisinesResultText] ;
                    }
                    
                    if ( [rest.cuisinesResultText length] > 0)
                        rest.cuisinesResultText = [rest.cuisinesResultText substringToIndex:[rest.cuisinesResultText length] - 2];
                    
                    
                    
                    if ([seguir isEqualToNumber:[NSNumber numberWithInt:0]]) {
                        rest.isUserFav = NO;
                    }else {
                        rest.isUserFav = YES;
                    }
                    
                    

                    if([pagante isEqualToString:@"sim"])
                        rest.destaque = YES;
                    else
                        rest.destaque = NO;
                        
                    rest.address = freguesia;
                    rest.city = cidade;
                    rest.phone =[telefone doubleValue];
                    rest.lat =[lati doubleValue];
                    rest.lon =[longi doubleValue];
                    rest.name = restName;
                    rest.dbId = [resId integerValue];
                    if(alturaI != [NSNull new] && [alturaI floatValue]>0)
                        rest.tamanhoImagem =  CGSizeMake([larguraI floatValue], [alturaI floatValue]);
                    
                    rest.featuredImageString = imagem;
                    //rest.name =   @"fabrica das verdadeiras queijadas da sapa";
                    
                    [restaurantes addObject:rest];
                    [animation removeFromParentViewController];
                }
                
        if(restaurantes.count>0){
            
                colececao = [CollectionGuru new];
                colececao.delegate = self;
                colececao.locationManager = locationManager;
        
                [colececao CarregarRestaurantes:restaurantes];
                 colececao.view.frame = self.viewContainer.frame;
                
                [self.view addSubview:colececao.view];
                
        }else{
            // quando vem com 0 restaurantes recomendados
            SemDados * vazio = [SemDados new];
            vazio.view.frame = CGRectMake(0,
                                          0,
                                          self.viewContainer.frame.size.width,
                                          self.viewContainer.frame.size.height);
            [self.viewContainer addSubview:vazio.view];
            vazio.imagem.image = [UIImage imageNamed:@"cry-50.png"];
            vazio.labelTitulo.text = @"Não encontrado";
            vazio.labelMenssagem.text = @"";
            vazio.labelDescricao.text = @"Não conseguimos encontrar nenhum resultado, por favor tente com outra palavra chave. ";


        }
        
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
    
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
        [self prepararPesquisaLogin];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
        [self prepararPesquisaLogin];
    }
    else if ([FBSession activeSession].isOpen && ![Globals user]){
        [self prepararPesquisaLogin];
    }else{
        [self prepararPesquisaLogOut];
    }


}

-(void)prepararPesquisaLogin
{
    doneSearch = NO;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    if([Globals user].faceId)
    {
        [dict setObject: [Globals user].faceId forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"user_id"];
    }else
    {
        [dict setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", [Globals user].dbId] forKey:@"user_id"];
    }
    
    

    
    if ([tipo isEqualToString:@"Restaurants"]) {
        //webResultado = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_teste2.php" method:@"" tag:1];
        webResultado = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_rest_nome2.php" method:@"" tag:1];
        webResultado.delegate = self;
        
        NSString * latitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude] ;
        NSString * longitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude] ;
        
        [dict setObject:latitude forKey:@"lat"];
        [dict setObject:longitude forKey:@"lon"];
        
        [dict setObject:result forKey:@"nomeparte"];
        [dict setObject:[Globals lang] forKey:@"lang"];
        
        [webResultado sendDict:dict];
    }
    else
    {
        //webResultado = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_rest_nome2.php" method:@"" tag:2];
        webResultado = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_rest_cidade_nome2.php" method:@"" tag:2];
        webResultado.delegate = self;
        
   
        NSString * latitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude] ;
        NSString * longitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude] ;
        
        [dict setObject:latitude forKey:@"lat"];
        [dict setObject:longitude forKey:@"lon"];
       
        
        
        [dict setObject:result forKey:@"nomeparte"];
        [dict setObject:[Globals lang] forKey:@"lang"];
        
        [webResultado sendDict:dict];
    }

    
}

-(void)prepararPesquisaLogOut
{
    doneSearch = NO;
    
    
    
    if ([tipo isEqualToString:@"Restaurants"]) {
        webResultado = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_rest_nome.php" method:@"" tag:1];
        webResultado.delegate = self;
        
        NSMutableDictionary * dict = [NSMutableDictionary new];
        
        NSString * latitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude] ;
        NSString * longitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude] ;
        
        [dict setObject:latitude forKey:@"lat"];
        [dict setObject:longitude forKey:@"lon"];
        
        
        [dict setObject:result forKey:@"nomeparte"];
        [dict setObject:[Globals lang] forKey:@"lang"];
        
        [webResultado sendDict:dict];
    }
    else
    {
        webResultado = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_rest_cidade_nome.php" method:@"" tag:2];
        webResultado.delegate = self;
        
        NSMutableDictionary * dict = [NSMutableDictionary new];
        
        NSString * latitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude] ;
        NSString * longitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude] ;
        
        [dict setObject:latitude forKey:@"lat"];
        [dict setObject:longitude forKey:@"lon"];
        
        
        [dict setObject:result forKey:@"nomeparte"];
        [dict setObject:[Globals lang] forKey:@"lang"];
        
        [webResultado sendDict:dict];
    }

}




-(void)chamarRestaurante:(Restaurant *)rest
{
    // chamar restaurante
    NSLog(@"restaurante chamado chamase %@", rest.name);
    
    Diarias * details = [Diarias new];
    details.delegate = self.delegate;
    details.locationManager = locationManager;
    [details loadRestaurant:rest];
    
    [self.navigationController pushViewController:details animated:YES];
}



@end
