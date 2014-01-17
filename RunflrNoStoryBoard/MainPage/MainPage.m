//
//  MainPage.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 02/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "MainPage.h"
#import "Resultados.h"
#import "MenuRefugio.h"
#import "CitiesParser.h"
#import "FeaturedParser.h"
#import "City.h"
#import <FacebookSDK/FacebookSDK.h>
#import "HTAutocompleteManager.h"
#import "AppDelegate.h"
#import "UserParser.h"
#import "Login.h"
#import "WebServiceSender.h"
#import "FXImageView.h"
#import "CollectionGuru.h"
#import "Diarias.h"
#import "SemDados.h"
#import "AnimationController.h"
#import "DemoRootViewController.h"



@interface MainPage ()
{
    
    bool showFacebook;
    NSString * tipo;
    
    BOOL isTiming;
    BOOL isFavOpen;
    
    NSTimer *timer;
    
    UIAlertView *alert;
    UIAlertView *alertBoo;
    UIAlertView *alertBoo2;
    
    WebServiceSender * recomendados;
    WebServiceSender * favWeb;
    WebServiceSender * rests;
    WebServiceSender * cits;
    
    NSMutableArray * restaurantesRecomendados;
    
    CollectionGuru * colececaoRecomendados;
    CollectionGuru * colececaoFavoritos;
    
    SemDados * vazio;
    
    AnimationController * animation;
}

@property (strong, nonatomic) NSCache *imageCache;

@end

int num = 0;

@implementation MainPage




-(void)lerRecomendados
{
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
    
    
    NSLog(@"Tipo de login realisado main page did appear %@",[Globals user].loginType);
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
        [self lerRecomendadosLogin];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
        [self lerRecomendadosLogin];
    }
    else if ([FBSession activeSession].isOpen && ![Globals user]){
        [self loadUser];
    }else{
        [self lerRecomendadosLogOut];
    }

    
}

