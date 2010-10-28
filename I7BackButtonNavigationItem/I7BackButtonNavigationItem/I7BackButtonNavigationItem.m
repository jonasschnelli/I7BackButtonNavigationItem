//
//  I7BackButtonNavigationItem.m
//  include7 AG
//
//  Created by Jonas Schnelli on 01.10.10.
//  Copyright 2010 include7 AG. All rights reserved.
//

#import "I7BackButtonNavigationItem.h"



@implementation I7BackButtonNavigationItem

@synthesize i7style;

/* overwrite the init methode */
- (id)initWithTitle:(NSString *)title style:(enum I7BackButtonNavigationItemStyle)style target:(id)target action:(SEL)action {
	[customView release];
	customView = [[I7BackButtonNavigationItemView alloc] initWithTitle:title];
	customView.delegate = self;
	
	self = [super initWithCustomView:customView];
	if (self != nil) {
		self.target = target;
		self.action = action;
		
		/* apply the custom style */
		customView.i7style = style;
		customView.text = title;
	}
	return self;
}

/* send the right message */
- (void)touchEnded {
	if(self.target && self.action) {
		[self.target performSelector:self.action];
	}
}

- (void) dealloc
{
	[customView release];
	[super dealloc];
}



@end

/* view subclass for displaying the backbutton */
@implementation I7BackButtonNavigationItemView
@synthesize delegate, text, i7style;

- (id) initWithTitle:(NSString *)title
{
	
	/* TODO */
	/* the size-definition of the view could be better */
	self = [super initWithFrame:CGRectMake(0,0,120,30)];
	if (self != nil) {
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void) drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextTranslateCTM(context, 0.0, self.frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

	/* get the state */
	NSString *state = @"inactive";
	if(active) {
		state = @"active";
	}
	
	/* work with style */
	/* TODO: add tint-based styles */
	
	NSString *style = @"black";
	if(self.i7style != I7BackButtonNavigationItemStyleBlack) {
		NSLog(@"other styles are not supported right now!");
	}

	CGImageRef leftPart = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_left.png", style, state]].CGImage;
	CGImageRef middlePart = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_middle.png", style, state]].CGImage;
	CGImageRef rightPart = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_right.png", style, state]].CGImage;

	
	/* calculate text length */
	CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
	CGContextSelectFont(context, "Helvetica Bold", 12.0, kCGEncodingMacRoman);	
	CGContextSetTextDrawingMode(context, kCGTextInvisible);
	CGContextShowTextAtPoint(context, 11.0, 11.0, [self.text cStringUsingEncoding:NSMacOSRomanStringEncoding], self.text.length);
	CGPoint point = CGContextGetTextPosition(context);
	
	CGFloat width = round(point.x)-10;
	
	/* draw images */
	CGContextDrawImage(context, CGRectMake(0,0,14,30), leftPart);
	CGContextDrawImage(context, CGRectMake(14,0,width,30), middlePart);
	CGContextDrawImage(context, CGRectMake(14+width,0,5,30), rightPart);
	
	/* draw text */
	CGContextSetTextDrawingMode(context, kCGTextFill);
	CGContextShowTextAtPoint(context, 11.0, 11.0, [text cStringUsingEncoding:NSMacOSRomanStringEncoding], text.length);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	active = YES;
	[self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	active = NO;
	[self setNeedsDisplay];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	/* loop throught the event */
	if(delegate && [delegate respondsToSelector:@selector(touchEnded)]) {
		[delegate performSelector:@selector(touchEnded)];
	}
	active = NO;
	[self setNeedsDisplay];
}

@end