//
//  CollectionGuru.h
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 27/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFQuiltLayout.h"
#import <CoreLocation/CoreLocation.h>

@interface CollectionGuru : UIViewController <RFQuiltLayoutDelegate,UICollectionViewDelegate, UIScrollViewDelegate>{
   
}

@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray* numbers;

@property NSMutableArray * restaurantes;

-(void)CarregarRestaurantes:(NSMutableArray *)restaurantesC;

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) id scroolDelegate;

@property BOOL mostrarGPS;

@end
