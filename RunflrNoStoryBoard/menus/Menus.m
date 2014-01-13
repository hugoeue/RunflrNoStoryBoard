//
//  Menus.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 04/01/14.
//  Copyright (c) 2014 Hugo Costa. All rights reserved.
//

#import "Menus.h"
#import "WebServiceSender.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>


#define FONT_SIZE_TITULO 20.0f
#define FONT_SIZE 16.0f
#define FONT_SIZE2 10.0f
#define CELL_CONTENT_WIDTH 260.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface Menus ()
{
    WebServiceSender * envio;
    SLComposeViewController *mySLComposerSheet;
}

@end

@implementation Menus

@synthesize restaurante;

-(void)menuDia
{
    envio = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_menu_dia.php" method:@"" tag:1];
    envio.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
     NSString * restID = [NSString stringWithFormat:@"%d",restaurante.dbId];
    
    
    [dict setObject:[Globals lang] forKey:@"lang"];
    [dict setObject:restID forKey:@"rest_id"];
    
    
    [envio sendDict:dict];

}

-(void)dealloc{
    if (envio) {
        [envio cancel];
    }
    envio = nil;
}

-(void)menuEmenta
{
    envio = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_menu_melhores.php" method:@"" tag:2];
    envio.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSString * restID = [NSString stringWithFormat:@"%d",restaurante.dbId];
    
 /*
    $body['lang'];
    $body['rest_id'];
    $body['nome_cat_em'];
*/
    
    [dict setObject:[Globals lang] forKey:@"lang"];
    [dict setObject:restID forKey:@"rest_id"];
    [dict setObject:restaurante.bestChoices forKey:@"nome_cat_em"];
    
    [envio sendDict:dict];
    
}

-(void)menuEspecial
{
    envio = [[WebServiceSender alloc] initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_menu_especial.php" method:@"" tag:3];
    envio.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSString * restID = [NSString stringWithFormat:@"%d",restaurante.dbId];
    
    
    /*
     
     menu_especial
     json_menu_especial.php
     $body['lang'];
     $body['rest_id'];
     $body['rest_cartao_id'];
     
     */
    
    [dict setObject:[Globals lang] forKey:@"lang"];
    [dict setObject:restID forKey:@"rest_id"];
    [dict setObject:restaurante.chef forKey:@"rest_cartao_id"];
    
    [envio sendDict:dict];
    
}

-(void)partilhar:(NSString *)partilha
{
        [self.buttonPartilhar setAlpha:[partilha doubleValue]];
}


-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado menu do dia  %@", result.description);
                
                NSString *text = [[result objectForKey:@"res"]objectForKey:@"nome"];
                NSString *text2 = [[result objectForKey:@"res"]objectForKey:@"descricao"];
                [self partilhar:[[result objectForKey:@"res"]objectForKey:@"partilhar"]];
                
                [self adicionarCenasAoHeader:text :text2];
                
                for (NSMutableDictionary * resp in [result objectForKey:@"resp"] ) {
                    [itemsTitle addObject:[resp objectForKey:@"nome_cat"]];
                    
                    NSString * pratos = @"";
                    for (NSString * prato in [resp objectForKey:@"nome_prato"] ) {
                        pratos = [NSString stringWithFormat:@"%@\n%@",prato,pratos];
                    }
                    
                    [items addObject:pratos];
                    [itemsPrice addObject:@""];
                }
                
                [itemsTitle addObject:[[result objectForKey:@"res"] objectForKey:@"preco"]];
                [items addObject:@""];
                [itemsPrice addObject:@""];
              
                [dataTableView reloadData];
                
                break;
            }
            case 2:
            {
                NSLog(@"resultado ementa  %@", result.description);
                
                for (NSMutableDictionary * resp in [result objectForKey:@"res"] ) {
                    NSString *text = [resp objectForKey:@"nome"];
                    NSString *text2 = [resp objectForKey:@"descricao"];
                    [self partilhar:[resp objectForKey:@"partilhar"]];
                    [self adicionarCenasAoHeader:text :text2];
                }

                
                for (NSMutableDictionary * resp in [result objectForKey:@"resp"] ) {
                    [itemsTitle addObject:[resp objectForKey:@"prato_menu"]];
                    [items addObject:[resp objectForKey:@"descricao"]];
                    [itemsPrice addObject:[resp objectForKey:@"preco"]];
                }
                
                               
                [dataTableView reloadData];

                
              
                break;
            }
            case 3:
            {
                NSLog(@"resultado especial  %@", result.description);
                
            
                    [self partilhar:[[[result objectForKey:@"resp"] objectForKey:@"res"] objectForKey:@"partilhar"]];
               

                
                NSString *text = [[[result objectForKey:@"resp"] objectForKey:@"res"]objectForKey:@"nome"];
                NSString *text2 = [[[result objectForKey:@"resp"] objectForKey:@"res"]objectForKey:@"descricao"];

                
                self.labelPrecoNovo.text = [[[result objectForKey:@"resp"] objectForKey:@"res"]objectForKey:@"preco_ant"];
                self.labelprecoAntigo.text = [[[result objectForKey:@"resp"] objectForKey:@"res"]objectForKey:@"preco_actual"];
                
                [self.viewPreco setAlpha:1];
                
                [self adicionarCenasAoHeader:text :text2];
             
                
                for (NSMutableDictionary * resp in [[result objectForKey:@"resp"] objectForKey:@"res_titulo"] ) {
                    [itemsTitle addObject:[resp objectForKey:@"titulo"]];
                    [items addObject:[resp objectForKey:@"descricao"]];
                    [itemsPrice addObject:@""];
                }
                
                [dataTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                [dataTableView reloadData];
                
                 break;
        }
        }
    }else
    {
        NSLog(@"error Tanita foofa %@",error);
        
    }
    
    
}


