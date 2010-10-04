//
//  I7BackButtonNavigationItemAppDelegate.h
//  I7BackButtonNavigationItem
//
//  Created by Jonas Schnelli on 04.10.10.
//  Copyright 2010 include7 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface I7BackButtonNavigationItemAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

