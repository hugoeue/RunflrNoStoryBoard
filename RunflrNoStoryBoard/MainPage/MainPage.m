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


@interface MainPage ()
{
    
    bool showFacebook;
    NSString * tipo;
    
    BOOL isTiming;
    
    NSTimer *timer;
    
    UIAlertView *alert;
    UIAlertView *alertBoo;
    UIAlertView *alertBoo2;
    
    WebServiceSender * recomendados;
    
    NSMutableArray * restaurantesRecomendados;
    
}

@property (strong, nonatomic) NSCache *imageCache;

@end

int num = 0;

@implementation MainPage


-(void)lerRecomendados
{
    if (!recomendados) {
     
        recomendados = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_recomendados.php" method:@"" tag:1];
        recomendados.delegate = self;
    
        NSMutableDictionary * dict = [NSMutableDictionary new];

    NSString * latitude = @"41.3869715";
    NSString * longitude = @"-8.3214086";
    
        [dict setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
        [dict setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"lon"];
        
        [dict setObject:latitude forKey:@"lat"];
        [dict setObject:longitude forKey:@"lon"];

    
        [recomendados sendDict:dict];
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
                   // NSString * freguesia = [dict objectForKey:@"freg"];
                  
                    if([[dict objectForKey:@"pag"] isEqualToString:@"sim"])
                    {
                        rest.destaque = YES;
                    }else
                    {
                        rest.destaque = NO;
                    }
                    
                    
                    CLLocation * localRest = [[CLLocation alloc] initWithLatitude:[lati doubleValue] longitude:[longi doubleValue]];
                    
                    
                    //NSLog(@"distancia em metros=> %f m rest => %@" , distancia,restName);
                    CLLocationDistance distance = [localOriginal distanceFromLocation:localRest];
                    
                   // NSLog(@"distancia calculada pelo ios em metros %f de %@", distance,restName);
                    
                  
                    rest.cuisinesResultText = @"";
                    for (NSMutableDictionary *cosinhas in [dict objectForKey:@"cozinhas"])
                    {
                        rest.cuisinesResultText =[NSString stringWithFormat:@"%@, %@",[cosinhas objectForKey:@"cozinhas_nome"],rest.cuisinesResultText] ;
                    }
                    
                    rest.lat =[lati doubleValue];
                    rest.lon =[longi doubleValue];
                    rest.name = restName;
                    rest.dbId = [resId integerValue];
                    rest.featuredImageString = imagem;
                    //rest.name =   @"fabrica das verdadeiras queijadas da sapa";
                    
                    [restaurantesRecomendados addObject:rest];
                }
                
                if (restaurantesRecomendados.count>0) {
                    [self ordenarPorPagos:restaurantesRecomendados];
                }
                
 
                //
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
     
        NSLog(@"na collection %hhd %@", ((Restaurant *)[arrayPagos objectAtIndex:i]).destaque , ((Restaurant *)[arrayPagos objectAtIndex:i]).name);
       
    }

    
    restaurantesRecomendados = maisPerto;
    
    
    // para a colecçao
    self.numbers = [@[] mutableCopy];
    for(; num<restaurantesRecomendados.count; num++)
    {
        [self.numbers addObject:@(num)];
    }
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.direction = UICollectionViewScrollDirectionVertical;
    layout.blockPixels = CGSizeMake(155, 1);

    
    
    [self.collectionView reloadData];
    
    
    
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
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
    [super viewWillDisappear:animated];
    //[self.scrollView setContentOffset: CGPointMake( 0, 90) animated:NO];
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
    else if ([FBSession activeSession].isOpen && ![Globals user]){
        [self loadUser];
    }else{
        [self loadButtonLogin];
    }
  
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
    
    [self gps];
    
    
    self.navigationController.navigationBarHidden = YES;
    
    
    //self.labelRestaurante.text = [Language textForIndex:@"MainFrase1"];
    
    self.texfFieldPesquisa.delegate = self;
    
    [self.buttonCities setSelected:YES];
    tipo = @"Cities";
    
    //[self setFontFamily:@"DKCrayonCrumble" forView:self.view andSubViews:YES];
    
//    self.buttonRestaurant.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:20];
//    self.buttonCities.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:20];
//    self.buttonGo.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:18];
//    self.texfFieldPesquisa.font = [UIFont fontWithName:@"DKCrayonCrumble" size:32];
    
    [NSThread detachNewThreadSelector:@selector(loadCities) toTarget:self withObject:nil];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    UIColor *color = [UIColor lightTextColor];
    self.texfFieldPesquisa.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Procure ..." attributes:@{NSForegroundColorAttributeName: color}];
    
    
    
    // Set a default data source for all instances.  Otherwise, you can specify the data source on individual text fields via the autocompleteDataSource property
    

    [self setTextPadding:self.texfFieldPesquisa];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.scrollView addGestureRecognizer:singleTap];

   // [self makeLogin];
    //[self loadUser];
   
    //self.scrollView.contentOffset = CGPointMake( 0, 90);
    
    
  
    [self gps];
    self.collectionView.delegate = self;
    

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
    [self lerRecomendados];
    [locationManager stopUpdatingLocation];
}