-(void)adicionarCenasAoHeader:(NSString *)titulo :(NSString *)descricao
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [self alturaHeader:titulo :descricao])];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    CGRect sepFrame = CGRectMake(10, headerView.frame.size.height-1, 300, 1);
    UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
    seperatorView.backgroundColor = [UIColor colorWithWhite:224.0/255.0 alpha:1.0];
    [headerView addSubview:seperatorView];
    
    UILabel *labelView = [UILabel new];
    UILabel *label2 = nil;
    
    labelView.text = titulo;
    [headerView addSubview:labelView];
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    [labelView setLineBreakMode:UILineBreakModeWordWrap];
    [labelView setMinimumFontSize:FONT_SIZE_TITULO];
    [labelView setNumberOfLines:0];
    [labelView setFont:[UIFont systemFontOfSize:FONT_SIZE_TITULO]];
    CGSize size = [titulo sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_TITULO] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    [labelView setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 30.0f))];
    
    
    label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    [label2 setLineBreakMode:UILineBreakModeWordWrap];
    [label2 setMinimumFontSize:FONT_SIZE];
    [label2 setNumberOfLines:0];
    [label2 setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    
    NSString *text2 = descricao;
    
    CGSize constraint2 = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size2 = [text2 sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
    
    
    
    [label2 setText:text2];
    [label2 setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN+labelView.frame.size.height, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size2.height, 0.0f))];
    
    [headerView addSubview:label2];

    
    dataTableView.tableHeaderView = headerView;

}

-(CGFloat)alturaHeader:(NSString *)titulo :(NSString *)descricao
{
    NSString *text = titulo;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_TITULO] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 30.0f);
    
    
    
    NSString *text2 = descricao;
    CGFloat height2;
    if(text2.length > 0){
        CGSize constraint2 = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size2 = [text2 sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
        
        height2 = MAX(size2.height, 0.0f);
    }else
    {
        return height  + (CELL_CONTENT_MARGIN );
    }
    
    
    
    return height + height2 + (CELL_CONTENT_MARGIN * 2);
}

