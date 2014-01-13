//
//  MapViewController.m
//  BlackDesert
//
//  Created by Hugo Costa on 09/12/13.
//
//

#import "MapViewController.h"

#import "PlaceDetailVO.h"
#import "PinAnnotationG.h"
#import "WebServiceSender.h"
#import "DetailsAnnotation.h"
#import "MapCell.h"
#import "PinAnnotation.h"
#import "DetailsAnnotationView.h"
#import "ViewControllerCell.h"
#import "DemoRootViewController.h"

@interface MapViewController ()
{
    Restaurant * hotelCenas;
    
    NSMutableArray *_annotationList;
    
    PinAnnotationG *_pinAnnotation;
	DetailsAnnotation *_detailsAnnotation;
    
    WebServiceSender * postDownload;
    NSMutableArray * arrayPlaces;

    PlaceDetailVO *voZinho;
}

@end

@implementation MapViewController

-(void)setRestaurante:(Restaurant *)rest
{
    hotelCenas = rest;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithHotel:(Restaurant *)rest
{
    self = [super init];
    if (self) {
        // faz cenas aqui
        hotelCenas = rest;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelMapaTitulo.text=NSLocalizedString(@"Mapa_Titulo", nil);
    // Do any additional setup after loading the view from its nib.
    self.labelTitulo.text = hotelCenas.name;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
   

    // parte para ter pins diferentes mas ainda nao posso clicar neles
    CLLocationCoordinate2D coor;
    coor.latitude = hotelCenas.lat ;
    coor.longitude = hotelCenas.lon;
    PinAnnotationG *pinAnno = [[PinAnnotationG alloc]initWithLatitude: coor.latitude andLongitude:coor.longitude];
    pinAnno.type = @"no type";
    pinAnno.tag = 100;
    pinAnno.title = hotelCenas.name;
    
    // aqui tenho de adicionar um placedetailVO :(
    voZinho = [PlaceDetailVO new];
    voZinho.pNameStr = pinAnno.title;
    voZinho.pLngStr = [NSString stringWithFormat:@"%f", coor.longitude];
    voZinho.pLatStr =[NSString stringWithFormat:@"%f", coor.latitude];
    voZinho.pIconURLStr = hotelCenas.featuredImageString;
    //voZinho.pIDStr = hotelCenas.dbId;
    
    
    [_annotationList addObject:voZinho];
    [self.mapView addAnnotation:pinAnno];
  
    CLLocationCoordinate2D newCenter = CLLocationCoordinate2DMake(coor.latitude,coor.longitude);

    [self.mapView setCenterCoordinate:newCenter animated:YES];
    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coor, 500, 500);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    self.mapView.showsUserLocation = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)clickMapCellButton:(ButtonType)aType placeDetails:(PlaceDetailVO *)aVO
{
    if (aType == ButtonType_Profile) {
        
        [self Voltar:self];
    }
    else if(aType == ButtonType_Distance)
    {
//        CLLocationCoordinate2D loc;
//        loc.latitude = [aVO.pLatStr doubleValue];
//        loc.longitude = [aVO.pLngStr doubleValue];
//        
//        MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: loc addressDictionary: nil];
//        MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
//        destination.name =aVO.pNameStr;
//        NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
//        NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                 MKLaunchOptionsDirectionsModeDriving,
//                                 MKLaunchOptionsDirectionsModeKey, nil];
//        [MKMapItem openMapsWithItems: items launchOptions: options];
        // é aqui que tenho de mudar para ter uma popup
      
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Direcções" message:@"Deseja ver as direções para este restaurante?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
            alert.tag = 1 ;
        
            [alert show];

        
    }
    else if(aType == ButtonType_More)
    {
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        
        if(buttonIndex == 1)//OK button pressed
        {
            CLLocationCoordinate2D loc;
            loc.latitude = [voZinho.pLatStr doubleValue];
            loc.longitude = [voZinho.pLngStr doubleValue];
            
            MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: loc addressDictionary: nil];
            MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
            destination.name =voZinho.pNameStr;
            NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
            NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     MKLaunchOptionsDirectionsModeDriving,
                                     MKLaunchOptionsDirectionsModeKey, nil];
            [MKMapItem openMapsWithItems: items launchOptions: options];
        }
           }
}


//选中MKAnnotationView
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[PinAnnotationG class]]) {
        if (_detailsAnnotation) {
            [mapView removeAnnotation:_detailsAnnotation];
            _detailsAnnotation = nil;
        }
        _detailsAnnotation = [[DetailsAnnotation alloc]
                              initWithLatitude:view.annotation.coordinate.latitude
                              andLongitude:view.annotation.coordinate.longitude];
        PinAnnotationG *anno = (PinAnnotationG *)view.annotation;
        _detailsAnnotation.tag = anno.tag;
        
        [mapView addAnnotation:_detailsAnnotation];
        
        
        
        [mapView setCenterCoordinate:_detailsAnnotation.coordinate animated:YES];
	}
    else if ([view.annotation isKindOfClass:[PinAnnotation class]]) {
        //codigo antigo para meter custon anotation
        
        // Selected the pin annotation.
        CalloutAnnotation *calloutAnnotation = [[CalloutAnnotation alloc] init] ;
        
        PinAnnotation *pinAnnotation    = ((PinAnnotation *)view.annotation);
        calloutAnnotation.title         = pinAnnotation.title;
        calloutAnnotation.placeId       = pinAnnotation.placeId;
        calloutAnnotation.coordinate    = pinAnnotation.coordinate;
        pinAnnotation.calloutAnnotation = calloutAnnotation;
        
        [mapView addAnnotation:calloutAnnotation];
        
    }
}


