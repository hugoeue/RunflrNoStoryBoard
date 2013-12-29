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


@interface Diarias (){
    Restaurant * restaurante;
    WebServiceSender *webser;

    MenuDoDia * menuDia;
    MenuGeral * menuG;
    
    CollectionGuru *colececaoFavoritos;
    NSMutableArray *cartoes;
}

@end

@implementation Diarias

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
   
    self.labelTitleRestaurnat.text = restaurante.name;
    self.labelLocalisacao.text = restaurante.address;
    self.labelCosinhas.text = restaurante.cuisinesResultText;
    
    self.imagemRestaurante.asynchronous = YES;
     [self.imagemRestaurante setImageWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/%@",restaurante.featuredImageString ]]];
    
    webser = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_m_rest.php" method:@"" tag:1];
    webser.delegate = self;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[Globals lang] forKey:@"lang"];
    
    NSString * numeroRestaurante = [NSString stringWithFormat:@"%d", restaurante.dbId];
   
    
    
    [dict setObject:numeroRestaurante forKey:@"rest_id"];

    [webser sendDict:dict];
    
    
    ///////////////

  
    
       
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
                    
                    
                    //rest.cuisinesResultText =[NSString stringWithFormat:@"%@\n%@",freguesia,rest.cuisinesResultText] ;
                    
                    rest.address = @"";
                    
                    rest.name = restName;
                    rest.dbId = [resId integerValue];
                    if(alturaI != [NSNull new] && [alturaI floatValue]>0)
                        rest.tamanhoImagem =  CGSizeMake([larguraI floatValue], [alturaI floatValue]);
                    
                    rest.featuredImageString = imagem;
                    //rest.name =   @"fabrica das verdadeiras queijadas da sapa";
                    
                    [cartoes addObject:rest];
                }
                
                
                
                colececaoFavoritos = [CollectionGuru new];
                //colececaoFavoritos.delegate = self;
                
                [colececaoFavoritos CarregarRestaurantes:cartoes];
                 colececaoFavoritos.view.frame = self.container.frame;
                
                [self.view addSubview:colececaoFavoritos.view];
                
                

                
                
                break;
            }
                
        }
    }else
    {
        NSLog(@"error Tanita foofa %@",error);
        
    }
    
    
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
    
    NSString *host;
    
    // 1 para adicionar e 0 para remover
    int favSend = 1;
    
    //    host = [NSString stringWithFormat:@"http://cms.citychef.pt/data/xml_up_fav.php?rest_id=%d,&user_id=%d&favSend=%d", [Globals user].dbId, [Globals restaurant].dbId, favSend];
    
    NSString *getData = [NSString stringWithFormat:@"&rest_id=%d&favSend=%d", restaurante.dbId, favSend];
    
    host = [Globals hostWithFile:@"xml_up_fav.php" andGetData:getData];
    
    NSLog(@"HOSTFAV: %@", host);
    NSURL *url = [NSURL URLWithString:host];
    
    [NSURLRequest requestWithURL:url];
    
    NSError *error;
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", str);
    if (error) {
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
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
}
 
- (IBAction)chamarMapa:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Direcções" message:@"Deseja ver as direções para este restaurante?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
    
    [alert show];
    
    }
@end
