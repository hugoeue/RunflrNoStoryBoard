//
//  MapViewController.h
//  BlackDesert
//
//  Created by Hugo Costa on 09/12/13.
//
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
-(id)initWithHotel:(Restaurant *)rest;

- (IBAction)Voltar:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

    @property (weak, nonatomic) IBOutlet UILabel *labelMapaTitulo;
-(void)setRestaurante:(Restaurant *)rest;
@end