- (void)removeAllPinsButUserLocation2
{
    id userLocation = [self.mapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[self.mapView annotations]];
    if ( userLocation != nil ) {
        [pins removeObject:userLocation]; // avoid removing user location off the map
    }
    
    [self.mapView removeAnnotations:pins];
    
    pins = nil;
}


//选中完MKAnnotationView
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (_detailsAnnotation&& ![view isKindOfClass:[DetailsAnnotation class]]) {
        
        /*
        if (_detailsAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _detailsAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_detailsAnnotation];
            _detailsAnnotation = nil;
          }
         */
        
        
        
        //[self removeAllPinsButUserLocation2];
        
        CLLocationCoordinate2D coor;
        coor.latitude = hotelCenas.lat;
        coor.longitude = hotelCenas.lon;
        PinAnnotationG *pinAnno = [[PinAnnotationG alloc]initWithLatitude: coor.latitude andLongitude:coor.longitude];
        pinAnno.type = @"no type";
        pinAnno.tag = 100;
        pinAnno.title = hotelCenas.name;
        
        // aqui tenho de adicionar um placedetailVO :(
        PlaceDetailVO *voZinho = [PlaceDetailVO new];
        voZinho.pNameStr = pinAnno.title;
        voZinho.pLngStr = [NSString stringWithFormat:@"%f", coor.longitude];
        voZinho.pLatStr =[NSString stringWithFormat:@"%f", coor.latitude];
        //voZinho.pIconURLStr = [hotelCenas.arrayImageURL objectAtIndex:0];
        //voZinho.pIDStr = hotelCenas.hotelId;
        //voZinho.stars=hotelCenas.stars;
        voZinho.price=hotelCenas.price;
        
        
         [self.mapView addAnnotation:pinAnno];
       
    }else if ([view.annotation isKindOfClass:[PinAnnotation class]]) {
        // Deselected the pin annotation.
        PinAnnotation *pinAnnotation = ((PinAnnotation *)view.annotation);
        
        [mapView removeAnnotation:pinAnnotation.calloutAnnotation];
        
        pinAnnotation.calloutAnnotation = nil;
    }
}


-(void)placeThePinsByAnnotationAry:(NSMutableArray *)aPlaceAry  annoType:(NSString *)aType
{
    
   
    [_annotationList removeAllObjects];
    
    [_annotationList addObjectsFromArray:aPlaceAry];
    
    for (int i=0; i<[aPlaceAry count]; i++) {
        PlaceDetailVO *place = [aPlaceAry objectAtIndex:i];
        CLLocationCoordinate2D coor;
        coor.latitude = [place.pLatStr floatValue];
        coor.longitude = [place.pLngStr floatValue];
        PinAnnotationG *pinAnno = [[PinAnnotationG alloc]initWithLatitude: coor.latitude andLongitude:coor.longitude];
        pinAnno.type = aType;
        pinAnno.tag = i+100;
        [self.mapView addAnnotation:pinAnno];
    }
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[DetailsAnnotation class]]) {
        
        DetailsAnnotationView *annotationView = [[DetailsAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"DetailsAnnotationView"];
        DetailsAnnotation *anno = annotation;
        
        // aqui tenho de adicionar um placedetailVO :(
        
        MapCell  *cell = [MapCell getInstanceWithNibWithBlock:^(ButtonType aType) {
            [self clickMapCellButton:aType placeDetails:voZinho];
        }];
        
        
        cell.placeDetailVO = voZinho;
       // cell.placeDetailVO.pIDStr =[hotelCenas.arrayImageURL objectAtIndex:0];
        [cell toAppearItemsView];
        [annotationView.contentView addSubview:cell];
        
        
        PlaceDetailVO *voZinho = [PlaceDetailVO new];
        voZinho.pNameStr = hotelCenas.name;
        voZinho.pLngStr =[NSString stringWithFormat:@"%f",hotelCenas.lon] ;
        voZinho.pLatStr =[NSString stringWithFormat:@"%f",hotelCenas.lat] ;
        voZinho.pIconURLStr = hotelCenas.featuredImageString;
        //voZinho.pIDStr = hotelCenas.hotelId;
        //voZinho.stars =hotelCenas.stars;
         voZinho.price=hotelCenas.price;

      
       // MKAnnotationView * anotationView =[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"Cell"];
    //    MapCell * cell=[[ViewControllerCell alloc]initWith:voZinho];
    
        /*MapCell  *cell = [MapCell getInstanceWithNibWithBlock:^(ButtonType aType) {
            [self clickMapCellButton:aType placeDetails:voZinho];
        }];
        
        
        cell.placeDetailVO = voZinho;*/
      
        //anotationView.centerOffset = CGPointMake(-160, -65);
        
        //[anotationView addSubview:cell.view];

        return annotationView;
        
        
	} else if ([annotation isKindOfClass:[PinAnnotationG class]]) {
        
        MKAnnotationView *annotationView =[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PinAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:@"PinAnnotation"];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"pin2.png"];
            //annotationView.image = [UIImage imageNamed:@"logomap.png"];

        }
		
		return annotationView;
    }
    
	return nil;
}


- (void)calloutButtonClickedPlace:(NSString *)placeId{

}




- (IBAction)Voltar:(id)sender {
    // o voltar deixa de ser pelo navigation e passa a ser apenas mandar abrir o centro do paperfold
    
    [[DemoRootViewController getInstance] chamarCentro];
   // [self.navigationController popViewControllerAnimated:YES];
}
@end
