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
#import "SemDados.h"
#import "MapViewController.h"
// tem de sair o paperfold
#import "PPRevealSideViewController.h"
//#import "DemoRootViewController.h"
#import "AnimationController.h"
#import "QueroMais.h"
#import "AsyncImageView.h"



#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface Diarias (){
    Restaurant * restaurante;
    WebServiceSender *webser;
    WebServiceSender *addRemoveFav;
    WebServiceSender *verifica;
    WebServiceSender *mudarLingua;
    WebServiceSender *receberFotos;

    MenuDoDia * menuDia;
    MenuGeral * menuG;
    
    CollectionGuru *colececaoFavoritos;
    NSMutableArray *cartoes;
    
    SemDados *vazio;
    
    BOOL diaria;
    BOOL especial;
    BOOL ementa;
    
    NSString *emailTitle;
    // Email Content
    NSString *messageBody;
    // To address
    NSArray *toRecipents;
    
    NSString *emailTitleCart;
    // Email Content
    NSString *messageBodyCart;
    // To address
    NSArray *toRecipentsCart;
    
    UIAlertView * alertCartao;
    
  
    
    AnimationController * animation;
    
    NSMutableArray * siglas;
    
    
    NSString *linguaDoCartao;
    
    // posicao inicial da imagem
    CGFloat posicaoImg;
    CGFloat isIOS7;
    
    BOOL openCarousel;
    
    UIButton *settingsView1 ;
    
}

@end

@implementation Diarias

@synthesize locationManager,items,carousel;


-(void)receberFotosJson
{
    receberFotos = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_galeria_rest.php" method:@"" tag:5];
    
    receberFotos.delegate = self;
    
    NSString * restauranteId = [NSString stringWithFormat:@"%d",restaurante.dbId];
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [dict setObject:[Globals lang] forKey:@"lang"];
    [dict setObject:restauranteId forKey:@"rest_id"];
    
    
    [receberFotos sendDict:dict];
}

