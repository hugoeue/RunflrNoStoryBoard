//
//  Diarias.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 04/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "Diarias.h"
#import "WebServiceSender.h"
#import "DayParser.h"
#import "Menu.h"
#import "MenuParser.h"
#import "MenuDoDia.h"
#import "MenuGeral.h"
#import "Tipo.h"
#import <MapKit/MapKit.h>
#import "CollectionGuru.h"
#import "Login.h"
#import "Menus.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface Diarias (){
    Restaurant * restaurante;
    WebServiceSender *webser;
    WebServiceSender *addRemoveFav;
    WebServiceSender *verifica;

    MenuDoDia * menuDia;
    MenuGeral * menuG;
    
    CollectionGuru *colececaoFavoritos;
    NSMutableArray *cartoes;
}

@end

@implementation Diarias

@synthesize locationManager;

-(void)dealloc{
    NSLog(@"objecto foi deallocado");
    
//    WebServiceSender *webser;
//    WebServiceSender *addRemoveFav;
//    WebServiceSender *verifica;
    
    if(webser)
        [webser cancel];
    if ( addRemoveFav )
        [addRemoveFav cancel];
    if (verifica)
        [verifica cancel];
    
    webser = nil;
    addRemoveFav = nil;
    verifica = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) moveAllSubviewsDown{
    float barHeight = -40.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    


    
    self.labelDistancia.text = [self imprimirDistancia:restaurante];
   
    self.labelTitleRestaurnat.text = restaurante.name;
    self.labelLocalisacao.text = [NSString stringWithFormat:@"%@ - %@",restaurante.city ,restaurante.address];
    self.labelCosinhas.text = restaurante.cuisinesResultText;
    
    self.imagemRestaurante.asynchronous = YES;
    

   // [self verificaSeguir];
    
       
}



-(void)viewDidAppear:(BOOL)animated
{
    [self.imagemRestaurante setImageWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/%@",restaurante.featuredImageString ]]];
    if(webser)
        [webser cancel];
    webser = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_m_rest.php" method:@"" tag:1];
    webser.delegate = self;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[Globals lang] forKey:@"lang"];
    
    NSString * numeroRestaurante = [NSString stringWithFormat:@"%d", restaurante.dbId];
    
    
    
    [dict setObject:numeroRestaurante forKey:@"rest_id"];
    
    [webser sendDict:dict];
    
    
    ///////////////
    
    NSLog(@"Tipo de login realisado main page did appear %@",[Globals user].loginType);
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
        [self verificaSeguir];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
        [self verificaSeguir];
    }else{
        
    }

}

-(void)verificaSeguir
{

    
    
    verifica = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_fav_nfav.php" method:@"" tag:3];
    verifica.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    //
    //        $body['lang'];
    //        $body['nomeparte'];
    
    
    
    NSString * userId =[NSString stringWithFormat:@"%d",[Globals user].dbId];
    NSString * faceID =[NSString stringWithFormat:@"%@",[Globals user].faceId];
    NSString * restID = [NSString stringWithFormat:@"%d",restaurante.dbId];
    
    [dict setObject:userId forKey:@"user_id"];
    [dict setObject:faceID forKey:@"face_id"];
    [dict setObject:restID forKey:@"rest_id"];
    
    [verifica sendDict:dict];

    
}





-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado da tania para todos os cartoes  %@", result.description);
                