-(void)lerRecomendadosLogOut
{
    recomendados = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_recomendados3.php" method:@"" tag:1];
    recomendados.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    
    
    [dict setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
    [dict setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"lon"];
    
    
    
    
    [recomendados sendDict:dict];

}

-(void)lerRecomendadosLogin
{
     if (recomendados)
         [recomendados cancel];
         
    recomendados = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_recomendados4.php" method:@"" tag:1];
    recomendados.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    
    
    [dict setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
    [dict setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"lon"];
    
    if([Globals user].faceId)
    {
        [dict setObject: [Globals user].faceId forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"user_id"];
    }else
    {
        [dict setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", [Globals user].dbId] forKey:@"user_id"];
    }

    
    
    [recomendados sendDict:dict];
    //}
    
}


-(NSString *)imprimirDistancia:(Restaurant *)rest
{
    if (locationManager) {
        CLLocation * localRest = [[CLLocation alloc] initWithLatitude:rest.lat longitude:rest.lon];
        CLLocation * localActual = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
        
        CLLocationDistance distance = [localActual distanceFromLocation:localRest];
        //NSLog(@"distancia calculada  %f de %@", distance,rest.name);
        
        if (distance>1000) {
            return [NSString stringWithFormat:@"%.2f Km",distance/1000];
        }
        
        
        return [NSString stringWithFormat:@"%.0f m",distance];
    }else
    {
        return @"sem GPS";
    }
    
   
}

-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado dalista dos recomendados =>%@", result.description);
                
                if(![[result objectForKey:@"resp"] isEqualToString:@"sem geolocalizacao"]){
               
               // distancia emtre 2 pontos;
               // CLLocationDistance distance = [aCLLocationA distanceFromLocation:aCLLocationB];
                
                NSString * lat = [result objectForKey:@"lat"];
                NSString * lon = [result objectForKey:@"lon"];
                
                CLLocation * localOriginal = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lon doubleValue]];
                
                restaurantesRecomendados = [NSMutableArray new];
               
                for(NSMutableDictionary * dict in [result objectForKey:@"res"]){
                    Restaurant * rest = [Restaurant new];
                    
                
                    //NSString *dist = [dict objectForKey:@"dist"];
                    NSString * restName = [dict objectForKey:@"nome"];
                    NSString * resId = [dict objectForKey:@"id"];
                    NSString * lati = [dict objectForKey:@"lat"];
                    NSString * longi = [dict objectForKey:@"lon"];
                    NSString * imagem = [dict objectForKey:@"imagem"];
                    NSString * alturaI = [dict objectForKey:@"height_i"];
                    NSString * larguraI = [dict objectForKey:@"width_i"];
                    NSString * cidade = [dict objectForKey:@"cidade"];
                    NSString * freguesia = [dict objectForKey:@"freg_nome"];
                    NSNumber * seguir = [dict objectForKey:@"seguidores"];
                    
                    NSString * telefone = [dict objectForKey:@"telefone"];
                    rest.phone =[telefone doubleValue];
                  
                    if([[dict objectForKey:@"pag"] isEqualToString:@"sim"])
                    {
                        rest.destaque = YES;
                    }else
                    {
                        rest.destaque = NO;
                    }
                    
                    
                    CLLocation * localRest = [[CLLocation alloc] initWithLatitude:[lati doubleValue] longitude:[longi doubleValue]];
                    
                    
                  
                    
                    //CLLocationDistance distance = [localOriginal distanceFromLocation:localRest];
                    
                    
                  
                    rest.cuisinesResultText = @"";
                    for (NSMutableDictionary *cosinhas in [dict objectForKey:@"cozinhas"])
                    {
                        rest.cuisinesResultText =[NSString stringWithFormat:@"%@, %@",[cosinhas objectForKey:@"cozinhas_nome"],rest.cuisinesResultText] ;
                    }
                    
                    if ( [rest.cuisinesResultText length] > 0)
                        rest.cuisinesResultText = [rest.cuisinesResultText substringToIndex:[rest.cuisinesResultText length] - 2];

                    
                    rest.address = freguesia;
                    rest.city = cidade;
                    
                    if ([seguir isEqualToNumber:[NSNumber numberWithInt:0]]) {
                        rest.isUserFav = NO;
                    }else {
                        rest.isUserFav = YES;
                    }
                   
                    
                    rest.lat =[lati doubleValue];
                    rest.lon =[longi doubleValue];
                    rest.name = restName;
                    rest.dbId = [resId integerValue];
                    if(alturaI != [NSNull new] && [alturaI floatValue]>0)
                        rest.tamanhoImagem =  CGSizeMake([larguraI floatValue], [alturaI floatValue]);
                    
                    rest.featuredImageString = imagem;
                    //rest.name =   @"fabrica das verdadeiras queijadas da sapa";
                    
                    [restaurantesRecomendados addObject:rest];
                    [vazio removeFromParentViewController];
                    [colececaoFavoritos removeFromParentViewController];
                    
                }
                
                if (restaurantesRecomendados.count>0) {
                    [self ordenarPorPagos:restaurantesRecomendados];
                    colececaoRecomendados.view.frame = CGRectMake(0, 0, self.viewContainer.frame.size.width, self.viewContainer.frame.size.height);
                    isFavOpen = NO;
                    
                    self.viewFavoritos.frame = CGRectMake(0, -40, 320, 40);
                    [colececaoRecomendados.collectionView setContentInset:UIEdgeInsetsMake(40, 0, 0, 0)];
                    [colececaoRecomendados.collectionView addSubview: self.viewFavoritos];

                }else
                {
                    // quando vem com 0 restaurantes recomendados
                    vazio = [SemDados new];
                    vazio.view.frame = CGRectMake(0,
                                                  0,
                                                  self.viewContainer.frame.size.width,
                                                  self.viewContainer.frame.size.height);
                    vazio.imagem.image = [UIImage imageNamed:@"compas-50.png"];
                    vazio.labelTitulo.text = [Language textForIndex:@"Geolocalizacao"];
                    vazio.labelMenssagem.text =[Language textForIndex:@"Obter_melhor_Menu_guru"];
                    vazio.labelDescricao.text = [Language textForIndex:@"Texto_Activa_Geolocalizacao"];
                    [self.viewContainer addSubview:vazio.view];
                    
                    self.viewFavoritos.frame = CGRectMake(0, 0, 320, 40);
                     [self.viewContainer addSubview:self.viewFavoritos];
                }
                }else
                {
                    // quando o servidor responde que recebeu geolocalização com coordenadas erradas...
                    [colececaoRecomendados removeFromParentViewController];
                    [colececaoFavoritos removeFromParentViewController];
                    vazio = [SemDados new];
                    vazio.view.frame = CGRectMake(0,
                                                  0,
                                                  self.viewContainer.frame.size.width,
                                                  self.viewContainer.frame.size.height);
                    vazio.imagem.image = [UIImage imageNamed:@"compas-50.png"];
                    vazio.labelTitulo.text = [Language textForIndex:@"Geolocalizacao"];
                    vazio.labelMenssagem.text =[Language textForIndex:@"Obter_melhor_Menu_guru"];
                    vazio.labelDescricao.text = [Language textForIndex:@"Texto_Activa_Geolocalizacao"];
                    [self.viewContainer addSubview:vazio.view];
                    [animation.view removeFromSuperview];
                    self.viewFavoritos.frame = CGRectMake(0, 0, 320, 40);
                     [self.viewContainer addSubview:self.viewFavoritos];
                    
                }
                
               
 
                //
                break;
            }
            case 2:
            {
                NSLog(@"resultado dalista dos favoritos =>%@", result.description);
                
                
                
                restaurantesRecomendados = [NSMutableArray new];
                
                for(NSMutableDictionary * dict in [result objectForKey:@"resp"]){
                    Restaurant * rest = [Restaurant new];
                    
                    
                    //NSString *dist = [dict objectForKey:@"dist"];
                    NSString * restName = [dict objectForKey:@"nome"];
                    NSString * resId = [dict objectForKey:@"id"];
                    NSString * lati = [dict objectForKey:@"lat"];
                    NSString * longi = [dict objectForKey:@"lon"];
                    NSString * imagem = [dict objectForKey:@"imagem"];
                    NSString * alturaI = [dict objectForKey:@"height_i"];
                    NSString * larguraI = [dict objectForKey:@"width_i"];
                    NSString * cidade = [dict objectForKey:@"cidade"];
                    NSString * freguesia = [dict objectForKey:@"freg_nome"];
                    
                    NSString * telefone = [dict objectForKey:@"telefone"];
                    rest.phone =[telefone doubleValue];
                    
                    
                    if([[dict objectForKey:@"pag"] isEqualToString:@"1"])
                    {
                        rest.destaque = YES;
                    }else
                    {
                        rest.destaque = NO;
                    }

                    
                    rest.cuisinesResultText = @"";
                    for (NSMutableDictionary *cosinhas in [dict objectForKey:@"cozinhas"])
                    {
                        rest.cuisinesResultText =[NSString stringWithFormat:@"%@, %@",[cosinhas objectForKey:@"cozinhas_nome"],rest.cuisinesResultText] ;
                    }
                    
                    if ( [rest.cuisinesResultText length] > 0)
                        rest.cuisinesResultText = [rest.cuisinesResultText substringToIndex:[rest.cuisinesResultText length] - 2];
                    

                    rest.address = freguesia;
                    rest.city = cidade;
                    
                    rest.lat =[lati doubleValue];
                    rest.lon =[longi doubleValue];
                    rest.name = restName;
                    rest.dbId = [resId integerValue];
                    if(alturaI != [NSNull new] && [alturaI floatValue]>0)
                        
                    rest.tamanhoImagem =  CGSizeMake([larguraI floatValue], [alturaI floatValue]);
                    
                    rest.featuredImageString = imagem;
                    //rest.name =   @"fabrica das verdadeiras queijadas da sapa";
                    
                    rest.isUserFav = YES;
                    
                    [restaurantesRecomendados addObject:rest];
                }
                
                if(restaurantesRecomendados.count ==0)
                {
                    vazio = [SemDados new];
                    vazio.view.frame = CGRectMake(0,
                                                  0,
                                                  self.viewContainer.frame.size.width,
                                                  self.viewContainer.frame.size.height);
                    [self.viewContainer addSubview:vazio.view];
                    vazio.imagem.image = [UIImage imageNamed:@"star-50.png"];
                    vazio.labelTitulo.text = [Language textForIndex:@"Adicione_Favoritos"];
                    vazio.labelMenssagem.text =[Language textForIndex:@"Adicionar_lista_favoritos"];
                    vazio.labelDescricao.text = @"";
                    self.viewFavoritos.frame = CGRectMake(0, 0, 320, 40);
                    [vazio.view addSubview:self.viewFavoritos];

                }else
                {
                
                    colececaoFavoritos = [CollectionGuru new];
                    colececaoFavoritos.delegate = self;
                    colececaoFavoritos.locationManager = locationManager;
                
                    [colececaoFavoritos CarregarRestaurantes:restaurantesRecomendados];
                    colececaoFavoritos.view.frame = CGRectMake(0, 0, self.viewContainer.frame.size.width, self.viewContainer.frame.size.height);
                
                    [self.viewContainer addSubview:colececaoFavoritos.view];
                    [vazio removeFromParentViewController];
                    [colececaoRecomendados removeFromParentViewController];
                    self.viewFavoritos.frame = CGRectMake(0, -40, 320, 40);
                    [colececaoFavoritos.collectionView setContentInset:UIEdgeInsetsMake(40, 0, 0, 0)];
                    [colececaoFavoritos.collectionView addSubview: self.viewFavoritos];

                    
                }
                 [animation.view removeFromSuperview];
                
               
                
                break;
            }
            case 3:
            {
               // NSLog(@"cidades existentes %@", result);
                
                NSMutableArray *array =[NSMutableArray new];
                for (NSMutableDictionary *dict in [result objectForKey:@"resp"]) {
                    City * cit = [City new];
                    cit.name = [dict objectForKey:@"nome"];
                    //cit.dbId = [dict objectForKey:@"id"];
                    [array addObject:cit];
                }
                [Globals setCities:array];
                
                NSLog(@"success loaded cities");
                
                /*
                 for (City * vitie in [Globals cities]) {
                 NSLog(@"Citie name: %@ ",vitie.name);
                 }
                 */
                
                [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
                
                
                //self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
                
                self.texfFieldPesquisa.autocompleteType = HTAutocompleteTypeColor;

                
                break;
            }
            case 4:
            {
               // NSLog(@"restaurantes existentes %@", result);
                
                NSMutableArray *array =[NSMutableArray new];
                for (NSMutableDictionary *dict in [result objectForKey:@"resp"]) {
                    Restaurant * rest = [Restaurant new];
                    rest.name = [dict objectForKey:@"nome"];
                    //cit.dbId = [dict objectForKey:@"id"];
                    [array addObject:rest];
                }
                [Globals setSearchResult:array];
                
                NSLog(@"success loaded cities");
                
                 /*
                 for (City * vitie in [Globals cities]) {
                 NSLog(@"Citie name: %@ ",vitie.name);
                 }
                 */
                
                [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
                
                
                //self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
                
                self.texfFieldPesquisa.autocompleteType = HTAutocompleteTypeColor;
            
                break;
            }
                
        }
    }else
    {
        NSLog(@"error webserviceSender %@",error);
        
    }
    
    
}

