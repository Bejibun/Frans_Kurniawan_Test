//
//  ViewController.m
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import "ViewController.h"
#import "CreateProductViewController.h"
#import "ShowProductViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createProductTapped:(id)sender {
    NSLog(@"Create Product Form is called");
    
    //Open Create Product VC
    CreateProductViewController *createProductVC = [[CreateProductViewController alloc]initWithNibName:@"CreateProductViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:createProductVC animated:YES];
}

- (IBAction)showProductTapped:(id)sender
{
    NSLog(@"Show Product Table View");
    
    //Open Show Product VC
    ShowProductViewController *showProductVC = [[ShowProductViewController alloc]initWithNibName:@"ShowProductViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:showProductVC animated:YES];
}
@end