//                res =     (
//                           {
//                               descricao = "O melhor prato de inverno do nosso chefe";
//                               destaque = 0;
//                               "dia_id" = 4;
//                               "height_i" = "";
//                               imagem = "";
//                               "menu_esp_id" = "";
//                               nome = "Recomenda\U00e7\U00e3o do chefe";
//                               "nome_cat" = "";
//                               "rest_id" = 4;
//                               tipo = "menu_dia";
//                               "width_i" = "";
//                           },

                cartoes = [NSMutableArray new];
                
                for(NSMutableDictionary * dict in [result objectForKey:@"res"]){
                    Restaurant * rest = [Restaurant new];
                    
                    
                    //NSString *dist = [dict objectForKey:@"dist"];
                    NSString * restName = [dict objectForKey:@"nome"];
                    NSString * resId = [dict objectForKey:@"rest_id"];
                    NSString * imagem = [dict objectForKey:@"imagem"];
                    NSString * alturaI = [dict objectForKey:@"height_i"];
                    NSString * larguraI = [dict objectForKey:@"width_i"];
                    
                    
                    
                    
                    
                    rest.cuisinesResultText = [dict objectForKey:@"descricao"];
                    rest.parish = [dict objectForKey:@"tipo"];
                    rest.bestChoices = [dict objectForKey:@"nome_cat"];
                    rest.chef = [dict objectForKey:@"menu_esp_id"];
                    rest.featuredImageString = [dict objectForKey:@"imagem"];
                    
                    rest.address = @"";
                    
                    rest.name = restName;
                    rest.dbId = [resId integerValue];
                    if(alturaI != [NSNull new] && [alturaI floatValue]>0)
                        rest.tamanhoImagem =  CGSizeMake([larguraI floatValue], [alturaI floatValue]);
                    
                    rest.featuredImageString = imagem;
                    //rest.name =   @"fabrica das verdadeiras queijadas da sapa";
                    
                    [cartoes addObject:rest];
                }
                
                
                if (!colececaoFavoritos){
               
                    colececaoFavoritos = [CollectionGuru new];
                colececaoFavoritos.delegate = self;
                    colececaoFavoritos.mostrarGPS = NO;
                
                 colececaoFavoritos.view.frame = self.container.frame;
                
                [self.view addSubview:colececaoFavoritos.view];
                }
                
                [colececaoFavoritos CarregarRestaurantes:cartoes];
                [colececaoFavoritos.collectionView reloadData];
                
                break;
            }
                case 2:
            {
                NSLog(@"resultado adicionar favorito  %@", result.description);
                //res = "inserido com sucesso";
                
                if ([[result objectForKey:@"res"] isEqualToString:@"inserido com sucesso"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"restaurante adicionado a lista de favoritos com sucesso" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                    [self.buttonSeguir setTitle:@"Remover dos favoritos" forState:UIControlStateNormal];
                    restaurante.fav = 0;
                    [self.buttonSeguir setEnabled:YES];
                    
                }
                
                if ([[result objectForKey:@"res"] isEqualToString:@"eliminado com sucesso"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"restaurante foi removido da lista de favoritos com sucesso" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert show];
                    [self.buttonSeguir setTitle:@"Adicionar favorito" forState:UIControlStateNormal];
                    restaurante.fav = 1;
                    [self.buttonSeguir setEnabled:YES];
                }
                
                // tenho de fazer cenas com os botoes
                //res = "eliminado com sucesso";
                
                break;
            }
            case 3:
            {
                NSLog(@"resultado e seguido  %@", result.description);
                //res = "inserido com sucesso";
                
                if ([[result objectForKey:@"resp"] isEqualToString:@"nao"]) {
                    [self.buttonSeguir setTitle:@"Adicionar favorito" forState:UIControlStateNormal];
                    restaurante.fav = 1;
                }else
                {
                    [self.buttonSeguir setTitle:@"Remover dos favoritos" forState:UIControlStateNormal];
                    restaurante.fav = 0;
                }
                
                break;
            }
                
        }
    }else
    {
        NSLog(@"error Tanita foofa %@",error);
        
    }
    
    
}

-(NSString *)imprimirDistancia:(Restaurant *)rest
{
 
        
        if (locationManager.location.coordinate.latitude!=0) {
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
            return @"Ative GPS";
        }
    
}