-(void)ordenarPorPagos:(NSMutableArray *)array
{
    
    
    // ok tenho de ter 2 arrays de restaurantes para pagos e para nao pagos
    NSMutableArray * arrayPagos = [NSMutableArray new];
    NSMutableArray * arrayNaoPagos = [NSMutableArray new];
    

    NSMutableArray * maisPerto = [NSMutableArray new];
    
    for (Restaurant * rest in array) {
        if(rest.destaque)
        {
            [arrayPagos addObject:rest];
        }
        else
        {
            [arrayNaoPagos addObject:rest];
        }
    }
    

    NSLog(@"total de restaurantes pagos %d", arrayPagos.count);
    for (int i = 0 ; i< arrayPagos.count ;i++)
    {
        //Restaurant * rest1 = [arrayPagos objectAtIndex:i];
     
        if (i<1 && arrayNaoPagos.count>3) {
            [arrayPagos insertObject:[arrayNaoPagos objectAtIndex:i] atIndex:i];
            [arrayNaoPagos removeObjectAtIndex:i];
        }
        
         //NSLog(@"total %hhd %@", ((Restaurant *)[arrayPagos objectAtIndex:i]).destaque , ((Restaurant *)[arrayPagos objectAtIndex:i]).name);
        
        if (i>=9) {
            [arrayPagos removeObjectAtIndex:i];
        }
    }
    
    
    // isto é para adicionar os nao pagos no fim
    if(arrayPagos.count<12)
    {
        int i = 1;
        while (arrayPagos.count<12 && arrayNaoPagos.count>0) {
            [arrayPagos insertObject:[arrayNaoPagos objectAtIndex:0] atIndex:arrayPagos.count];
            [arrayNaoPagos removeObjectAtIndex:0];
            i++;
        }
    }
    
   
 
    [maisPerto setArray:arrayPagos];
    
    NSLog(@"total de restaurantes %d", maisPerto.count);
    
    
    for (int i = 0 ; i< arrayPagos.count ;i++)
    {
     
       // NSLog(@"na collection %hhd %@", ((Restaurant *)[arrayPagos objectAtIndex:i]).destaque , ((Restaurant *)[arrayPagos objectAtIndex:i]).name);
       
    }

    
    restaurantesRecomendados = maisPerto;
    
    
    colececaoRecomendados = [CollectionGuru new];
    colececaoRecomendados.delegate = self;
    colececaoRecomendados.locationManager = locationManager;
    
    [colececaoRecomendados CarregarRestaurantes:restaurantesRecomendados];
   // colececaoRecomendados.view.frame = CGRectMake(0, 130, 320, 438);
   
    [self.viewContainer addSubview:colececaoRecomendados.view];
    

    
    
    
}

