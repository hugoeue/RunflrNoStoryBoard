//
//  Resultados.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 03/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface Resultados : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelResultado;



@property CLLocationManager * locationManager;
-(void)setResultado:(NSString *)resultado;
-(void)setTipo:(NSString *)tip;

@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (nonatomic , assign) id delegate;

@end
