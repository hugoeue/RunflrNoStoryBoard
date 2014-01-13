//
//  ViewControllerCell.h
//  BlackDesert
//
//  Created by CodAngel codAngel on 12/12/13.
//
//

#import <UIKit/UIKit.h>
#import "PlaceDetailVO.h"

@interface ViewControllerCell : UIViewController
-(id)initWith:(PlaceDetailVO*)place;
@property (weak, nonatomic) IBOutlet UILabel *labelNomePlace;

@property (weak, nonatomic) IBOutlet UILabel *preco;

@end
