//
//  ViewController.m
//  iOSTutorial
//
//  Created by Alejandro Pérez García on 16/04/12.
//  Copyright (c) 2012 Autentia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize magicButton = _magicButton;
@synthesize superImage = _superImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *buttonTitle = NSLocalizedString(@"Magic Button !!!", @"The title of the magic button");
    [_magicButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"prohibidos-monos-lagartos-300x300" ofType:@"gif"];
    _superImage.image = [UIImage imageWithContentsOfFile:imagePath];
}

- (void)viewDidUnload
{
    [self setMagicButton:nil];
    [self setSuperImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
