//
//  Resultados.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 03/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface Resultados : UIViewController 
@property (weak, nonatomic) IBOutlet UILabel *labelResultado;



@property CLLocationManager * locationManager;
//-(void)setResultado:(NSString *)resultado;
//-(void)setTipo:(NSString *)tip;

// as invençoes
-(void)setFiltros:(NSMutableDictionary *)dict;

@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (nonatomic , assign) id delegate;

@end
