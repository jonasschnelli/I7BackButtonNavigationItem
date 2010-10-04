//
//  RootViewController.m
//  I7BackButtonNavigationItem
//
//  Created by Jonas Schnelli on 04.10.10.
//  Copyright 2010 include7 AG. All rights reserved.
//

#import "RootViewController.h"
#import "I7BackButtonNavigationItem.h"

@implementation RootViewController


- (void) viewDidLoad {
	if(![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
		I7BackButtonNavigationItem *backButton = [[I7BackButtonNavigationItem alloc] initWithTitle:@"Custom Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonTapped) ];
		self.navigationItem.leftBarButtonItem = backButton;
		[backButton release];
	}
}

- (void)backButtonTapped {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"sure?" message:@"wanna go back?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alert show];
	[alert release];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 1) {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = @"Click me";
    
	// Configure the cell.

    return cell;
}



- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	NSLog(@"%@", self.navigationController.viewControllers);
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	RootViewController *anotherController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
	[self.navigationController pushViewController:anotherController animated:YES];
	[anotherController release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}



- (void)dealloc {
    [super dealloc];
}


@end

