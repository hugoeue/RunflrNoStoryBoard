/**
 * Copyright (c) 2012 Muh Hon Cheng
 * Created by honcheng on 7/2/12.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject
 * to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR
 * IN CONNECTION WITH THE SOFTWARE OR
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * @author 		Muh Hon Cheng <honcheng@gmail.com>
 * @copyright	2012	Muh Hon Cheng
 * @version
 *
 */

#import "DemoRootViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "UIView+Screenshot.h"
#import "LanguageViewController.h"
#import "PaginaPessoal.h"
#import "Login.h"
#import "Defenicoes.h"


@implementation DemoRootViewController

static DemoRootViewController * demoRoot;

+(DemoRootViewController*)getInstance{
    return demoRoot;
}

-(void)chamarMenu
{
    //[_map.view removeFromSuperview];
    _menu = [MenuRefugio new];
    _menu.delegate = self;
    
    [_topView addSubview:_menu.view];
   
}

-(void)chamarMapa:(Restaurant *)rest
{
    if(!_map){
        _map = [[MapViewController alloc] initWithHotel:rest];
        [_paperFoldView setRightFoldContentView:_map.view foldCount:3 pullFactor:0.4];
    }
    // this disables dragging to unfold the left view
    [self.paperFoldView setEnableLeftFoldDragging:YES];
    
    // this disables dragging to unfold the right view
    [self.paperFoldView setEnableRightFoldDragging:YES];
    
    [_map setRestaurante:rest];
    [_map viewDidLoad];
    [self.paperFoldView setPaperFoldState:PaperFoldStateRightUnfolded animated:YES completion:nil];
    
}

-(void)apagarMapa{
   
    
    // this disables dragging to unfold the left view
    [self.paperFoldView setEnableLeftFoldDragging:NO];
    
    // this disables dragging to unfold the right view
    [self.paperFoldView setEnableRightFoldDragging:NO];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        _paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width,[self.view bounds].size.height)];
        [_paperFoldView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self.view addSubview:_paperFoldView];
        [_paperFoldView setTimerStepDuration:0.02f];
        [_paperFoldView setEnableTopFoldDragging:NO];
        [_paperFoldView setEnableBottomFoldDragging:NO];
        [_paperFoldView setEnableHorizontalEdgeDragging:NO];
        [_paperFoldView setEnableRightFoldDragging:NO];
        [_paperFoldView setEnableLeftFoldDragging:NO];
        
        
        
        //_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0,0,280,[self.view bounds].size.height)];
        //[_paperFoldView setRightFoldContentView:_mapView foldCount:3 pullFactor:0.9];
        
//        _centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width,[self.view bounds].size.height)];
//        [_centerTableView setRowHeight:120];
//        [_paperFoldView setCenterContentView:_centerTableView];
//        [_centerTableView setDelegate:self];
//        [_centerTableView setDataSource:self];
        
        _main = [MainPage new];
        
       
        
        //_paperFoldView.useOptimizedScreenshot = NO;
         _main.delegate = self;
        _nav = [[UINavigationController alloc] initWithRootViewController:_main];
        [_paperFoldView setCenterContentView:_nav.view];
        
        
        
        
        
//        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,320, 20)];
//        view.backgroundColor=[UIColor blackColor];
//        [self.view addSubview:view];
    
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-1,0,1,[self.view bounds].size.height)];
        [_paperFoldView.contentView addSubview:line];
        [line setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake([self.view bounds].size.width,0,1,[self.view bounds].size.height)];
        [_paperFoldView.contentView addSubview:line2];
        [line2 setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight];
        [line2 setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
        
        [_paperFoldView setDelegate:self];
        
        // you may want to disable dragging to preserve tableview swipe functionality
        
        // disable left fold
        //[_paperFoldView setEnableLeftFoldDragging:NO];
        
        // disable right fold
        //[_paperFoldView setEnableRightFoldDragging:NO];
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width,300)];
        
       
        [self chamarMenu];
       
        
        //ShadowView *topShadowView = [[ShadowView alloc] initWithFrame:CGRectMake(0,_topView.frame.size.height-5,_topView.frame.size.width,5) foldDirection:FoldDirectionVertical];
       // [topShadowView setColorArrays:@[[UIColor colorWithWhite:0 alpha:0.3],[UIColor clearColor]]];
       // [_topView addSubview:topShadowView];
        
        [_paperFoldView setTopFoldContentView:_topView topViewFoldCount:2 topViewPullFactor:0.9];
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,0,[self.view bounds].size.height)];
        [_leftTableView setRowHeight:100];
        //[_leftTableView setDataSource:self];
        [_paperFoldView setLeftFoldContentView:_leftTableView foldCount:3 pullFactor:0.9];

        
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width,0.2)];
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:_bottomView.frame];
        [bottomLabel setText:@"A"];
        [bottomLabel setFont:[UIFont boldSystemFontOfSize:150]];
        [bottomLabel setTextAlignment:UITextAlignmentCenter];
        [_bottomView addSubview:bottomLabel];
        
        ShadowView *bottomShadowView = [[ShadowView alloc] initWithFrame:CGRectMake(0,0,_topView.frame.size.width,5) foldDirection:FoldDirectionVertical];
        [bottomShadowView setColorArrays:@[[UIColor clearColor],[UIColor colorWithWhite:0 alpha:0.3]]];
        [_bottomView addSubview:bottomShadowView];
        
        [_paperFoldView setBottomFoldContentView:_bottomView];
        