-(void)popUpMudarLingua
{
    mudarLingua = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_popup_troca_lingua_cartao.php" method:@"" tag:4];
    
    mudarLingua.delegate = self;
    
    NSString * restauranteId = [NSString stringWithFormat:@"%d",restaurante.dbId];
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [dict setObject:[Globals lang] forKey:@"lang"];
    [dict setObject:restauranteId forKey:@"rest_id"];
    
    
    [mudarLingua sendDict:dict];
    
}

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
    if (mudarLingua)
        [mudarLingua cancel];
    if (receberFotos)
        [receberFotos cancel];
    
    
    receberFotos= nil;
    mudarLingua = nil;
    
    webser = nil;
    addRemoveFav = nil;
    verifica = nil;
    
   // [[DemoRootViewController getInstance] apagarMapa];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)setUp
{
    //set up data

    self.items = [NSMutableArray array];
    [self.items addObject:restaurante.featuredImageString];
    
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
    [self setSeguir:restaurante.isUserFav];
    
    if (![Utils isiOS7]) {
        isIOS7 = -40;
    }else
    {
        isIOS7 = 0;
    }
    
    
    animation = [AnimationController new];
    
    animation.view.frame = CGRectMake(0, 0, 320,self.container.frame.size.height );
    [animation.viewFundo setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1]];
    
    [self.container addSubview:animation.view];
    

    // se o restaurante estiver em destaque fica como vem do servidor
    // senão vamos por lixo para preencher o que falta

    
    self.labelDistancia.text = [self imprimirDistancia:restaurante];
   
    self.labelTitleRestaurnat.text = restaurante.name;
    self.labelLocalisacao.text = [NSString stringWithFormat:@"%@ - %@",restaurante.city ,restaurante.address];
    self.labelCosinhas.text = restaurante.cuisinesResultText;
    
    self.imagemRestaurante.asynchronous = YES;
    
    
    [self.buttonLigar setTitle:[Language textForIndex:@"Ligar"] forState:UIControlStateNormal];

   // [self verificaSeguir];
    
    [self carregarCartoes:@""];
    
    posicaoImg = self.viewImagemRest.frame.origin.y;
    
    
    //configure carousel
    carousel.type = iCarouselTypeLinear;

    [self setUp];
    [self receberFotosJson];
    
    
    
    
    
    // tenho de criar todos os botoes programaticamente porque as imagens foram dadas com os tamanho errados
    
    // tenho de criar a porcaria de uma label para poder dar espaçamento entre os botoes :(
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    label.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *divider = [[UIBarButtonItem alloc] initWithCustomView:label];
    label.text = @"";
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5, 44)];
    label1.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *divider1 = [[UIBarButtonItem alloc] initWithCustomView:label1];
    label1.text = @"";

    
    // para as linguas
    UIButton *settingsView0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [settingsView0 addTarget:self action:@selector(clickDiarias:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView0 setBackgroundImage:[UIImage imageNamed:@"b_idioma.png"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonLinguas = [[UIBarButtonItem alloc] initWithCustomView:settingsView0];
    
    
    // para os favoritos
    // ainda tenho de fazer um if para verificar se este restuarante é favorito ou nao
    
    settingsView1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [settingsView1 addTarget:self action:@selector(clickAddFavorito:) forControlEvents:UIControlEventTouchUpInside];
    
    if(restaurante.isUserFav)
        [settingsView1 setBackgroundImage:[UIImage imageNamed:@"b_favoritos_acionado.png"] forState:UIControlStateNormal];
    else
        [settingsView1 setBackgroundImage:[UIImage imageNamed:@"b_favoritos.png"] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *buttonFavoritos = [[UIBarButtonItem alloc] initWithCustomView:settingsView1];
    
    
    
    // para Fazer chamada
    UIButton *settingsView2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [settingsView2 addTarget:self action:@selector(clickLigar:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView2 setBackgroundImage:[UIImage imageNamed:@"b_telefonar.png"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonChamada = [[UIBarButtonItem alloc] initWithCustomView:settingsView2];
    
    // para paratinhar que ainda nao existia aqte agora
    UIButton *settingsView3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [settingsView3 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [settingsView3 setBackgroundImage:[UIImage imageNamed:@"b_partilhar.png"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonPartinhar = [[UIBarButtonItem alloc] initWithCustomView:settingsView3];
    
    
    // para o quero mais
    UIButton *settingsView4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [settingsView4 addTarget:self action:@selector(abrirSelectorTania)  forControlEvents:UIControlEventTouchUpInside];
    [settingsView4 setBackgroundImage:[UIImage imageNamed:@"b_mais.png"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonMais = [[UIBarButtonItem alloc] initWithCustomView:settingsView4];

    
    
    
    NSArray * array =[NSArray arrayWithObjects:divider1,buttonLinguas, divider ,buttonFavoritos ,divider ,buttonChamada, divider ,buttonPartinhar,divider,buttonMais, nil];
    
    
    
    
    UIImage * image = [UIImage imageNamed:@"Base_Baixo_Top-Line.png"];
    
    [self.navigationController.toolbar setBackgroundImage:image forToolbarPosition:0 barMetrics:UIBarMetricsDefault ];
    
   // [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.toolbarItems = array;
    
 
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
    self.navigationController.navigationBarHidden = NO;
}


-(void)carregarCartoes:(NSString *)lingua
{
    linguaDoCartao = lingua;
    
    if(webser)
        [webser cancel];
    webser = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_m_rest.php" method:@"" tag:1];
    webser.delegate = self;
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:lingua forKey:@"lang"];
    
    NSString * numeroRestaurante = [NSString stringWithFormat:@"%d", restaurante.dbId];
    
    
    
    [dict setObject:numeroRestaurante forKey:@"rest_id"];
    
    [webser sendDict:dict];

}


-(void)viewDidAppear:(BOOL)animated
{
    [self.imagemRestaurante setImageWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/%@",restaurante.featuredImageString ]]];
    
    //[self carregarCartoes:@"ott"];
    
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
                
                [animation.view removeFromSuperview];
                 diaria = NO;
                 especial = NO ;
                 ementa = NO;
               
                
                if(!cartoes)
                     cartoes = [NSMutableArray new];
                
//                [colececaoFavoritos removeFromParentViewController];
                  [cartoes removeAllObjects];
//                [vazio removeFromParentViewController];
                
               /*
                emailTitleCart = [[result objectForKey:@"msgdummy"] objectForKey:@"assunto"];
                // Email Content
                messageBodyCart = [[result objectForKey:@"msgdummy"] objectForKey:@"message"];
                // To address
                toRecipentsCart = [NSArray arrayWithObject:[[result objectForKey:@"msgdummy"] objectForKey:@"email"]];
               
                
               
             

                
          //char *nameChars =(char *) [[[result objectForKey:@"msgdummy"] objectForKey:@"msgbox"] UTF8String];
                
                 //NSString* str2 = [NSString stringWithUTF8String:nameChars];
                
                NSString *utf8string = [[result objectForKey:@"msgdummy"] objectForKey:@"msgbox"];
             
                
     
                
                alertCartao = [[UIAlertView alloc] initWithTitle:[[result objectForKey:@"msgdummy"] objectForKey:@"titulo"] message:utf8string  delegate:self cancelButtonTitle:[[result objectForKey:@"msgdummy"] objectForKey:@"butaoc"] otherButtonTitles:[[result objectForKey:@"msgdummy"] objectForKey:@"butao"], nil];
                alertCartao.tag = 4;
                 */
                
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
                    rest.dummy = [dict objectForKey:@"dummy"];
                    rest.pai = [dict objectForKey:@"pai_id"];
                    
                    rest.city = @"";
                    
                    rest.name = restName;
                    rest.dbId = [resId integerValue];
                    if(alturaI != [NSNull new] && [alturaI floatValue]>0)
                        rest.tamanhoImagem =  CGSizeMake([larguraI floatValue], [alturaI floatValue]);
                    
                    rest.featuredImageString = imagem;
                    //rest.name =   @"fabrica das verdadeiras queijadas da sapa";
                    if ([[dict objectForKey:@"tipo"] isEqualToString:@"menu_especial"]) {
                        especial = YES;
                    }
                    if ([[dict objectForKey:@"tipo"] isEqualToString:@"menu_ementa"]) {
                        ementa = YES;
                    }
                    if ([[dict objectForKey:@"tipo"] isEqualToString:@"menu_dia"]) {
                        diaria = YES;
                    }
                   
                    [cartoes addObject:rest];
                }
                
                
                if(cartoes.count != 0)
                {
                    //[colececaoFavoritos removeFromParentViewController];
                    [colececaoFavoritos.view removeFromSuperview];
                    colececaoFavoritos = nil;
                    
                    if (!colececaoFavoritos){
               
                        colececaoFavoritos = [CollectionGuru new];
                        colececaoFavoritos.collectionView.backgroundColor = [UIColor clearColor];
                        colececaoFavoritos.view.backgroundColor = [UIColor clearColor];
                        colececaoFavoritos.collectionView.clipsToBounds = YES;
                        colececaoFavoritos.scroolDelegate = self;
                        colececaoFavoritos.delegate = self;
                        colececaoFavoritos.mostrarGPS = NO;
                
                        colececaoFavoritos.view.frame = self.container.frame;
                        
                
                        [self.view addSubview:colececaoFavoritos.view];
                    }
                
                    
                    
                    // quando faltam cartoes ele faz coisas aqui
                    
                    /*
                    if (!restaurante.destaque)
                    {
                        if (!diaria)
                        {
                            Restaurant * restDummy = [Restaurant new];
                            restDummy.name = [Language textForIndex:@"menu_dia"];
                            restDummy.dbId = -1;
                            restDummy.cuisinesResultText = @"descriçao Diaria dummy";
                            restDummy.city = @"";
                            [cartoes addObject:restDummy];

                        }
                        if (!ementa)
                        {
                            Restaurant * restDummy = [Restaurant new];
                            restDummy.name = [Language textForIndex:@"menu_ementa"];
                            restDummy.dbId = -2;
                            restDummy.cuisinesResultText = @"descriçao Ementa dummy";
                            restDummy.city = @"";
                            [cartoes addObject:restDummy];
                        }
                        if (!especial)
                        {
                            Restaurant * restDummy = [Restaurant new];
                            restDummy.name = [Language textForIndex:@"menu_especial"];
                            restDummy.dbId = -3;
                            restDummy.cuisinesResultText = @"descriçao Especial dummy";
                            restDummy.city = @"";
                            [cartoes addObject:restDummy];
                        }

                    }
                    */
                 
                    [colececaoFavoritos CarregarRestaurantes:cartoes];
                    [colececaoFavoritos.collectionView reloadData];
                    
                    self.viewBotoes.frame = CGRectMake(0, -160, 320, 44);
                    [colececaoFavoritos.collectionView setContentInset:UIEdgeInsetsMake(265, 0, 50, 0)];
                    [colececaoFavoritos.collectionView addSubview: self.viewBotoes];
                    
                }else
                {
                    
                    [colececaoFavoritos removeFromParentViewController];
                    [colececaoFavoritos.collectionView removeFromSuperview];
                    colececaoFavoritos = nil;

                    
                    
                    
                    vazio = [SemDados new];
                    vazio.view.frame = CGRectMake(0,
                                                  38,
                                                  self.container.frame.size.width,
                                                  self.container.frame.size.height-38);
                    [self.container addSubview:vazio.view];
                    vazio.imagem.image = [UIImage imageNamed:@"cry-50.png"];
                    vazio.labelTitulo.text = [Language textForIndex:@"Procurar_menu_clique_mostre_interesse_titulo"];
                    vazio.labelMenssagem.text = @"";
                    vazio.labelDescricao.text =  [Language textForIndex:@"Procurar_menu_clique_mostre_interesse_descr"];
                    
                    self.viewBotoes.frame = CGRectMake(0, 0, 320, 44);
                    [self.container addSubview:self.viewBotoes];
                    
                                    }
                
               // self.viewButoes.frame = CGRectMake(0, 0, 320, 44);
                //self.viewButoes.frame = CGRectMake(0, -44, 320, 44);
               
                
                break;
            }
                case 2:
            {
                NSLog(@"resultado adicionar favorito  %@", result.description);
                //res = "inserido com sucesso";
                
                if ([[[result objectForKey:@"res"] objectForKey:@"envio"] isEqualToString:@"inserido com sucesso"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[[result objectForKey:@"res"] objectForKey:@"titulo"] message:[[result objectForKey:@"res"] objectForKey:@"msg"] delegate:nil cancelButtonTitle:[[result objectForKey:@"res"] objectForKey:@"botao"] otherButtonTitles:nil, nil];
                    [alert show];
                    [self.buttonSeguir setTitle:[Language textForIndex:@"Remover_favoritos"] forState:UIControlStateNormal];
                    restaurante.fav = 0;
                    [self.buttonSeguir setEnabled:YES];
                    
                    
                    // agora para a tollbar
                    [settingsView1 setBackgroundImage:[UIImage imageNamed:@"b_favoritos_acionado.png"] forState:UIControlStateNormal];

                    
                }
                
                if ([[[result objectForKey:@"res"] objectForKey:@"envio"] isEqualToString:@"demasiados utilizadores"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[[result objectForKey:@"res"] objectForKey:@"titulo"] message:[[result objectForKey:@"res"] objectForKey:@"msg"] delegate:self cancelButtonTitle:[[result objectForKey:@"res"] objectForKey:@"botaoc"] otherButtonTitles:[[result objectForKey:@"res"] objectForKey:@"botao"], nil];
                    alert.tag = 3;
                    
                    // Email Subject
                    emailTitle = [[result objectForKey:@"res"] objectForKey:@"assunto"];
                    // Email Content
                    messageBody = [[result objectForKey:@"res"] objectForKey:@"message"];
                    // To address
                    toRecipents = [NSArray arrayWithObject:[[result objectForKey:@"res"] objectForKey:@"email"]];
                    
                    [alert show];
                    [self.buttonSeguir setTitle:[Language textForIndex:@"Add_favoritos"] forState:UIControlStateNormal];
                    restaurante.fav = 1;
                    [self.buttonSeguir setEnabled:YES];
                    
                    [settingsView1 setBackgroundImage:[UIImage imageNamed:@"b_favoritos.png"] forState:UIControlStateNormal];
                    
                }
                
                if ([[[result objectForKey:@"res"] objectForKey:@"envio"] isEqualToString:@"eliminado com sucesso"]) {
                   UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[[result objectForKey:@"res"] objectForKey:@"titulo"] message:[[result objectForKey:@"res"] objectForKey:@"msg"] delegate:nil cancelButtonTitle:[[result objectForKey:@"res"] objectForKey:@"botao"] otherButtonTitles:nil, nil];                    [alert show];
                    [self.buttonSeguir setTitle:[Language textForIndex:@"Add_favoritos"] forState:UIControlStateNormal];
                    restaurante.fav = 1;
                    [self.buttonSeguir setEnabled:YES];
                    
                    [settingsView1 setBackgroundImage:[UIImage imageNamed:@"b_favoritos.png"] forState:UIControlStateNormal];
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
                    [self.buttonSeguir setTitle:[Language textForIndex:@"Add_favoritos"] forState:UIControlStateNormal];
                    restaurante.fav = 1;
                }else
                {
                    [self.buttonSeguir setTitle:[Language textForIndex:@"Remover_favoritos"] forState:UIControlStateNormal];
                    restaurante.fav = 0;
                }
                
                break;
            }
            case 4:
            {
                NSLog(@"resultado das linguas para popup %@", result.description);
               
                NSMutableArray * arrayLinguas = [NSMutableArray new];
                
                siglas = [NSMutableArray new];
                [siglas removeAllObjects];
                
                for (NSMutableDictionary * lingua in [result objectForKey:@"res"]) {
                    
                    [arrayLinguas addObject:[lingua objectForKey:@"lingua"]];
                    [siglas addObject:[lingua objectForKey:@"sigla"]];
                }
                
                
                
                //[alert show];
                
                NSString * titulo;
                if (siglas.count <=1) {
                    titulo = @"Sem traduçoes";
                    [arrayLinguas removeAllObjects];
                }
                else
                {
                    titulo = @"Escolha uma lingua";
                }
                
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:titulo
                                                                         delegate:self
                                                                cancelButtonTitle:nil
                                                           destructiveButtonTitle:nil
                                                                otherButtonTitles:nil];
                
                
                actionSheet.tag = 1;
                // ObjC Fast Enumeration
                for (NSString *title in arrayLinguas) {
                    [actionSheet addButtonWithTitle:title];
                }
                
                [actionSheet addButtonWithTitle:[Language textForIndex:@"Cancel_imagem"]];
                actionSheet.cancelButtonIndex = [arrayLinguas count];
                
                [actionSheet showInView:self.view];
                
                break;
            }
            case 5:
            {
                NSLog(@"resultado das fotos para a galeria %@", result.description);
            
                //items = [NSMutableArray new];
                
                for (NSMutableDictionary * dict in [result objectForKey:@"rest"]) {
                    
                    [items addObject:[dict objectForKey:@"foto"]];

                }
                
                [carousel reloadData];
                
                break;
            }


                
        }
    }else
    {
        NSLog(@"error Tanita foofa %@",error);
    }
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clicou no indice %d", buttonIndex);
    
    if (actionSheet.tag==1) {
        if (buttonIndex != [siglas count]) {
            [self carregarCartoes:[siglas objectAtIndex:buttonIndex]];
            
        }
    }
    else if (actionSheet.tag==2)
    {
        if (buttonIndex == 1) {
            [self clickAddFavorito:self];
        }else if( buttonIndex == 0)
        {
            [self clickLigar:self];
        }
        else if (buttonIndex == 2) {
            [self abrirSelectorTania];
        }
        
            
    }
   
}

-(void)setSeguir:(BOOL) seguir
{
    if (!seguir) {
        [self.buttonSeguir setTitle:[Language textForIndex:@"Add_favoritos"] forState:UIControlStateNormal];
        restaurante.fav = 1;
    }else
    {
        [self.buttonSeguir setTitle:[Language textForIndex:@"Remover_favoritos"] forState:UIControlStateNormal];
        restaurante.fav = 0;
    }

}

-(NSString *)imprimirDistancia:(Restaurant *)rest
{

    
        if (locationManager.location.coordinate.latitude!=0) {
            CLLocation * localRest = [[CLLocation alloc] initWithLatitude:rest.lat longitude:rest.lon];
            CLLocation * localActual = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
            
            CLLocationDistance distance = [localActual distanceFromLocation:localRest];
            //NSLog(@"distancia calculada  %f de %@", distance,rest.name);
            
            if(distance>1000*100)
                return [NSString stringWithFormat:@"%.0f Km",distance/1000];
            if(distance>1000*10)
                return [NSString stringWithFormat:@"%.1f Km",distance/1000];
            if (distance>1000) {
                return [NSString stringWithFormat:@"%.1f Km",distance/1000];
            }
            
            
            
            return [NSString stringWithFormat:@"%.0f m",distance];
        }else
        {
            return @"Ative geolocalização";
        }    
}



-(void)chamarRestaurante:(Restaurant *)rest
{
    // aqui nao posso chamar restaurantes mas sim outras coisas
    NSLog(@"chamar menu %@", rest.name);
 
    Menus * menu = [Menus new];
   
    if(rest.dbId < 0)
    {
        if (rest.dbId == -1) {
            messageBodyCart = [NSString stringWithFormat:@"%@ Diaria",messageBodyCart ];
        }
        if (rest.dbId == -2) {
            messageBodyCart = [NSString stringWithFormat:@"%@ Ementa",messageBodyCart ];
        }
        if (rest.dbId == -3) {
            messageBodyCart = [NSString stringWithFormat:@"%@ Especial",messageBodyCart ];
        }
        
        [alertCartao show];
    }else
    {
        menu.verdadeiroRestaurante = restaurante;
        menu.restaurante = rest;
        menu.restaurante.dbId = restaurante.dbId;
    
        menu.linguaCartao = linguaDoCartao;
    
        [self.navigationController pushViewController:menu animated:YES];
    }
}


-(void)loadRestaurant:(Restaurant *)rest
{
    restaurante = rest;
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

    

    
    addRemoveFav = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_createfav2.php" method:@"" tag:2];
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
    [dict setObject:[Globals lang] forKey:@"lang"];
    [dict setObject:restaurante.name forKey:@"rest_nome"];
    [dict setObject:restaurante.city forKey:@"rest_cidade"];
    //[dict setObject:[Globals user].email forKey:@"email"];
    
    
    
    if([Globals user].faceId)
    {
        [dict setObject: [Globals user].faceId forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", 0] forKey:@"user_id"];
    }else
    {
        [dict setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"face_id"];
        [dict setObject: [NSString stringWithFormat:@"%d", [Globals user].dbId] forKey:@"user_id"];
    }
    
    
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
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Para ter acesso a esta funcionalidade tem de ter login \ndeseja fazer agora? APT" delegate:self   cancelButtonTitle:[Language textForIndex:@"Nao"] otherButtonTitles:[Language textForIndex:@"Sim"], nil];
        alert.tag = 2 ;
        
      //  [alert show];
        
        [self chamarLogin];
    }

    
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag ==1) {

    if(buttonIndex == 0)//OK button pressed
    {
        //do something
    }
   if(buttonIndex == 1)//Annul button pressed.
    {

        // saiu o papperfold
        //[[DemoRootViewController getInstance] chamarMapa:restaurante];

    }
        
    }
    if(alertView.tag == 2)
    {
        if(buttonIndex == 0)//OK button pressed
        {
            [self.buttonSeguir setEnabled:YES];
        }
        else if(buttonIndex == 1)//Annul button pressed.
        {
            [self chamarLogin];
        }

    }
    if(alertView.tag == 3)
    {
        if(buttonIndex == 1)//OK button pressed
        {
             [self chamarEmail];
             [self.buttonSeguir setEnabled:YES];
        }
        
        
    }
    if(alertView.tag == 4)
    {
        if(buttonIndex == 1)//OK button pressed
        {
            [self chamarEmailCart];

        }
    }
    if(alertView.tag == 5)
    {
        if(buttonIndex == 1)//OK button pressed
        {
            [self fazerChamada];
            
        }
    }

}



-(void)chamarEmail
{
   
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

-(void)chamarEmailCart
{
    
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitleCart];
    [mc setMessageBody:messageBodyCart isHTML:NO];
    [mc setToRecipients:toRecipentsCart];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}


-(void)abrirSelectorTania
{
    QueroMais * mais = [[QueroMais alloc] initWithRestaurant:restaurante];
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mais];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:nav animated:YES completion:nil];
//    [[DemoRootViewController getInstance] presentViewController:nav animated:YES completion:^{
//        //não preciso de fazer nada
//    }];
}

-(void)chamarLogin{
    Login *log = [Login new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:log];
    
    //[self.revealSideViewController presentViewController:nav animated:YES completion:nil];
    //[self presentViewController:nav animated:YES completion:nil];
    
#warning saiu o paperfold
    
    [self presentViewController:nav animated:YES completion:nil];
    
    //[[DemoRootViewController getInstance] presentViewController:nav animated:YES completion:^{ [self.buttonSeguir setEnabled:YES]; }];
    
    
    //[self.revealSideViewController presentViewController:nav animated:YES completion:nil];
//    [self presentViewController:nav animated:YES completion:^{
//        [self.buttonSeguir setEnabled:YES];
//    }];
    
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)chamarMapa:(id)sender {
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Direcções" message:@"Deseja ver as direções para este restaurante?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
//    alert.tag = 1 ;
//    
//    [alert show];
    
     //[[DemoRootViewController getInstance] chamarMapa:restaurante];
    
    [self.delegate performSelector:@selector(chamarMapa:) withObject:restaurante];
    
}

- (IBAction)clickLigar:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ %d",[Language textForIndex:@"Marcar"],restaurante.phone ] message:@"" delegate:self cancelButtonTitle:[Language textForIndex:@"Nao"] otherButtonTitles:[Language textForIndex:@"Sim"], nil];
    alert.tag = 5;
    [alert show];
    
   }





- (IBAction)clickDiarias:(id)sender
{
    [self popUpMudarLingua];
}

- (IBAction)clickMainPopup:(id)sender {
    
  
        
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:[Language textForIndex:@"Cancel_imagem"]
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:[Language textForIndex:@"Ligar"],self.buttonSeguir.titleLabel.text,@"Quero mais APT",nil];
    
    actionSheet.tag = 2;
    
    
    
    // ObjC Fast Enumeration
  
    //[actionSheet addButtonWithTitle:[Language textForIndex:@"Cancel_imagem"]];
    //actionSheet.cancelButtonIndex = 2;
    
    [actionSheet showInView:self.view];

    
}

