//
//  AppDelegate.m
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 02/12/14.
//  Copyright (c) 2014 Sanjay Kumar. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netdb.h>
#import "constant.h"

@interface AppDelegate ()

@end

AppDelegate *appDelegate=nil;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    appDelegate=self;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:KISLOGIN])
    {
        //[self callSignInView];
        [self prepareTabbarController];
    }
    else
    {
        [self prepareTabbarController];
    }

    [self showLoaderView];
    return YES;
}
-(void) callSignInView
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
    UINavigationController *vc = [sb instantiateInitialViewController];
    
    self.window.rootViewController = vc;
}
-(void) prepareTabbarController
{
    
    //---------------- TRIPS
    
    UIStoryboard *sbTrips = [UIStoryboard storyboardWithName:@"trips" bundle:nil];
    tripNavigationController  = [sbTrips instantiateInitialViewController];
    tripNavigationController.navigationBarHidden = NO;
    [tripNavigationController.navigationBar setBackgroundImage:NAVIGATION_BAR_IMAGE forBarMetrics:UIBarMetricsDefault];
    tripNavigationController.navigationBar.translucent = NO;
   // [tripNavigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeueCyr-Thin" size:22.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *tempContact = [NAVIGATION_BACK_BTN imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    [tripNavigationController.navigationBar setBackIndicatorImage:tempContact];
    [tripNavigationController.navigationBar setBackIndicatorTransitionMaskImage:tempContact];
    UIImage* contactsImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"trip" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* contactTabBarItem = [[UITabBarItem alloc] initWithTitle:@"JK NEWS" image:contactsImage tag:104];
    tripNavigationController.tabBarItem = contactTabBarItem;
    
    //---------------- NEWS
    
    UIStoryboard *sbNews = [UIStoryboard storyboardWithName:@"news" bundle:nil];
    newsNavigationController = [sbNews instantiateInitialViewController];
    newsNavigationController.navigationBarHidden = NO;
    [newsNavigationController.navigationBar setBackgroundImage:NAVIGATION_BAR_IMAGE forBarMetrics:UIBarMetricsDefault];
    newsNavigationController.navigationBar.translucent = NO;
   // [newsNavigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeueCyr-Thin" size:22.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *tempHome = [NAVIGATION_BACK_BTN imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    [newsNavigationController.navigationBar setBackIndicatorImage:tempHome];
    [newsNavigationController.navigationBar setBackIndicatorTransitionMaskImage:tempHome];
    UIImage* homeImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"news" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* homeTabBarItem = [[UITabBarItem alloc] initWithTitle:@"IREORT" image:homeImage tag:100];
    newsNavigationController.tabBarItem = homeTabBarItem;
    
    //---------------- EXPANSE
    
    UIStoryboard *sbExpanse = [UIStoryboard storyboardWithName:@"expanse" bundle:nil];
    expanseNavigationController   = [sbExpanse instantiateInitialViewController];
    expanseNavigationController.navigationBarHidden = NO;
    [expanseNavigationController.navigationBar setBackgroundImage:NAVIGATION_BAR_IMAGE forBarMetrics:UIBarMetricsDefault];
    expanseNavigationController.navigationBar.translucent = NO;
   // [expanseNavigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeueCyr-Thin" size:22.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *tempPlace = [NAVIGATION_BACK_BTN imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    [expanseNavigationController.navigationBar setBackIndicatorImage:tempPlace];
    [expanseNavigationController.navigationBar setBackIndicatorTransitionMaskImage:tempPlace];
    UIImage* placeImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"expense" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* placeTabBarItem = [[UITabBarItem alloc] initWithTitle:@"RESOURCES" image:placeImage tag:101];
    expanseNavigationController.tabBarItem = placeTabBarItem;
    
    //---------------- SETTING
    
    UIStoryboard *sbSetting = [UIStoryboard storyboardWithName:@"setting" bundle:nil];
    settingNavigationController = [sbSetting instantiateInitialViewController];
    settingNavigationController.navigationBarHidden = NO;
    [settingNavigationController.navigationBar setBackgroundImage:NAVIGATION_BAR_IMAGE forBarMetrics:UIBarMetricsDefault];
    settingNavigationController.navigationBar.translucent = NO;
   // [settingNavigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeueCyr-Thin" size:22.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *tempBook = [NAVIGATION_BACK_BTN imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    [settingNavigationController.navigationBar setBackIndicatorImage:tempBook];
    [settingNavigationController.navigationBar setBackIndicatorTransitionMaskImage:tempBook];
    UIImage* bookmarkImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"settings" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* bookmarkTabBarItem = [[UITabBarItem alloc] initWithTitle:@"VIDEOS" image:bookmarkImage tag:102];
    settingNavigationController.tabBarItem = bookmarkTabBarItem;
    
    UIStoryboard *sbGallery= [UIStoryboard storyboardWithName:@"gallery" bundle:nil];
    galleryNavigationController = [sbGallery instantiateInitialViewController];
    galleryNavigationController.navigationBarHidden = NO;
    [settingNavigationController.navigationBar setBackgroundImage:NAVIGATION_BAR_IMAGE forBarMetrics:UIBarMetricsDefault];
    galleryNavigationController.navigationBar.translucent = NO;
    // [settingNavigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeueCyr-Thin" size:22.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *tempGallery = [NAVIGATION_BACK_BTN imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    [galleryNavigationController.navigationBar setBackIndicatorImage:tempGallery ];
    [galleryNavigationController.navigationBar setBackIndicatorTransitionMaskImage:tempGallery ];
    UIImage* galleryImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"settings" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* galleryTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Gallery" image:galleryImage tag:103];
    galleryNavigationController.tabBarItem = galleryTabBarItem ;

    
    
    
    if (!_tabBarController)
    {
        _tabBarController = [[UITabBarController alloc] init];
    }
    _tabBarController.delegate = self;
    [_tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];
    [_tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
    _tabBarController.viewControllers = @[tripNavigationController, newsNavigationController, expanseNavigationController, settingNavigationController, galleryNavigationController];
    _tabBarController.selectedIndex = 0;
    _window.rootViewController = _tabBarController;
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.test.identifier.WebServiceDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WebServiceDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WebServiceDemo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - networkcheck
-(BOOL) connectedToNetwork {
    // Create zero address
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags; BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags); CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Could not recover network reachability flags\n");
        return 0;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}
#pragma mark- ActivityIndicatorView

-(void)startAnimatingIndicatorView
{
    loaderView.hidden = NO;
    [self.window bringSubviewToFront:loaderView];
    [self performSelectorInBackground:@selector(startActivity)withObject:nil];
}


- (void) showLoaderView
{
    
    loaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kLoasderHeight)];
    loaderView.backgroundColor = [UIColor blackColor];
    [loaderView setAlpha:0.7];
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.hidesWhenStopped = YES;
    activityIndicatorView.frame = CGRectMake((loaderView.frame.size.width-37)/2, (loaderView.frame.size.height-37)/2, 37, 37);
    [loaderView addSubview: activityIndicatorView];
    
    [self.window addSubview:loaderView];
    loaderView.hidden = YES;
}
-(void)startActivity
{
    [activityIndicatorView startAnimating];
}

-(void)stopAnimatingIndicatorView
{
    [activityIndicatorView stopAnimating];
    loaderView.hidden = YES;
    
}
#pragma mark - ALERTMESSAGE

-(void)showAlertMessage:(NSString *)message tittle:(NSString *) tittle
{
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:tittle message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}
-(void)showAlertMessage:(NSString *)message tittle:(NSString *) tittle tag:(int)tagno
{
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:tittle message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    errorAlert.tag=tagno;
    [errorAlert show];
}
#pragma mark SetFont
-(UIFont*)setFont :(NSString*)name :(CGFloat)size{
    return [UIFont fontWithName:name size:size];
}
-(UIImage *) imageByScalingAndCroppingForSize:(UIImage *)inImage : (CGSize ) cropImageSize
{
   
    
    CGSize targetSize = cropImageSize;
    UIImage *sourceImage = inImage;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
    // UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        //NSLog(@"could not scale image");
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark Miscelleanous Method
-(NSMutableString*)base64forData:( __unsafe_unretained NSMutableData*)theData
{
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    __autoreleasing NSMutableString *base64Str = [[NSMutableString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    return  base64Str;
}


@end
