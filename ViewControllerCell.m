//
//  ViewControllerCell.m
//  BlackDesert
//
//  Created by CodAngel codAngel on 12/12/13.
//
//

#import "ViewControllerCell.h"

@interface ViewControllerCell ()

@end

@implementation ViewControllerCell{
    PlaceDetailVO * placeV;
}

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
    self.labelNomePlace.text=placeV.pNameStr;
    self.preco.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"nome", nil),placeV.price];
    

    // Do any additional setup after loading the view from its nib.
}

-(id)initWith:(PlaceDetailVO*)place{
    self=[super init];
    if (self) {
        placeV=place;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
