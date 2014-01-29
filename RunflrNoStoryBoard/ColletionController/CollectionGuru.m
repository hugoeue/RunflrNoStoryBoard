//
//  CollectionGuru.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 27/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "CollectionGuru.h"
#import "Restaurant.h"
#import "FXImageView.h"
#import "RecipeCollectionHeaderView.h"

@interface CollectionGuru ()
{
    
}

@end



@implementation CollectionGuru

@synthesize restaurantes,locationManager,mostrarGPS;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mostrarGPS = YES;
        
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"dealloc da porra da colecçao");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell2"];
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.direction = UICollectionViewScrollDirectionVertical;
    layout.blockPixels = CGSizeMake(155, 50);

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)imprimirDistancia:(Restaurant *)rest
{
    if (mostrarGPS)
  
    if (locationManager.location.coordinate.latitude!=0) {
        CLLocation * localRest = [[CLLocation alloc] initWithLatitude:rest.lat longitude:rest.lon];
        CLLocation * localActual = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
        
        CLLocationDistance distance = [localActual distanceFromLocation:localRest];
        //NSLog(@"distancia calculada  %f de %@", distance,rest.name);
        
        if(distance>1000*100)
            return [NSString stringWithFormat:@"%.0f Km",distance/1000];
        if(distance>1000*10)
            return [NSString stringWithFormat:@"%.1f Km",distance/1000];
        if (distance>1000) {
            return [NSString stringWithFormat:@"%.1f Km",distance/1000];
        }
        
        
        
        return [NSString stringWithFormat:@"%.0f m",distance];
    }else
    {
        return @"Ative geolocalização";
    }else
        return @"";
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 155, 100)];
    label.numberOfLines = 2;
    label.textColor = [UIColor blackColor];
    
    NSMutableAttributedString *ass;
    
    ass = [[NSMutableAttributedString alloc] initWithString: titulo];
    
    [ass addAttribute:NSKernAttributeName
                value:[NSNumber numberWithFloat:0.8]
                range:NSMakeRange(0, [titulo length]) ];
    
    [ass addAttribute:NSFontAttributeName
                value:[UIFont fontWithName:@"HelveticaNeue" size:20]
                range:NSMakeRange(0, [titulo length]) ];
    
    label.attributedText = ass;
    
    
    
    CGSize labelSize = [label.text sizeWithFont:label.font
                              constrainedToSize:label.frame.size
                                  lineBreakMode:UILineBreakModeWordWrap];
    CGFloat labelHeight = labelSize.height;
    //NSLog(@"labelHeight = %f", labelHeight);
    if (labelHeight>60) {
        return 45;
    }
    return  labelHeight;
}

-(CGFloat)getHeightOffRestaurant:(Restaurant *)rest{
    
    // criar aqui o cenas para saber a altura
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 145, 60)];
    label.numberOfLines = 2;
    label.textColor = [UIColor blackColor];
    
    NSMutableAttributedString *ass;
    
    ass = [[NSMutableAttributedString alloc] initWithString: rest.name];
    
    [ass addAttribute:NSKernAttributeName
                value:[NSNumber numberWithFloat:0.8]
                range:NSMakeRange(0, [rest.name length]) ];
    
    [ass addAttribute:NSFontAttributeName
                value:[UIFont fontWithName:@"HelveticaNeue" size:16]
                range:NSMakeRange(0, [rest.name length]) ];
    
    label.attributedText = ass;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 145, 60)];
    label2.numberOfLines = 2;
    label2.textColor = [UIColor blackColor];
    
    NSMutableAttributedString *ass2;
    
    ass2 = [[NSMutableAttributedString alloc] initWithString: rest.cuisinesResultText];
    
    [ass2 addAttribute:NSKernAttributeName
                 value:[NSNumber numberWithFloat:0.8]
                 range:NSMakeRange(0, [rest.cuisinesResultText length]) ];
    
    [ass2 addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"HelveticaNeue" size:16]
                 range:NSMakeRange(0, [rest.cuisinesResultText length]) ];
    
    label2.attributedText = ass;
    
    
    
    
    
    
    CGSize labelSize = [label.text sizeWithFont:label.font
                              constrainedToSize:label.frame.size
                                  lineBreakMode:UILineBreakModeWordWrap];
    CGFloat labelHeight = labelSize.height;
    
    
    
    CGSize labelSize2 = [label.text sizeWithFont:label2.font
                               constrainedToSize:label2.frame.size
                                   lineBreakMode:UILineBreakModeWordWrap];
    CGFloat labelHeight2 = labelSize2.height;
    
 
    
    if (rest.tamanhoImagem.height == 290 && labelHeight + labelHeight2< 38) {
        labelHeight2 = 40;
    }
    
   // NSLog(@"labelHeight = %f", labelHeight);
    if (rest.tamanhoImagem.height > 0) {
        return  labelHeight + [self tamanhoDaImagemCorrecto:rest.tamanhoImagem ] + labelHeight2 +80;
    }
    else{
        return  labelHeight + labelHeight2 + 65;
    }
    
}