-(void)viewWillAppear:(BOOL)animated
{
    self.imageMenu.asynchronous = YES;
    [self.imageMenu setImageWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/%@",restaurante.featuredImageString ]]];
    
    UIView *viewUnderline=[[UIView alloc] init];
    viewUnderline.frame=CGRectMake(self.labelprecoAntigo.frame.origin.x +self.labelprecoAntigo.frame.size.width/2 , self.labelprecoAntigo.frame.origin.y - (self.labelprecoAntigo.frame.size.height)/2,   self.labelprecoAntigo.frame.size.width/2, 1);
    viewUnderline.backgroundColor=[UIColor blackColor];
    [self.viewPreco addSubview:viewUnderline];
    
    
    [super viewDidLoad];
    
    items = [[NSMutableArray alloc] init];
    itemsPrice = [[NSMutableArray alloc] init];
    
    itemsTitle = [[NSMutableArray alloc] init];
    
    
    if([restaurante.parish isEqualToString:@"menu_dia"])
    {
        [self menuDia];
    }else  if([restaurante.parish isEqualToString:@"menu_ementa"])
    {
        [self menuEmenta];
    }else  if([restaurante.parish isEqualToString:@"menu_especial"])
    {
        [self menuEspecial];
    }

}

- (void)viewDidLoad {
    
 
    
}



#pragma mark -
#pragma mark UITableView Delegaates

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
	return [itemsTitle count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [itemsTitle objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 30.0f);
    
    
    
    
   
    NSString *text2 = [items objectAtIndex:[indexPath row]];
    CGFloat height2;
    if(text2.length > 0){
    CGSize constraint2 = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size2 = [text2 sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE2] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
    
    height2 = MAX(size2.height, 0.0f);
    }else
    {
        return height  + (CELL_CONTENT_MARGIN );
    }
    
    
    
    return height + height2 + (CELL_CONTENT_MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    UILabel *label = nil;
    UILabel *label2 = nil;
    UILabel *label3 = nil;
    
    cell = [tv dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"];
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setMinimumFontSize:FONT_SIZE];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label setTag:1];
        
        //[[label layer] setBorderWidth:2.0f];
        
        [[cell contentView] addSubview:label];
        
        
        label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        [label2 setLineBreakMode:UILineBreakModeWordWrap];
        [label2 setMinimumFontSize:FONT_SIZE2];
        [label2 setNumberOfLines:0];
        [label2 setFont:[UIFont systemFontOfSize:FONT_SIZE2]];
        [label2 setTag:2];
        
        //[[label2 layer] setBorderWidth:2.0f];
        [[label2 layer] setBorderColor:[UIColor greenColor].CGColor];
        
        [[cell contentView] addSubview:label2];
        
        
        
        
        label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        [label3 setLineBreakMode:UILineBreakModeWordWrap];
        [label3 setMinimumFontSize:FONT_SIZE2];
        [label3 setNumberOfLines:0];
        [label3 setFont:[UIFont systemFontOfSize:FONT_SIZE2]];
        [label3 setTag:3];
        
        //[[label3 layer] setBorderWidth:2.0f];
        [[label3 layer] setBorderColor:[UIColor greenColor].CGColor];
        
        [[cell contentView] addSubview:label3];

        
    }
    NSString *text = [itemsTitle objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (!label)
        label = (UILabel*)[cell viewWithTag:1];
    
    [label setText:text];
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 30.0f))];
    
    
    
    NSString *text2 = [items objectAtIndex:[indexPath row]];
    
    CGSize constraint2 = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size2 = [text2 sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE2] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
    
    if (!label2)
        label2 = (UILabel*)[cell viewWithTag:2];
    
    [label2 setText:text2];
    [label2 setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN+label.frame.size.height, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size2.height, 0.0f))];
    
    
    
    NSString *text3 =[itemsPrice objectAtIndex:[indexPath row]];
    if (!label3)
        label3 = (UILabel*)[cell viewWithTag:3];
    
    [label3 setText:text3];
    [label3 setFrame:CGRectMake(cell.frame.size.width-50-CELL_CONTENT_MARGIN,label.frame.size.height+label2.frame.size.height-CELL_CONTENT_MARGIN,50,20)];
    
    
    
    return cell;
    
}



- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickPartilhar:(id)sender {
    
    // tenho de verificar se é para twitter ou facebook
    // usar uma alert daquelas que vem de baixo

    [self postImageToFB];
}

- (void) postImageToFB
{
  //  if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
    {
        mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Vejam o cartao %@", restaurante.name]]; //the message you want to post
        
        NSURL *imageurl = [NSURL URLWithString:[NSString stringWithFormat:@"http://80.172.235.34/~tecnoled/%@",restaurante.featuredImageString]];
        
        NSData *imagedata = [[NSData alloc]initWithContentsOfURL:imageurl];
        
        UIImage *image = [UIImage imageWithData: imagedata];
        
        [mySLComposerSheet addImage:image]; //an image you could post
        //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                break;
            default:
                break;
        } //check if everything worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
}
@end