-(void)chamarRestaurante:(Restaurant *)rest
{
    // chamar restaurante
   // NSLog(@"restaurante chamado chamase %@", rest.name);
    
    Diarias * details = [Diarias new];
    //[details setSeguir:rest.isUserFav];
    details.delegate = self.delegate;
    details.locationManager = locationManager;
    [details loadRestaurant:rest];
    
    [self.navigationController pushViewController:details animated:YES];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
   
     [self.buttonPesquisa setUserInteractionEnabled:YES];
     self.labelCidade.text =[Language textForIndex:@"Cidade"];
    self.labelRestaurante.text =[Language textForIndex:@"Restaurante"];
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
    
    // tenho de fazer um if para recarregar as cenas na coleçao
    if (isFavOpen)
    {
        [self ChamarFavoritos];
    }
    else{
        // senao ainda nao faz nada
    }
}



- (void)viewWillDisappear:(BOOL)animated {
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
    [super viewWillDisappear:animated];
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
     [colececaoFavoritos removeFromParentViewController];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
}




-(void)viewDidAppear:(BOOL)animated
{
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];

    
    NSLog(@"Tipo de login realisado main page did appear %@",[Globals user].loginType);
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
        [self loadUser];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
         [self loadGuruImage];
    }
    else if ([FBSession activeSession].isOpen && ![Globals user])
    {
        [self loadUser];
    }else
    {
        [self loadButtonLogin];
    }
    
    UIColor *color = [UIColor lightTextColor];
    self.texfFieldPesquisa.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[Language textForIndex:@"Pesquisar"] attributes:@{NSForegroundColorAttributeName: color}];
    
    [self.selectionView setTitle:[Language textForIndex:@"Recomendados"] forSegmentAtIndex:0];
    [self.selectionView setTitle:[Language textForIndex:@"Favoritos"] forSegmentAtIndex:1];
    //[vazio.view removeFromSuperview];
    
    if(!isFavOpen)
    [self lerRecomendados];
  
}