-(void)fazerChamada
{
    NSString *phoneNumber = [@"tel://" stringByAppendingFormat:@"%d",restaurante.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

-(void)fezScrool:(NSNumber *)mexeu
{
    CGFloat percentagem = 0.5f;
    
    
    // NSLog(@"colecção mexeu %f",mexeu.floatValue);
    [UIView animateWithDuration:0.5 animations:^{
        
      
        [self.imagemRestaurante setFrame:CGRectMake(0,
                                            (posicaoImg -((mexeu.floatValue+colececaoFavoritos.collectionView.contentInset.top)*percentagem)) -60,
                                            self.viewImagemRest.frame.size.width,
                                            300
                                            )];
        
       
     
        [self.imgFade setFrame:CGRectMake(0,
                                            (posicaoImg -((mexeu.floatValue+colececaoFavoritos.collectionView.contentInset.top)*percentagem)) -60,
                                            self.viewImagemRest.frame.size.width,
                                            300
                                            )];
     
        if (!openCarousel)
        {
            
             [self.viewParaTaparOlhos setFrame:CGRectMake(0,
             (colececaoFavoritos.collectionView.contentInset.top + isIOS7 + 40 -((mexeu.floatValue+colececaoFavoritos.collectionView.contentInset.top)*1)) -19,
             self.viewImagemRest.frame.size.width,
             posicaoImg + mexeu.floatValue +600
             )];
            
            [self.carousel setFrame:CGRectMake(0,
                                               (posicaoImg -((mexeu.floatValue+colececaoFavoritos.collectionView.contentInset.top)*percentagem)) -60,
                                               self.viewImagemRest.frame.size.width,
                                               300
                                               )];
            
        }
        
    }];
    
    
    if (mexeu.floatValue <= -400){
        
        openCarousel = YES;
        [UIView animateWithDuration:0.5 animations:^{
        
            
            [self.container setAlpha:1];
            [self.viewImagemRest setAlpha:0];
            
            [self.viewImagemRest setFrame:CGRectMake(0,
                                                     0,
                                                     self.view.frame.size.width,
                                                     self.view.frame.size.height
                                                     )];
            
           
            [self.carousel setFrame:CGRectMake(0,
                                               self.view.frame.size.height/2 -150,
                                               self.viewImagemRest.frame.size.width,
                                               300
                                               )];
            
        
            [colececaoFavoritos.view setFrame:CGRectMake(0,
                                                         568,
                                                         colececaoFavoritos.view.frame.size.width,
                                                         colececaoFavoritos.view.frame.size.height
                                                         )];
        
        
            [self.viewParaTaparOlhos setFrame:CGRectMake(0,
                                                         568,
                                                         self.viewImagemRest.frame.size.width,
                                                         posicaoImg + mexeu.floatValue +600
                                                         )];

            self.navigationController.toolbarHidden=YES;
            
         }];
    }

    
}

- (IBAction)fecharGaleria:(id)sender {
    
    self.navigationController.toolbarHidden=NO;
    openCarousel = NO;
    [UIView animateWithDuration:0.5 animations:^{
        
        
        [self.container setAlpha:0];
        [self.viewImagemRest setAlpha:1];
        
        [self.viewImagemRest setFrame:CGRectMake(0,
                                                 posicaoImg,
                                                 self.view.frame.size.width,
                                                 self.view.frame.size.height
                                                 )];
        
       
        [self.carousel setFrame:CGRectMake(0,
                                           self.view.frame.size.height/2 -150,
                                           self.viewImagemRest.frame.size.width,
                                           300
                                           )];
        
        
        [colececaoFavoritos.view setFrame:CGRectMake(0,
                                                     20,
                                                     colececaoFavoritos.view.frame.size.width,
                                                     colececaoFavoritos.view.frame.size.height
                                                     )];
        
        
        [self.viewParaTaparOlhos setFrame:CGRectMake(0,
                                                     colececaoFavoritos.collectionView.contentInset.top + isIOS7 + 40  -19,
                                                     self.viewImagemRest.frame.size.width,
                                                     600
                                                     )];

        
    }];

    
    
}


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 480.0f)] autorelease];
        view.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    //cancel any previously loading images for this view
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view];
    
    //set image URL. AsyncImageView class will then dynamically load the image
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://80.172.235.34/~tecnoled%@",[items objectAtIndex:index]] ];
    ((AsyncImageView *)view).imageURL = url ;
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}


- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.items)[index];
    NSLog(@"Tapped view number: %@", item);
}



@end
