//
//  AppDelegate.m
//  RunflrNoStoryBoard
//
//  Created by Hugo Costa on 02/12/13.
//  Copyright (c) 2013 Hugo Costa. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPage.h"
#import "RootViewController.h"
#import "PaperFoldNavigationController.h"
#import "DemoRootViewController.h"
#import "WebServiceSender.h"

// framework para pushnotifications
//#import <Parse/Parse.h>

@implementation AppDelegate{

    WebServiceSender * pushNotification;
    WebServiceSender * imagemDaApp;
}

@synthesize window = _window;
//@synthesize revealSideViewController = _revealSideViewController;


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
}

-(void)CarregarImagem
{
    imagemDaApp = [[WebServiceSender alloc]initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_imagem_guru.php" method:@"" tag:2];
    imagemDaApp.delegate = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    
    [imagemDaApp sendDict:dict];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *)launchOptions
{
   // textar depois para ver se fixe
//    [Parse setApplicationId:@"qlIHP5gTMBtaOoSCngSVxM4FNnvZXL4bMiByGf5A"
//                  clientKey:@"ANZduM6U9J51038UI83rM0STWdZ0Aje2GtFi4emw"];
//    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    [testObject setObject:@"bar" forKey:@"foo"];
//    [testObject save];
    
    [self CarregarImagem];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
    NSDictionary *mutableRetrievedDictionary = [[NSUserDefaults new] objectForKey:@"login"];
    
    if(mutableRetrievedDictionary){
        User *regUser = [User new];
        regUser.dbId = [[mutableRetrievedDictionary objectForKey:@"userid"] integerValue];
        regUser.name = [mutableRetrievedDictionary objectForKey:@"pnome"];
        regUser.email = [mutableRetrievedDictionary objectForKey:@"email"];
        regUser.loginType = @"guru";
        regUser.photo = [mutableRetrievedDictionary objectForKey:@"imagem"];
        
        if([[mutableRetrievedDictionary objectForKey:@"news"] isEqualToString:@"0"])
            
            regUser.isPublish = NO;
        else
            regUser.isPublish = YES;
        
       
        [Globals setUser:regUser];
    }
    
    // Override point for customization after application launch.
    
    // LANG STUFF
    [Language createLanguage];
    
    
    NSString *language;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    language = [defaults stringForKey:@"language"];
    
    
    if (!language) {
        language = [[NSLocale preferredLanguages] objectAtIndex:0];
        language = [language substringToIndex:2];
        
        if (![language isEqualToString:@"pt"] && ![language isEqualToString:@"en"] && ![language isEqualToString:@"es"] && ![language isEqualToString:@"fr"])
        {
            language = @"pt"; // VALOR POR DEFEITO
        }
    }
    
    [Globals setLang:language];
    
    
    //FACEBOOK STUFF
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                //[[[UIAlertView alloc] initWithTitle:@"OK" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                //  [self uo];
            }];
        }
    }
    
    
    // CONFIG STUFF
    
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    
    

    
    
    
    
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    [self.window makeKeyAndVisible];
    
    DemoRootViewController *paper = [[DemoRootViewController alloc] init];
    //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:paper];
    //[navController setNavigationBarHidden:YES];
    [self.window setRootViewController:paper];
    
    
    
    return YES;


}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
    [FBSession setActiveSession:self.session];
    
    [FBSettings publishInstall:[FBSession defaultAppID]];
    NSLog(@"### FB SDK VERSION : %@", [[FBRequestConnection class] performSelector:@selector(userAgent)]);
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [FBSession.activeSession close];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
//    testar depois para ver se é fixe
//    // Store the deviceToken in the current installation and save it to Parse.
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    [currentInstallation setDeviceTokenFromData:deviceToken];
//    [currentInstallation saveInBackground];
    
	NSLog(@"My token is: %@", deviceToken);
    
    // ainda tenho de tirar os espaços da string
    NSString * myString = deviceToken.description;
    
    NSString * newString = [myString stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"%@xx",newString);
    
    pushNotification = [[WebServiceSender alloc]initWithUrl:@"http://80.172.235.34/~tecnoled/menuguru/rundlrweb/data/json_add_rem_not.php" method:@"" tag:1];
    pushNotification.delegate = self;
    
    
    // favsend é para adicionar ou nao o token a lista de tokens e o favsend é o token
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [dict setObject:newString forKey:@"not"];
    [dict setObject:@"1" forKey:@"favSend"];
    
    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:newString forKey:@"token"];
    [defaults synchronize];
    
    
    NSString* notifications = [defaults objectForKey:@"notifications"];
    if(!notifications)
    {
        [pushNotification sendDict:dict];
    }

}

-(void)sendCompleteWithResult:(NSDictionary*)result withError:(NSError*)error{
    
    
    if (!error)
    {
        int tag=[WebServiceSender getTagFromWebServiceSenderDict:result];
        switch (tag)
        {
            case 1:
            {
                NSLog(@"resultado do envio do token =>%@", result.description);
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"YES" forKey:@"notifications"];
                [defaults synchronize];
                
                break;
            }
            case 2:
            {
                NSLog(@"resultado da imagem =>%@", result.description);
                
                
                NSData* data = [[NSData alloc] initWithBase64Encoding:[result objectForKey:@"imagem"] ];
                UIImage* image = [UIImage imageWithData:data];
                
                
                [Globals setImagemGenerica:image];
                
                
                break;
            }
         
                
        }
    }else
    {
        NSLog(@"error webserviceSender %@",error);
        // se contem duplicado é porque ja existe na bd
        NSString *string = error.description;
        if ([string rangeOfString:@"bla"].location == NSNotFound) {
            NSLog(@"string does not contain bla");
        } else {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"YES" forKey:@"notifications"];
            [defaults synchronize];
        }
        
    }
    
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
   
    
    NSLog(@"notificação recebida %@", userInfo);
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[[userInfo objectForKey:@"aps"] objectForKey:@"alert" ] message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"  ] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}
@end