// cenas da colecçao

- (UIColor*) colorForNumber:(NSNumber*)num {
    return [UIColor colorWithHue:((19 * num.intValue) % 255)/255.f saturation:1.f brightness:1.f alpha:1.f];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.numbers.count;
}

-(CGFloat)getNumberOffLinesTitle:(NSString *)titulo{

    // criar aqui o cenas para saber a altura
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 140, 100)];
    label.numberOfLines = 4;
    label.textColor = [UIColor blackColor];

    NSMutableAttributedString *ass;
    
    ass = [[NSMutableAttributedString alloc] initWithString: titulo];
    
    [ass addAttribute:NSKernAttributeName
                value:[NSNumber numberWithFloat:0.8]
                range:NSMakeRange(0, [titulo length]) ];
    
    [ass addAttribute:NSFontAttributeName
                value:[UIFont fontWithName:@"HelveticaNeue" size:18]
                range:NSMakeRange(0, [titulo length]) ];
    
    label.attributedText = ass;
    
    
    
    CGSize labelSize = [label.text sizeWithFont:label.font
                                constrainedToSize:label.frame.size
                                    lineBreakMode:UILineBreakModeWordWrap];
    CGFloat labelHeight = labelSize.height;
    //NSLog(@"labelHeight = %f", labelHeight);
    return  labelHeight;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Restaurant * restaurante=  [restaurantesRecomendados objectAtIndex:indexPath.row];

    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    