-(void)loadButtonLogin
{
    self.imageFacebook.image = [UIImage imageNamed:@"QUADRADO SUBMETER.png"];
    self.imageFacebook.layer.cornerRadius = self.imageFacebook.frame.size.height/2;
    self.imageFacebook.clipsToBounds = YES;
    self.imageFacebook.layer.borderWidth = 0.0f;
    self.imageFacebook.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonGo.alpha = 1;
    self.labelUsername.text =@"";
    
}



- (void)loadGuruImage
{
    
    self.imageFacebook.image = [UIImage imageNamed:@"transferir.jpeg"];
    self.imageFacebook.layer.cornerRadius = self.imageFacebook.frame.size.height/2;
    self.imageFacebook.clipsToBounds = YES;
    self.imageFacebook.layer.borderWidth = 1.0f;
    self.imageFacebook.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonGo.alpha = 0;
    self.labelUsername.text =[NSString stringWithFormat:@"Olá %@",[Globals user].name] ;
    self.labelUsername.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    animation = [AnimationController new];
   
       // [animation.view setFrame:self.viewContainer.frame];
    animation.view.frame = CGRectMake(0, 0, 320, self.viewContainer.frame.size.height);
    [self.viewContainer addSubview:animation.view];
     [animation.viewFundo setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1]];
    
    
    
    
    self.navigationController.navigationBarHidden = YES;
    
    
    //self.labelRestaurante.text = [Language textForIndex:@"MainFrase1"];
    
    self.texfFieldPesquisa.delegate = self;
    
    [self.buttonCities setSelected:YES];
    tipo = @"Cities";

    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    
   
    
   
    

    
    // Set a default data source for all instances.  Otherwise, you can specify the data source on individual text fields via the autocompleteDataSource property
    

    [self setTextPadding:self.texfFieldPesquisa];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.topView addGestureRecognizer:singleTap];

   // [self makeLogin];
    //[self loadUser];
   
    //self.scrollView.contentOffset = CGPointMake( 0, 90);
    
    
    [self carragarCidades];
    [self carregaRestaurantes];
    
    
    [self gps];
    
 
    
   
    
    self.collectionView.delegate = self;
    

}

-(void)carregaRestaurantes
{
    cits = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_search_rest.php" method:@"" tag:4];
    cits.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    //
    //        $body['lang'];
    //        $body['nomeparte'];
    
    
    [dict setObject:[Globals lang] forKey:@"lang"];
    
    [cits sendDict:dict];
    
}

