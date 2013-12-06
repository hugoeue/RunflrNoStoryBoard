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


@interface MainPage ()
{
    NSString * tipo;
    
    BOOL isTiming;
    
    NSTimer *timer;
}

@end

@implementation MainPage

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
    self.navigationController.navigationBarHidden = YES;
    
    self.texfFieldPesquisa.delegate = self;
    
    [self.buttonCities setSelected:YES];
    tipo = @"Cities";
    
    [self setFontFamily:@"DKCrayonCrumble" forView:self.view andSubViews:YES];
    
    self.buttonRestaurant.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:20];
    self.buttonCities.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:20];
    self.buttonGo.titleLabel.font = [UIFont fontWithName:@"DKCrayonCrumble" size:18];
    self.texfFieldPesquisa.font = [UIFont fontWithName:@"DKCrayonCrumble" size:18];
    
    [NSThread detachNewThreadSelector:@selector(loadCities) toTarget:self withObject:nil];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIColor *color = [UIColor lightTextColor];
    self.texfFieldPesquisa.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Procure ..." attributes:@{NSForegroundColorAttributeName: color}];
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
    [self ChamarPesquisa];
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
    
    MenuRefugio *t = [[MenuRefugio alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:t];
    [self.revealSideViewController pushViewController:n onDirection:PPRevealSideDirectionTop withOffset:t.view.frame.size.height animated:YES];
    PP_RELEASE(t);
    PP_RELEASE(n);

}

- (IBAction)ClickCitie:(id)sender {
    [((UIButton *)sender) setSelected:YES];
    [self.buttonRestaurant setSelected:NO];
    tipo = @"Cities";
}

- (IBAction)ClickRestaurant:(id)sender {
    [((UIButton *)sender) setSelected:YES];
    [self.buttonCities setSelected:NO];
    tipo = @"Restaurants";
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
        
    } else {
        
        NSError *error = [nsXmlParser parserError];
        
        NSLog(@"erro get restaurantes %@", error.description);
        
        [self performSelectorOnMainThread:@selector(noConnect) withObject:nil waitUntilDone:NO];
        
    }
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    exit(0);
}

- (void)findNearest
{
    /*
    clManager = [[CLLocationManager alloc] init];
    [clManager setDelegate:self];
    
    [clManager startUpdatingLocation];
    
    BOOL lYes = [CLLocationManager locationServicesEnabled];
    
    
    if (lYes) {
        
        [Globals setCityId:12];
        [self startFeatured];
    } else {
        [Globals setCityId:12];
        [self startFeatured];
    }
     */
}

/*
- (void)startFeatured
{
    // Start parsing Cities
    
    [NSThread detachNewThreadSelector:@selector(loadFeatured) toTarget:self withObject:nil];
}

- (void)loadFeatured
{
    
    FeaturedParser *featuredParser = [[FeaturedParser alloc] initXMLParser];
    
    //    NSString *host = @"http://cms.citychef.pt/data/xml_featured.php?city_id=12";
    
    NSString *host = [NSString stringWithFormat:@"http://cms.citychef.pt/data/xml_featured.php?city_id=%d", [Globals cityId]];
    
    
    NSURL *url = [[NSURL alloc] initWithString: host];
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
    [nsXmlParser setDelegate:featuredParser];
    
    BOOL success = [nsXmlParser parse];
    
    if (success) {
        
        NSLog(@"success loaded cities");
        
        for (City * vitie in [Globals cities]) {
            NSLog(@"Citie name: %@ ",vitie.name);
        }
        
    } else {
         NSLog(@"FAIL loaded cities");
    }
    
    
}
*/


@end