-(void)chamarRestaurante:(Restaurant *)rest
{
    // aqui nao posso chamar restaurantes mas sim outras coisas
    NSLog(@"chamar menu %@", rest.name);
 
    Menus * menu = [Menus new];
   

    menu.restaurante = rest;
    menu.restaurante.dbId = restaurante.dbId;
    
    [self.navigationController pushViewController:menu animated:YES];
}


-(void)loadRestaurant:(Restaurant *)rest
{
    restaurante = rest;
}

- (IBAction)selecteSegControl:(id)sender {
    if(self.segControl.selectedSegmentIndex ==1){
        // adicionar o outro
        [self.container addSubview:menuG.view];
        [menuDia.view removeFromSuperview];
    }else{
        
        [menuG.view removeFromSuperview];
        [self.container addSubview: menuDia.view];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickAddFavorito:(id)sender {
    [self.buttonSeguir setEnabled:NO];
//    json_cratefav.php
//    serve para apagar ou criar favoritos
//    $body['user_id'];
//	$body['face_id'];
//	$body['favSend'];//se for 1 é para criar se for zero é para apagar
//    $body['rest_id'];
    addRemoveFav = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_cratefav.php" method:@"" tag:2];
    addRemoveFav.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    //
    //        $body['lang'];
    //        $body['nomeparte'];
    
    
    
    NSString * userId =[NSString stringWithFormat:@"%d",[Globals user].dbId];
    NSString * faceID =[NSString stringWithFormat:@"%@",[Globals user].faceId];
    NSString * add =[NSString stringWithFormat:@"%d",restaurante.fav];
    NSString * restID = [NSString stringWithFormat:@"%d",restaurante.dbId];
    
    [dict setObject:userId forKey:@"user_id"];
    [dict setObject:faceID forKey:@"face_id"];
    [dict setObject:add forKey:@"favSend"];
    [dict setObject:restID forKey:@"rest_id"];
    
    
    
    if([[Globals user].loginType isEqualToString:@"facebook"])
    {
       [addRemoveFav sendDict:dict];
    }
    else if([[Globals user].loginType isEqualToString:@"guru"])
    {
        [addRemoveFav sendDict:dict];
    }else{
        
       // [addRemoveFav sendDict:dict];
       // tenho de lançar uma popup a perguntar se quer fazer login ao utilisador
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Para ter acesso a esta funcionalidade tem de ter login \ndeseja fazer agora?" delegate:self   cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
        alert.tag = 2 ;
        
        [alert show];

    }

    
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag ==1) {
    
    if(buttonIndex == 0)//OK button pressed
    {
        //do something
    }
    else if(buttonIndex == 1)//Annul button pressed.
    {
        CLLocationCoordinate2D loc;
        loc.latitude = restaurante.lat ;
        loc.longitude = restaurante.lon;
        
        MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: loc addressDictionary: nil];
        MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
        destination.name =restaurante.name;
        NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
        NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 MKLaunchOptionsDirectionsModeDriving,
                                 MKLaunchOptionsDirectionsModeKey, nil];
        [MKMapItem openMapsWithItems: items launchOptions: options];

    }
        
    }else if(alertView.tag == 2)
    {
        if(buttonIndex == 0)//OK button pressed
        {
            //do something
        }
        else if(buttonIndex == 1)//Annul button pressed.
        {

        [self chamarLogin];
        }

    }
}

-(void)chamarLogin{
    Login *log = [Login new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:log];
    
    //[self.revealSideViewController presentViewController:nav animated:YES completion:nil];
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (IBAction)chamarMapa:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Direcções" message:@"Deseja ver as direções para este restaurante?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
    alert.tag = 1 ;
    
    [alert show];
    
    }
- (IBAction)clickLigar:(id)sender {
    NSString *phoneNumber =[NSString stringWithFormat:@"%d",restaurante.phone]; // dynamically assigned
    NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    [[UIApplication sharedApplication] openURL:phoneURL];
    NSLog(@"ligar para numero %@",phoneNumber);
}
@end