-(void)carragarCidades
{
    rests = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_search_cities.php" method:@"" tag:3];
    rests.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    //
    //        $body['lang'];
    //        $body['nomeparte'];
    
    
    [dict setObject:[Globals lang] forKey:@"lang"];
    
    [rests sendDict:dict];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@" scrolloffset %f",scrollView.contentOffset.y);
//    CGFloat numero = scrollView.contentOffset.y *-1;
//    CGFloat alpha = numero/(numero /0.5f)   ;
    
    
    if (self.scrollView == scrollView) {
    
    CGFloat alpha;
    CGFloat alpha2;
        if (scrollView.contentOffset.y!=0){
        alpha =0.7;
            alpha2=1;
        }
    else
    {
        alpha = 0;
        alpha2 = 0;
    }
        
    [UIView animateWithDuration:0.5 animations:^{
        [self.uiviewTransparent setAlpha:alpha];
        [self.labelCidade setAlpha:alpha2];
        [self.labelRestaurante setAlpha:alpha2];
        
           }];
        
        
    }

}


-(void)gps
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // tem de chamar aqui o webservice
    // ele passa aqui muitas vezes
    [self lerRecomendados];
    [locationManager stopUpdatingLocation];
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
   
    if ([error domain] == kCLErrorDomain) {
        
        // We handle CoreLocation-related errors here
        switch ([error code]) {
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
            case kCLErrorDenied:
            {
                vazio = [SemDados new];
                vazio.view.frame = CGRectMake(0,
                                              0,
                                              self.viewContainer.frame.size.width,
                                              self.viewContainer.frame.size.height);
                
                vazio.imagem.image = [UIImage imageNamed:@"compas-50.png"];
                vazio.labelTitulo.text = [Language textForIndex:@"Geolocalizacao"];
                vazio.labelMenssagem.text =[Language textForIndex:@"Obter_melhor_Menu_guru"];
                vazio.labelDescricao.text = [Language textForIndex:@"Texto_Activa_Geolocalizacao"];
                [self.viewContainer addSubview:vazio.view];
                [colececaoRecomendados removeFromParentViewController];
                [colececaoFavoritos removeFromParentViewController];
                
               
                
                break;
            }
                
            case kCLErrorLocationUnknown:
                
            default:
                break;
        }
    } else {
        // We handle all non-CoreLocation errors here
    }
}





-(void)setTextPadding:(UITextField *)field
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    field.leftView = paddingView;
    field.leftViewMode = UITextFieldViewModeAlways;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
     [self.scrollView setContentOffset:CGPointMake( 0,0) animated:YES];
    [self.texfFieldPesquisa resignFirstResponder];
}

-(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushNav:(id)sender {
    //[self ChamarPesquisa];
    //[self makeLogin];
    
    // tenho de chamar o controlador de login
    
   [self chamarLogin];
    
}

-(void)ChamarPesquisa
{
    // bug
    
    Resultados *c = [[Resultados alloc] initWithNibName:@"Resultados" bundle:nil];
    
    if(self.texfFieldPesquisa.text)
    
        [c setResultado:self.texfFieldPesquisa.text];
    else
        [c setResultado:@""];
    
    c.locationManager = locationManager;
    c.delegate = self.delegate;
    [c setTipo:tipo];
    [self.navigationController pushViewController:c animated:YES];
    PP_RELEASE(c);
}


-(void)escurecer
{
    float alpha = 0.5;
    
    if (self.viewPretaGrande.alpha== alpha) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.viewPretaGrande setAlpha:0];
            
            [self.buttonMenu setFrame:CGRectMake(self.buttonMenu.frame.origin.x+3
                                                 ,self.buttonMenu.frame.origin.y+3
                                                 ,self.buttonMenu.frame.size.width-6
                                                 ,self.buttonMenu.frame.size.height-6
                                                 )];
        }];
        
    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
            [self.viewPretaGrande setAlpha:alpha];
            
            [self.buttonMenu setFrame:CGRectMake(self.buttonMenu.frame.origin.x-3
                                                 ,self.buttonMenu.frame.origin.y-3
                                                 ,self.buttonMenu.frame.size.width+6
                                                 ,self.buttonMenu.frame.size.height+6
                                                 )];
        }];
        
    }
}

- (IBAction)pushMenu:(id)sender {
    
//    MenuRefugio *t = [[MenuRefugio alloc] init];
//    t.delegate = self;
//    //UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:t];
//    
//    [self.revealSideViewController pushViewController:t onDirection:PPRevealSideDirectionTop withOffset:t.view.frame.size.height animated:YES];
//    PP_RELEASE(t);
//    //PP_RELEASE(n);
    //[self.scrollView setContentOffset:CGPointMake( 0, 90) animated:YES];
    if (self.delegate)
    {
        [self.delegate performSelector:@selector(chamarTopo) ];
        
     
        
        
    }
    

    [self.texfFieldPesquisa resignFirstResponder];
    [self.scrollView setContentOffset:CGPointMake( 0, 0) animated:YES];
}


