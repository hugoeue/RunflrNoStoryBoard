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


@interface Diarias (){
    Restaurant * restaurante;
    WebServiceSender *webser;
    WebServiceSender *webser2;

    MenuDoDia * menuDia;
    MenuGeral * menuG;
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
    [self setUp];
    
    webser = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/xml_tipo_menu.php" method:@"devolve_tipo_menu_dia" tag:1];
    webser.delegate = self;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[Globals lang] forKey:@"lang"];
    
    NSString * numeroRestaurante = [NSString stringWithFormat:@"%d", restaurante.dbId];
    NSString * numeroTipo = [NSString stringWithFormat:@"%d", 1];
    
    
    [dict setObject:numeroRestaurante forKey:@"rest_id"];
    [dict setObject:numeroTipo forKey:@"tipo_id"];

    [webser sendDict:dict];
    
    
    webser2 = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/xml_menu_dia.php" method:@"devolve_tipo_menu_dia" tag:2];
    webser2.delegate = self;
    
    [dict setObject:[Globals lang] forKey:@"lang"];
    [dict setObject:numeroRestaurante forKey:@"rest_id"];
    [dict setObject:numeroTipo forKey:@"tipo_id"];
    
    [webser2 sendDict:dict];
    
    
    ///////////////
    
    [self loadMenu];
  
    [self changeFont:self.view];
    
    self.labelLocalisacao.text=restaurante.description;
    
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

- (void)loadMenu
{

    MenuParser *menuParser = [[MenuParser alloc] initXMLParser];
    
    //  NSString *hostM = [NSString stringWithFormat:@"http://cms.citychef.pt/data/xml_menu.php?rest_id=%d", [Globals restaurantId]];
    
    NSString *getDataM = [NSString stringWithFormat:@"&rest_id=%d", restaurante.dbId];
    NSString *hostM = [Globals hostWithFile:@"xml_menu.php" andGetData:getDataM];
    
    NSURL *urlM = [[NSURL alloc] initWithString: hostM];
    NSXMLParser *nsXmlParserM = [[NSXMLParser alloc] initWithContentsOfURL: urlM];
    [nsXmlParserM setDelegate:menuParser];
    
    //[nsXmlParserM parse];
    
    
    BOOL success = [nsXmlParserM parse];
    
    if (success) {
        [self performSelectorOnMainThread:@selector(startUpContainers) withObject:nil waitUntilDone:NO];
        
        
        
         for (Menu * vitie in [Globals days]) {
             NSLog(@"dias prato: %@ ",vitie.dish);
             NSLog(@"dias descriçao: %@ ",vitie.description);
             NSLog(@"dias extra: %@ ",vitie.extra);
             NSLog(@"dias tipo menu: %@ ",vitie.tipo);
             NSLog(@"dias tipo menu: %@ ",vitie.tipod);
             
         }
        
        for (Menu * vitie in [Globals choices]) {
            NSLog(@"escolhas name: %@ ",vitie.dish);
        }
        
        
    } else {
        [self performSelectorOnMainThread:@selector(noConnect) withObject:nil waitUntilDone:NO];
    }
}



- (void)startUpContainers{
   
    if(!menuDia){
        menuDia = [MenuDoDia new];
        [self.container addSubview:menuDia.view];
    }

    
}

-(void)noConnect
{

}

-(void)setUp{
    self.labelTitleRestaurnat.text = restaurante.name;
}

-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado da tania xml_tipo_menu.php  %@", result.description);
                
                NSMutableArray * array = [NSMutableArray new];
                
                for (NSMutableDictionary *dick in [result objectForKey:@"res"]) {
                    Tipo * t = [Tipo new];
                    t.tipoName =  [dick objectForKey:@"description"];
                    t.tipoId =  [dick objectForKey:@"id"];
                    [array addObject:t];
                }
                
                menuG = [MenuGeral new];
                menuG.dataSource = array;
                //menuG.view.frame = self.container.frame;
                [menuG.tableView reloadData];
                break;
            }
            case 2:
            {
                NSLog(@"resultado da tania xml_menu_dia.php  %@", result.description);

                break;
            }
                
        }
    }else
    {
        NSLog(@"error paulo %@",error);
        
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
 
@end