//    cell.frame = CGRectMake(cell.frame.origin.x,
//                            cell.frame.origin.y,
//                            cell.frame.size.width,
//                            1000);
    
        //cell.backgroundColor = [self colorForNumber:self.numbers[indexPath.row]];
        cell.backgroundColor = [UIColor whiteColor];
        cell.clipsToBounds = YES;
        
        cell.layer.masksToBounds = NO;
        cell.layer.cornerRadius = 0; // if you like rounded corners
        cell.layer.shadowOffset = CGSizeMake(3, 1);
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, cell.frame.size.width-4, cell.frame.size.height-1)].CGPath;
        cell.layer.shadowRadius = 1;
        
        cell.layer.shadowOpacity = 1.0;
        
    
        
        
        
        
        
        FXImageView * imagem = (id)[cell viewWithTag:6];
        if(!imagem)
            imagem = [FXImageView new];
    
        imagem.backgroundColor = [UIColor grayColor];
    
        imagem.tag = 6;
        ///imagens_rest/sem_imagem.png
        
        // helvetica-new 28 titulo
        // hekvetica-light 18 tipo de cosinha
        
        
        [imagem setImageWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/%@",restaurante.featuredImageString ]]];
        //[imagem setFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height*0.7f)];
    
        [imagem setFrame:CGRectMake(0, 0, cell.frame.size.width, 150)];
        
        imagem.contentMode = UIViewContentModeScaleAspectFill;
        imagem.asynchronous = YES;
        imagem.clipsToBounds = YES;
        
        
        NSLog(@"cosinhas %@", restaurante.cuisinesResultText);
    
    
    
    UILabel* label = (id)[cell viewWithTag:5];
    if(!label){
        label = [[UILabel alloc]init];
    }
    
    
    //label.frame = CGRectMake(10,cell.frame.size.height*0.7f-20, cell.frame.size.width -15, cell.frame.size.height*0.3f);
    label.frame = CGRectMake(10,imagem.frame.size.height +10, cell.frame.size.width -15, [self getNumberOffLinesTitle:restaurante.name]);
    label.numberOfLines = 4;
    label.tag = 5;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor greenColor];
    //label.adjustsFontSizeToFitWidth=YES;
    //label.minimumScaleFactor=0;
    
    
    UILabel* label2 = (id)[cell viewWithTag:7];
    if(!label2){
        label2 = [UILabel new];
        label2.tag = 7;
        
    }
    
    NSMutableAttributedString *ass;
    
    
    
    ass = [[NSMutableAttributedString alloc] initWithString: restaurante.name];
    
    [ass addAttribute:NSKernAttributeName
                value:[NSNumber numberWithFloat:0.8]
                range:NSMakeRange(0, [restaurante.name length]) ];
    
    [ass addAttribute:NSFontAttributeName
                value:[UIFont fontWithName:@"HelveticaNeue" size:16]
                range:NSMakeRange(0, [restaurante.name length]) ];
    
    label.attributedText = ass;
    
    
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, label.frame.origin.y, cell.frame.size.width -5, cell.frame.size.height/2)];
    
    label2.numberOfLines = 2;
    label2.textColor = [UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1];
    
    
    NSMutableAttributedString *ass2;
    
    
    ass2 = [[NSMutableAttributedString alloc] initWithString: restaurante.cuisinesResultText];
    
    [ass2 addAttribute:NSKernAttributeName
                 value:[NSNumber numberWithFloat:0.8]
                 range:NSMakeRange(0, [restaurante.cuisinesResultText length]) ];
    
    [ass2 addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"HelveticaNeue" size:10]
                 range:NSMakeRange(0, [restaurante.cuisinesResultText length]) ];
    
    label2.attributedText = ass2;

    
    
    
    NSArray *viewsToRemove = [cell subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
        //label.text = [NSString stringWithFormat:@"%@", restaurante.name];
        label.backgroundColor = [UIColor clearColor];
        [cell addSubview:label];
    
    
   
    
        [cell addSubview:label2];
        [cell addSubview:imagem];
        
        
        

        return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   //selectedPhotoIndex = indexPath.row;
     NSLog(@"clicou em %d",indexPath.row);
}



#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.0;
}

#pragma mark – RFQuiltLayoutDelegate

- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row >= self.numbers.count)
        NSLog(@"Asking for index paths of non-existant cells!! %d from %d cells", indexPath.row, self.numbers.count);
    

    // temos de ver a label do gajo e segundo o numero de linhas tenho de  por maior ou nao a celula
     Restaurant * restaurante=  [restaurantesRecomendados objectAtIndex:indexPath.row];
    
    
    CGFloat altura = [self getNumberOffLinesTitle:restaurante.name];
    
    //NSLog(@"altura da label %f",altura);
    // alterado plo Hugo
//    if (indexPath.row % 2 == 0)
//        return CGSizeMake(1, 2.0f);
//    else if (indexPath.row % 3 == 0)
//        return CGSizeMake(1, 3.0f);
//    //else
//      //  return CGSizeMake(2, 2.0f);
//
    

    
    
    return CGSizeMake(1, altura +250);
    
    if(altura >50)
    {
        return CGSizeMake(1, 4.0f);
    }else if(altura >20)
    {
        return CGSizeMake(1, 3.0f);
    }else
    {
        return CGSizeMake(1, 2.0f);
    }
    
    
    return CGSizeMake(1, 3);
}

- (UIEdgeInsets)insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(10, 5, 0, 5);
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