// para poder chamar o centro ao fim de alguma coisa
-(void)callCenter
{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionNone animated:YES];
}

- (IBAction)ClickCitie:(id)sender {
    //[((UIButton *)sender) setSelected:YES];
    //[self.buttonRestaurant setSelected:NO];
    [self.imgSetectRest setImage:[UIImage imageNamed:@"noselect.png"]];
    [self.imgSelectcidate setImage:[UIImage imageNamed:@"select.png"]];
   
    self.texfFieldPesquisa.autocompleteType = HTAutocompleteTypeColor;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.imageBico setFrame:CGRectMake(170,
                                            self.imageBico.frame.origin.y,
                                            self.imageBico.frame.size.width,
                                            self.imageBico.frame.size.height
                                            )];
        
        
    }];

    
    tipo = @"Cities";
}

- (IBAction)ClickRestaurant:(id)sender {
    //[((UIButton *)sender) setSelected:YES];
    //[self.buttonCities setSelected:NO];
    [self.imgSetectRest setImage:[UIImage imageNamed:@"select.png"]];
    [self.imgSelectcidate setImage:[UIImage imageNamed:@"noselect.png"]];

    self.texfFieldPesquisa.autocompleteType = HTAutocompleteTypeRest;
   
    
 
        [UIView animateWithDuration:0.5 animations:^{
            [self.imageBico setFrame:CGRectMake(250,
                                                self.imageBico.frame.origin.y,
                                                self.imageBico.frame.size.width,
                                                self.imageBico.frame.size.height
                                                )];

        }];
    
    
    tipo = @"Restaurants";
}

- (IBAction)clickPesquisa:(id)sender {

    
    
    if(self.scrollView.contentOffset.y == 0){
        [self.scrollView setContentOffset:CGPointMake( 0, -90) animated:YES];
        [self.texfFieldPesquisa becomeFirstResponder];
    }
    else{
        [self.scrollView setContentOffset:CGPointMake( 0, 0) animated:YES];
        [self.texfFieldPesquisa resignFirstResponder];
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.texfFieldPesquisa) {
        [textField resignFirstResponder];
        [self ChamarPesquisa];
        return NO;
    }
    
    return YES;
}

#pragma mark - THREADED PARSERS




- (void)noConnect
{
    
    alertBoo = [[UIAlertView alloc]
                             initWithTitle:[Language textForIndex:@"GlobalComErrorTitle"]
                             message:[Language textForIndex:@"GlobalComErrorText"]
                             delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    
    [alertBoo show];
}





-(void)makeLogin
{
    
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
            
        }
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            
            
            
            [FBSession setActiveSession:session];
            [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                if (!error) {
                    
                    [NSThread detachNewThreadSelector:@selector(upUser:) toTarget:self withObject:user];
                    
                }
            }];
            
            
        }];
   

}

- (IBAction)clickFav:(id)sender {
    
    NSLog(@"Tipo de login realisado mainpage click fav%@",[Globals user].loginType);
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
          [self ChamarFavoritos];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
          [self ChamarFavoritos];
    }
    else if (![Globals user]){
        // tenho de por esta cena no viewdidappear
            alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Para ter acesso a esta funcionalidade tem de ter login \ndeseja fazer agora?" delegate:self   cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
          //  [alert show];
        
         [self chamarLogin];
    }else{
        [self ChamarFavoritos];
        }
}

-(void)chamarLogin{
    Login *log = [Login new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:log];
    
    //[self.revealSideViewController presentViewController:nav animated:YES completion:nil];
    //[self presentViewController:nav animated:YES completion:nil];
    [[DemoRootViewController getInstance] presentViewController:nav animated:YES completion:nil];
    
    //[self.navigationController pushViewController:log animated:YES];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if(alertView == alert){
        if (buttonIndex == 1) {
            //[self makeLogin];
            
            [self chamarLogin];
            
        }else{
            // nao faz nada
        }
    }
    if(alertView == alertBoo)
    {
        exit(0);
    }
    
}



