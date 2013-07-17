//
//  OTBAppDelegate.m
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBAppDelegate.h"
//#import "MMDrawerController.h"
//#import "MMDrawerController+Storyboard.h"
//#import "MMDrawerVisualState.h"
//#import "MFSideMenuContainerViewController.h"

@implementation OTBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    main = [[OTBMainViewController alloc] init];
    
    
    // Override point for customization after application launch.
    UIImage *navBackgroundImage = [UIImage imageNamed:@"blank"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8], UITextAttributeTextColor, [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], UITextAttributeTextShadowColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:24.0], UITextAttributeFont, nil]];
    
    // Change the appearance of back button
//    UIImage *backButtonImage = [[UIImage imageNamed:@"button_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    // Change the appearance of other navigation button
//    UIImage *barButtonImage = [[UIImage imageNamed:@"button_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
//    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //profiles = [[OTBProfilesViewController alloc] init];
    
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:[NSBundle mainBundle]];
    
    
    
//    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
//    UINavigationController *navigationProfiles = [storyboard instantiateViewControllerWithIdentifier:@"Profiles"];
    
//    MFSideMenuContainerViewController *sideMenu = [MFSideMenuContainerViewController containerWithCenterViewController:navigationController leftMenuViewController:nil rightMenuViewController:navigationProfiles];
//    return YES;
//    
//    
//    
//    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *)self.window.rootViewController;
    
    //UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    //UIViewController *rightSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
    //UINavigationController *navigationProfiles = [storyboard instantiateViewControllerWithIdentifier:@"Profiles"];
    
    
    
//    [container setRightMenuViewController:navigationProfiles];
//    [container setCenterViewController:navigationController];
//    
//    [self.window makeKeyAndVisible];
    
    //self.window.rootViewController = container;
    
    //profiles = [[OTBProfilesViewController alloc] init];
    
    //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:main];
    
//    MMDrawerController * drawerController = (MMDrawerController *)self.window.rootViewController;
//    [drawerController setMaximumRightDrawerWidth:320.0];
//    [drawerController setShowsShadow:NO];
//    [drawerController setCenterHiddenInteractionMode:MMDrawerOpenCenterInteractionModeNone];
//    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//
//    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//        
//        if(drawerSide == MMDrawerSideNone) {
//            
//            NSLog(@"SideNone");
//            return;
//        }}];
    
    //[self.window setRootViewController:drawerController];
    
//    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default@2x.png"]];
//    [[main view] addSubview:imageView];
//    [[main view] bringSubviewToFront:imageView];
//
//    //now fade out splash image
//    [UIView transitionWithView:self.window duration:6.0f options:UIViewAnimationOptionTransitionNone animations:^(void){imageView.alpha=0.0f;} completion:^(BOOL finished){[imageView removeFromSuperview];}];
//    
    // as usual
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
