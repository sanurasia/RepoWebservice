//
//  AppDelegate.h
//  WebServiceDemo
//
//  Created by Sanjay Kumar on 02/12/14.
//  Copyright (c) 2014 Sanjay Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>{
    UIView *loaderView;
    UIActivityIndicatorView *activityIndicatorView;
    UINavigationController* tripNavigationController;
    UINavigationController *newsNavigationController;
    UINavigationController* expanseNavigationController;
    UINavigationController* settingNavigationController;
    UINavigationController* galleryNavigationController;

    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
-(void) callSignInView;
- (void)saveContext;
-(void) prepareTabbarController;
- (NSURL *)applicationDocumentsDirectory;
-(void)showAlertMessage:(NSString *)message tittle:(NSString *) tittle;
-(void)showAlertMessage:(NSString *)message tittle:(NSString *)tittle tag:(int)tagno;
-(NSString*)getTimeZone;
-(BOOL) connectedToNetwork;
-(void)startAnimatingIndicatorView;
-(void)stopAnimatingIndicatorView;
-(UIImage *) imageByScalingAndCroppingForSize:(UIImage *)inImage : (CGSize ) cropImageSize;
-(UIFont*)setFont :(NSString*)name :(CGFloat)size;
-(NSMutableString*)base64forData:( __unsafe_unretained NSMutableData*)theData;
@end
extern AppDelegate *appDelegate;

