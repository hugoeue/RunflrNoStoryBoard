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

@implementation AppDelegate

@synthesize window = _window;
//@synthesize revealSideViewController = _revealSideViewController;


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *)launchOptions
{
    
    
    NSDictionary *mutableRetrievedDictionary = [[NSUserDefaults new] objectForKey:@"login"];
    
    if(mutableRetrievedDictionary){
        User *regUser = [User new];
        regUser.dbId = [[mutableRetrievedDictionary objectForKey:@"userid"] integerValue];
        regUser.name = [mutableRetrievedDictionary objectForKey:@"pnome"];
        regUser.email = [mutableRetrievedDictionary objectForKey:@"email"];
        regUser.loginType = @"guru";
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
    
    //    NSLog(@":::::%d:::", [components weekday]);
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    
    
     // cenas pp_reveal
    
    self.window = PP_AUTORELEASE([[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]);
    
    MainPage *main = [[MainPage alloc] initWithNibName:@"MainPage" bundle:nil];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main];
    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
    
    
    // esta linha de codigo serve apenas para desligar as sombras
    [_revealSideViewController setOptions:PPRevealSideOptionsNone];
    
    _revealSideViewController.delegate = self;
    
    self.window.rootViewController = _revealSideViewController;
    
    // Uncomment if you want to test (yeah that's not pretty) the PPReveal deallocating
    //[self performSelector:@selector(unloadRevealFromMemory) withObject:nil afterDelay:3.0];
    
    PP_RELEASE(main);
    PP_RELEASE(nav);
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
     
    
    
    // primeiro teste paperfold
    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MainPage *contentViewController = [MainPage new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:contentViewController];
    PaperFoldNavigationController *paperFoldNavController = [[PaperFoldNavigationController alloc] initWithRootViewController:navController];
    
    _menuRef = [MenuRefugio new];
    
    [paperFoldNavController setTopViewControllerC:_menuRef width:0.9];
    [self.window setRootViewController:paperFoldNavController];
    */
    
    
    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    DemoRootViewController *paper = [[DemoRootViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:paper];
    [navController setNavigationBarHidden:YES];
    [self.window setRootViewController:navController];
    
    return YES;
*/
    
    
    
    
    
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
@end