#warning disabling scroll, requires tapping cell twice to select cells. to be fixed
        [_centerTableView setScrollEnabled:NO];
        //[_paperFoldView setEnableHorizontalEdgeDragging:YES];
    }
    
    demoRoot = self;
    return self;
}

-(void)chamarLigua{
    LanguageViewController *linguas =[LanguageViewController new];
    linguas.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
//     [self.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES completion:^{
//         [self presentTLModalViewController:linguas animated:YES completion:^{
//             
//         }];
//
//     }];
    [_main escurecer];
    [self.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES completion:^{
        
        
        [_main.navigationController pushViewController:linguas animated:YES];
        
    }];
    
    
    
}

-(void)chamarPaginaPessoal{
    if([Globals user]){
        
        PaginaPessoal *pagPessoal = [PaginaPessoal new];
        //pagPessoal.delegate = self.delegate;
        //[self.navigationController pushViewController:pagPessoal animated:YES];
        pagPessoal.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //[self presentViewController:pagPessoal animated:YES completion:nil];
        [_main escurecer];
        [self.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES completion:^{
            
            
            [_main.navigationController pushViewController:pagPessoal animated:YES];
         
            
            
        }];
        
        
//        [self.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES completion:^{
//            [self presentTLModalViewController:pagPessoal animated:YES completion:^{
//                
//            }];
//            
//        }];
    
    }else
    {
        [_main escurecer];
        [self.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES completion:^{
           
            [_main.navigationController pushViewController:[Login new] animated:YES];
         
            
        }];
        
        
//        [self.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES completion:^{
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[Login new] ];
//            
//            [self presentTLModalViewController:nav animated:YES completion:^{
//                
//            }];
//            
//        }];

        
    }
    
    
    
}

-(void)chamarDefenicoes{
    Defenicoes * def = [Defenicoes new];
    
  
    
    [_main escurecer];
    [self.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES completion:^{
        
       
        [_main.navigationController pushViewController:def animated:YES];
        
    }];
    
  
}

-(void)chamarTopo{
    [_main escurecer];
    if ([self.paperFoldView state] == PaperFoldStateTopUnfolded)
    {
       // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [self.paperFoldView setPaperFoldState:PaperFoldStateDefault];
        [_main.buttonPesquisa setUserInteractionEnabled:YES];
  
      
    }
    else{
      //  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.paperFoldView setPaperFoldState:PaperFoldStateTopUnfolded];
        [_main.buttonPesquisa setUserInteractionEnabled:NO];
         [_menu carregarLingua];
        
    }
}


- (void) presentTLModalViewController:(UIViewController *)pDestinationController animated:(BOOL)pAnimated completion:(void (^)(void))completion {
    if (pAnimated) {
        [CATransaction begin];
        
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFade;
        transition.duration = 0.5f;
        transition.fillMode = kCAFillModeForwards;
        transition.removedOnCompletion = YES;
        
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
        
        [self presentViewController:pDestinationController animated:NO completion:completion];
        
        [CATransaction commit];
    } else {
        [self presentViewController:pDestinationController animated:NO completion:completion];
    }
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



#pragma mark paper fold delegate

- (void)paperFoldView:(id)paperFoldView didFoldAutomatically:(BOOL)automated toState:(PaperFoldState)paperFoldState
{
    NSLog(@"did transition to state %i automated %i", paperFoldState, automated);
    
    
    
    if(paperFoldState == PaperFoldStateDefault)
        [self apagarMapa];
    
    if(paperFoldState == PaperFoldStateRightUnfolded)
    {
        [_main.navigationController.view setUserInteractionEnabled:NO];
        
    }
    else{
        [_main.navigationController.view setUserInteractionEnabled:YES];
        
        
    }
}

-(void)chamarCentro{

    [self.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES completion:nil];
}

@end