- (void)loadFaceImage
{
    NSString *str = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", [Globals user].faceId];
    
    
    UIImage *image1 = [self.imageCache objectForKey:str];
    
    
    if (!image1) {
        NSData* data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str]];
        image1 = [UIImage imageWithData:data1];
        if (image1)
            [self.imageCache setObject:image1 forKey:str];
    }
    
    self.imageFacebook.image = image1;
    self.imageFacebook.layer.cornerRadius = self.imageFacebook.frame.size.height/2;
    self.imageFacebook.clipsToBounds = YES;
    self.imageFacebook.layer.borderWidth = 1.0f;
    self.imageFacebook.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonGo.alpha = 0;
    self.labelUsername.text =[NSString stringWithFormat:@"Olá %@",[Globals user].name] ;
    self.labelUsername.font = [UIFont fontWithName:@"DKCrayonCrumble" size:22];
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
    
    
    Resultados *c = [[Resultados alloc] initWithNibName:@"Resultados" bundle:nil];
    [c setResultado:self.texfFieldPesquisa.text];
    [c setTipo:tipo];
    [self.navigationController pushViewController:c animated:YES];
    PP_RELEASE(c);
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
    [self.delegate performSelector:@selector(chamarTopo) ];

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
        [self.imageBico setFrame:CGRectMake(160,
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

    if(self.scrollView.contentOffset.y == 0)
        [self.scrollView setContentOffset:CGPointMake( 0, -90) animated:YES];
    else
        [self.scrollView setContentOffset:CGPointMake( 0, 0) animated:YES];
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

- (void)loadCities
{
    CitiesParser *citiesParser = [[CitiesParser alloc] initXMLParser];
    
    //    NSString *host = @"http://cms.citychef.pt/data/xml_cities.php";
    
    NSString *host = [Globals hostWithFile:@"xml_cities.php" andGetData:@""];
    NSLog(@"HOST NEW:%@", host);
    
    NSURL *url = [[NSURL alloc] initWithString: host];
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
    [nsXmlParser setDelegate:citiesParser];
    
    BOOL success = [nsXmlParser parse];
    
    
    if (success) {
        
       // [settingsVC refreshCities];
        
        //[self performSelectorOnMainThread:@selector(findNearest) withObject:nil waitUntilDone:NO];
        
        NSLog(@"success loaded cities");
        
        /*
        for (City * vitie in [Globals cities]) {
            NSLog(@"Citie name: %@ ",vitie.name);
        }
        */
        
        [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
        
        
        //self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        
        self.texfFieldPesquisa.autocompleteType = HTAutocompleteTypeColor;
        
    } else {
        
        NSError *error = [nsXmlParser parserError];
        
        NSLog(@"erro get restaurantes %@", error.description);
        
        [self performSelectorOnMainThread:@selector(noConnect) withObject:nil waitUntilDone:NO];
        
    }
}



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


- (void)findNearest
{

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
            [alert show];
    }else{
        [self ChamarFavoritos];
        }
}

-(void)chamarLogin{
    Login *log = [Login new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:log];
    
    //[self.revealSideViewController presentViewController:nav animated:YES completion:nil];
    [self presentViewController:nav animated:YES completion:nil];

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
        
        [self loadFaceImage];
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

             
             [self startUpContainers2];

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
    
    //[self showFaceStuff];
    //[self loadUser];
    [self loadFaceImage];
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


- (void)startUpContainers2
{
    [self loadFaceImage];
    // fax coisas aqui... yuppy
    //[self ChamarFavoritos];
    
}

-(void)ChamarFavoritos
{
    
    
    NSLog(@"chamar navigation com os favoritos");
    
    Resultados *c = [[Resultados alloc] initWithNibName:@"Resultados" bundle:nil];
    [c setResultado:self.texfFieldPesquisa.text];
    [c setTipo:@"Favoritos"];
    [self.navigationController pushViewController:c animated:YES];
    PP_RELEASE(c);
}




- (void)facebookLoginLogout
{
    if ([FBSession activeSession].isOpen) {
        [[FBSession activeSession] closeAndClearTokenInformation];
        
    } else {
        
    }
    
    
}




@end