-(CGFloat)tamanhoDaImagemCorrecto:(CGSize)tamanho
{
    CGFloat altura = 0;
    
    if(tamanho.height){
        
        
        CGFloat percentagem = (tamanho.height*145) /tamanho.width;
        
        
        altura = percentagem;
        
        
    }
    
    return altura;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Restaurant * restaurante=  [restaurantes objectAtIndex:indexPath.row];
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    
    
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
    
    
    
    
    
   // [self imprimirDistancia:restaurante ];
    
    
    
    FXImageView * imagem = (id)[cell viewWithTag:6];
    if(!imagem)
        imagem = [FXImageView new];
    
    imagem.backgroundColor = [UIColor grayColor];
    
    imagem.tag = 6;
    ///imagens_rest/sem_imagem.png
    
    // helvetica-new 28 titulo
    // hekvetica-light 18 tipo de cosinha
    
    imagem.asynchronous = YES;
    [imagem setImageWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/%@",restaurante.featuredImageString ]]];
    //[imagem setFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height*0.7f)];
    
    [imagem setFrame:CGRectMake(0, 0, cell.frame.size.width, [self tamanhoDaImagemCorrecto:restaurante.tamanhoImagem])];
    
    imagem.contentMode = UIViewContentModeScaleAspectFill;
    
    imagem.clipsToBounds = YES;
    
    
    FXImageView * imagem2 = (id)[cell viewWithTag:12];
    if(!imagem2)
        imagem2 = [FXImageView new];

    imagem2.tag = 12;
   
    
    imagem2.asynchronous = YES;
    
    imagem2.image = [UIImage imageNamed:@"compas-25.png"];
    
    //NSLog(@"cosinhas %@", restaurante.cuisinesResultText);
    
    
    
    UILabel* label = (id)[cell viewWithTag:5];
    if(!label){
        label = [[UILabel alloc]init];
    }
    
    
    //label.frame = CGRectMake(10,cell.frame.size.height*0.7f-20, cell.frame.size.width -15, cell.frame.size.height*0.3f);
    label.frame = CGRectMake(10,imagem.frame.size.height+5 , cell.frame.size.width -15, [self getNumberOffLinesTitle:restaurante.name]);
    label.numberOfLines = 2;
    label.tag = 5;
    label.textColor = [UIColor blackColor];
    
    
    
    UILabel* label2 = (id)[cell viewWithTag:7];
    if(!label2){
        label2 = [UILabel new];
        label2.tag = 7;
        
    }
    
    NSMutableAttributedString *ass;
    
    
    
    ass = [[NSMutableAttributedString alloc] initWithString: restaurante.name];
    
    [ass addAttribute:NSKernAttributeName
                value:[NSNumber numberWithFloat:0.3]
                range:NSMakeRange(0, [restaurante.name length]) ];
    
    [ass addAttribute:NSFontAttributeName
                value:[UIFont fontWithName:@"HelveticaNeue" size:16]
                range:NSMakeRange(0, [restaurante.name length]) ];
    
    label.attributedText = ass;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 8./16;
    
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, label.frame.origin.y+label.frame.size.height +7, cell.frame.size.width -20,
                                                       cell.frame.size.height-20 - (label.frame.origin.y+label.frame.size.height +7))];
    
    label2.numberOfLines = 4;
    label2.textColor = [UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1];
    
    
    
    
    
    NSMutableAttributedString *ass2;
    
    
    ass2 = [[NSMutableAttributedString alloc] initWithString: restaurante.cuisinesResultText];
    
    [ass2 addAttribute:NSKernAttributeName
                 value:[NSNumber numberWithFloat:0.3]
                 range:NSMakeRange(0, [restaurante.cuisinesResultText length]) ];
    
    [ass2 addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"HelveticaNeue" size:10]
                 range:NSMakeRange(0, [restaurante.cuisinesResultText length]) ];
    
    label2.attributedText = ass2;
    //label2.backgroundColor = [UIColor greenColor];
    label2.clipsToBounds = NO;
    
    
    UILabel* label3 = (id)[cell viewWithTag:8];
    if(!label3){
        label3 = [UILabel new];
        label3.tag = 8;
        
    }
    
    
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(30, cell.frame.size.height-20, cell.frame.size.width -30, 20)];
    
    label3.numberOfLines = 3;
    label3.textColor = [UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1];
    
    
    NSMutableAttributedString *ass3;
    
    NSString * distancia =[self imprimirDistancia:restaurante];
    
    ass3 = [[NSMutableAttributedString alloc] initWithString:distancia];
    
    [ass3 addAttribute:NSKernAttributeName
                 value:[NSNumber numberWithFloat:0.3]
                 range:NSMakeRange(0, [distancia length]) ];
    
    [ass3 addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]
                 range:NSMakeRange(0, [distancia length]) ];
    
    label3.attributedText = ass3;
    
    
    [imagem2 setFrame: CGRectMake(10, cell.frame.size.height-18, 15, 15)];
    
    
    
    
    ///////// label 4
    
    UILabel* label4 = (id)[cell viewWithTag:9];
    if(!label4){
        label4 = [UILabel new];
        label4.tag = 9;
        
    }
    
    
    label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, label.frame.origin.y+label.frame.size.height -4, cell.frame.size.width -15, 14)];
    
    label4.numberOfLines = 1;
    label4.textColor = [UIColor colorWithRed:101.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1];
    
    
    NSMutableAttributedString *ass4;
    
    
    ass4 = [[NSMutableAttributedString alloc] initWithString:restaurante.city];
    
    [ass4 addAttribute:NSKernAttributeName
                 value:[NSNumber numberWithFloat:0.3]
                 range:NSMakeRange(0, [restaurante.city length])];
    
    [ass4 addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"HelveticaNeue" size:10]
                 range:NSMakeRange(0, [restaurante.city length]) ];
    
    label4.attributedText = ass4;
    //label.clipsToBounds = NO;
    
    
    
    
    NSArray *viewsToRemove = [cell subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    //label.text = [NSString stringWithFormat:@"%@", restaurante.name];
    label.backgroundColor = [UIColor clearColor];
    

    
    
    [cell addSubview:label];
    [cell addSubview:label2];
    [cell addSubview:label3];
    [cell addSubview:label4];
    [cell addSubview:imagem];
    
    if (distancia.length!=0) {
        [cell addSubview:imagem2];
    }
        
    
    
    
    return cell;
    
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //selectedPhotoIndex = indexPath.row;
    NSLog(@"clicou em %d",indexPath.row);
    
    if(self.delegate)
    {
        [self.delegate performSelector:@selector(chamarRestaurante:) withObject:[restaurantes objectAtIndex:indexPath.row]];
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(self.scroolDelegate)
    {
        [self.scroolDelegate performSelector:@selector(fezScrool:) withObject:[NSNumber numberWithFloat:scrollView.contentOffset.y]];
    }
    
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
    
    CGFloat altura = 0;
    
    if(indexPath.row >= restaurantes.count)
        NSLog(@"Asking for index paths of non-existant cells!! %d from %d cells", indexPath.row, self.numbers.count);
    
    
    // temos de ver a label do gajo e segundo o numero de linhas tenho de  por maior ou nao a celula
    Restaurant * restaurante=  [restaurantes objectAtIndex:indexPath.row];
    
    
    altura = [self getHeightOffRestaurant:restaurante];
    
    
    
    
    
    int altura1 = (int) altura /50;
    
    if((altura1-(altura /50))>0)
    {
        altura1 = altura1+1;
    }
    
    return CGSizeMake(1, altura1);
    
    
}

- (UIEdgeInsets)insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(10, 5, 0, 5);
}

-(void)CarregarRestaurantes:(NSMutableArray *)restaurantesC
{
    
int num = 0;
    [restaurantes removeAllObjects];
    [self.numbers removeAllObjects];
    
    restaurantes = restaurantesC;
    // para a colecçao
    self.numbers = [@[] mutableCopy];
    for(; num<restaurantesC.count; num++)
    {
        [self.numbers addObject:@(num)];
    }
    
  
    
    
    [self.collectionView reloadData];

}


@end