- (void)loadUser
{
    NSLog(@"fazer login");
    __block NSString *msgtxt;
    if ([FBSession activeSession].isOpen) {
        
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection, id<FBGraphUser> user, NSError *error) {
             
             
             
             msgtxt = [NSString stringWithFormat:@"%@  -  %@", user.id, user.name];
             
             //             NSLog(@"USER DATA:::%@  -  %@", user.id, user.name);
             
             if (![Globals user]) {
                 [Globals setUser:[[User alloc] init]];
             }
             
             [Globals user].email = [user objectForKey:@"email"];
             
             [Globals user].faceId = user.id;
             [Globals user].name = user.name;
             [Globals user].loginType = @"facebook";

             
             [self lerRecomendados ];

                }];
    }
    
    
    
}

- (void)upUser:(NSDictionary<FBGraphUser> *)user
{
    NSString *userId = user.id;
    NSString *userName = user.name;
    NSString *userEmail = [user objectForKey:@"email"];
    
    NSLog(@"USERID: %@", userId);
    NSLog(@"USER: %@", userName);
    NSLog(@"mail: %@", userEmail);
    
    if (![Globals user]) {
        [Globals setUser:[[User alloc] init]];
    }
    
    
    
    //             NSLog(@"USER DATA:::%@  -  %@", user.id, user.name);
    
    [Globals user].email = [user objectForKey:@"email"];
    
    [Globals user].faceId = user.id;
    [Globals user].name = user.name;
    [Globals user].loginType = @"facebook";
    
 
}


- (void)noConnect2
{
    alertBoo2 = [[UIAlertView alloc]
                             initWithTitle:[Language textForIndex:@"GlobalComErrorTitle"]
                             message:[Language textForIndex:@"GlobalComErrorText"]
                             delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    
    [alertBoo2 show];
}

#pragma mark - alertView delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView == alertBoo2)
    if (buttonIndex == 1) {
        NSString *phoneNumber = [@"tel://" stringByAppendingFormat:@"%d",[Globals restaurant].phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}




-(void)ChamarFavoritos
{
    
    [self.viewContainer addSubview:animation.view];
    [animation.viewFundo setBackgroundColor:[UIColor blackColor]];
    isFavOpen = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.viewFavoritos setBackgroundColor:[UIColor darkGrayColor]];
        [self.viewRecomendamos setBackgroundColor:[UIColor blackColor]];
        [self.viewRecomendamos setFrame:CGRectMake(self.viewRecomendamos.frame.origin.x,
                                                self.viewRecomendamos.frame.origin.y,
                                                140,
                                                self.viewRecomendamos.frame.size.height)];
        
    }];
    

    NSLog(@"chamar navigation com os favoritos");
    
    favWeb = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_fav.php" method:@"" tag:2];
    favWeb.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    //        $user_id=$body['user_id'];
    //        $face_id=$body['face_id'];
    
    User * cenas = [Globals user];
    
    if([Globals user].faceId)
    {
        [dict setObject: [Globals user].faceId forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"user_id"];
    }else
    {
        [dict setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", [Globals user].dbId] forKey:@"user_id"];
    }
    
    [favWeb sendDict:dict];

    
}




- (void)facebookLoginLogout
{
    if ([FBSession activeSession].isOpen) {
        [[FBSession activeSession] closeAndClearTokenInformation];
        
    } else {
        
    }
    
    
}




- (IBAction)clickRecomendados:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        [self.viewFavoritos setBackgroundColor:[UIColor blackColor]];
        [self.viewRecomendamos setBackgroundColor:[UIColor darkGrayColor]];
        [self.viewRecomendamos setFrame:CGRectMake(self.viewRecomendamos.frame.origin.x,
                                                self.viewRecomendamos.frame.origin.y,
                                                180,
                                                self.viewRecomendamos.frame.size.height)];
        
    }];
    
    [self lerRecomendados];
     [self.viewContainer addSubview:animation.view];
}
- (IBAction)clicksegmentControl:(id)sender {
    
    if(self.selectionView.selectedSegmentIndex == 0)
    {
        [self lerRecomendados];
        [self.viewContainer addSubview:animation.view];

	}
    
	if(self.selectionView.selectedSegmentIndex == 1)
    {
        
        NSLog(@"Tipo de login realisado mainpage click fav%@",[Globals user].loginType);
        
        if([[Globals user].loginType isEqualToString:@"facebook"])
        {
            [self ChamarFavoritos];
        }
        else if([[Globals user].loginType isEqualToString:@"guru"])
        {
            [self ChamarFavoritos];
        }
        else if (![Globals user]){
            // tenho de por esta cena no viewdidappear
            alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Para ter acesso a esta funcionalidade tem de ter login \ndeseja fazer agora?" delegate:self   cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
            //  [alert show];
            
            [self chamarLogin];
        }else{
            [self ChamarFavoritos];
        }

	}
    
}
@end
