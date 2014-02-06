//
//  Pesquise0.h
//  DinamicTable
//
//  Created by Hugo Costa on 31/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefenicosHeader : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelTitulo;

@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UIImageView *imageArrow;

-(void)RotateArrow:(BOOL)value;
@property (weak, nonatomic) IBOutlet UIView *linha;

@end
