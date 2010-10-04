//
//  I7BackButtonNavigationItem.h
//  include7 AG
//
//  Created by Jonas Schnelli on 01.10.10.
//  Copyright 2010 include7 AG. All rights reserved.
//

#import <Foundation/Foundation.h>


/* styles */
enum I7BackButtonNavigationItemStyle {
	I7BackButtonNavigationItemStyleBlack,
	I7BackButtonNavigationItemStyleDefault,
};

/* the important view, could also be done as a UIBotton subclass */
@interface I7BackButtonNavigationItemView : UIView {
	NSObject *delegate;
	BOOL active;
	NSString *text;
	enum I7BackButtonNavigationItemStyle i7style;
}
@property (assign) enum I7BackButtonNavigationItemStyle i7style;
@property (nonatomic, retain) NSObject *delegate;
@property (nonatomic, retain) NSString *text;
@end


/* the custom UIBarButtonItem subclass */
@interface I7BackButtonNavigationItem : UIBarButtonItem {
	I7BackButtonNavigationItemView *customView;
	UIButton *button;
}

@property (assign) enum I7BackButtonNavigationItemStyle i7style;

- (id)initWithTitle:(NSString *)title style:(enum I7BackButtonNavigationItemStyle)style target:(id)target action:(SEL)action;

@end

