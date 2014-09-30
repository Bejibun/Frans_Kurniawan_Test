//
//  ShowProductViewController.m
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import "ShowProductViewController.h"
#import "CreateProductViewController.h"
#import "AppDelegate.h"

@interface ShowProductViewController ()

@end

@implementation ShowProductViewController
{
    float offset;
}

@synthesize productDict,productListColletions,tblView,fullScreenVC,selectedTitle,deleteBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UINib *nib = [UINib nibWithNibName:@"ShowProductCell" bundle:nil];
    [[self tblView] registerNib:nib forCellReuseIdentifier:@"productcell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchJSONInformation
{
    NSString *documentsDirectory = [NSHomeDirectory()
                                    stringByAppendingPathComponent:@"Documents"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    productListColletions = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
}

-(NSDictionary *)getContent:(NSString *)fileName
{
    NSError* error = nil;
    
    NSString *documentsDirectory = [NSHomeDirectory()
                                    stringByAppendingPathComponent:@"Documents"];
    
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:fileName];
    
    NSString* json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if ([self isStringEmpty:json])
    {
        if (error != nil)
        {
            NSLog(@"** Error getting file: %@", [error localizedDescription]);
        }
    }
    else
    {
        return [self parseJSONFromString:json];
    }
    
    return nil;
}

- (NSDictionary*)parseJSONFromString:(NSString*)jsonString
{
    NSError* error = nil;
    
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (jsonDict == nil)
    {
        NSLog(@"WARNING: Something went wrong; could not Deserialize JSON!");
        
        if (error != nil)
            NSLog(@"ERROR: %@", [error localizedDescription]);
    }
    
    return jsonDict;
}

- (BOOL) isStringEmpty:(NSString *)string
{
    if([string length] == 0)
    {
        //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

-(void)showFullScreen:(UITapGestureRecognizer*)sender
{
    NSLog(@"Show Full Screen");
    
    //Use New View Controller instead of addSubView to make sure it's working everytime
    fullScreenVC = [[UIViewController alloc]init];
    
    fullScreenVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    UIImageView *tempImage = [[UIImageView alloc]initWithImage:[(UIImageView*)sender.view image]];
    
    tempImage.backgroundColor = [UIColor whiteColor];
    
    tempImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    tempImage.contentMode = UIViewContentModeScaleToFill;
    
    UITapGestureRecognizer *exitTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitFullScreen:)];
    
    [fullScreenVC.view addGestureRecognizer:exitTapGesture];
    
    [fullScreenVC.view addSubview:tempImage];
    [self presentViewController:fullScreenVC animated:YES completion:nil];
}

-(void)exitFullScreen:(UITapGestureRecognizer *)sender
{
    //exit Full Screen
    NSLog(@"Exit Full Screen");
    [fullScreenVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    offset = scrollView.contentOffset.y;
}

-(void)animateToWallet
{
    //Animate the cell to be deleted
    UITableViewCell * aCell = [tblView cellForRowAtIndexPath:[tblView indexPathForSelectedRow]];
    UIGraphicsBeginImageContext(aCell.frame.size);
    [aCell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *aCellImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * imageView = [[UIImageView alloc] initWithImage:aCellImage];
    
    imageView.frame = CGRectMake(aCell.frame.origin.x, aCell.frame.origin.y-offset, aCell.frame.size.width, aCell.frame.size.height);
    [self.view addSubview:imageView];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        imageView.frame = CGRectMake(deleteBtn.frame.size.width/2, self.view.superview.frame.size.height-deleteBtn.frame.size.height/2, 0, 0);
    }];
}

-(void)NoSelectionAlert
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Nothing is selected"
                                                      message:@"Select one of the cell you want to delete"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

-(void)deleteInDocumentsFile
{
    NSString *pathToFile = [[NSHomeDirectory()
                             stringByAppendingPathComponent:@"Documents"] stringByAppendingString:[NSString stringWithFormat:@"/%@.json",selectedTitle]];
    
    [[NSFileManager defaultManager] removeItemAtPath: pathToFile error: nil];
}


- (IBAction)deleteClicked:(id)sender {
    
    UITableViewCell * aCell = [tblView cellForRowAtIndexPath:[tblView indexPathForSelectedRow]];
    if (!aCell) {
        [self NoSelectionAlert];
    }
    else
    {
        NSLog(@"Cell Deleted");
        [self animateToWallet];
        
        [self deleteInDocumentsFile];
        
        //Reload the tableView after remove the content.
        [tblView reloadData];
    }
}

- (IBAction)updateClicked:(id)sender {
    
    NSLog(@"Update Cell Selected");
    ShowProductCell * aCell = (ShowProductCell*)[tblView cellForRowAtIndexPath:[tblView indexPathForSelectedRow]];
    if (!aCell) {
        [self NoSelectionAlert];
    }
    else
    {
        AppDel.fromUpdate = YES;
        
        CreateProductViewController *updateProductVC = [[CreateProductViewController alloc]initWithNibName:@"CreateProductViewController" bundle:[NSBundle mainBundle]];
        
        updateProductVC.tempDict = [[NSMutableDictionary alloc]init];
        
        [updateProductVC.tempDict setObject:aCell.titleCell.text forKey:@"productid"];
        [updateProductVC.tempDict setObject:aCell.descriptionText.text forKey:@"description"];
        [updateProductVC.tempDict setObject:aCell.imgView.accessibilityIdentifier forKey:@"imagepath"];
        
        [self.navigationController pushViewController:updateProductVC animated:YES];
        
        [self deleteInDocumentsFile];
    
    }
}

#pragma TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //get total rows
    [self fetchJSONInformation];
    return [productListColletions count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Populate Table
    NSLog(@"Populate Table");
    static NSString *CellIdentifier = @"productcell";
    ShowProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShowProductCell" owner:self options:nil][0];
    }
    
    
    //Get dictionary and populate into the table
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = [self getContent:productListColletions[indexPath.row]];
    NSLog(@"%@",[dict objectForKey:@"productid"]);
    [cell.titleCell setText:[dict objectForKey:@"productid"]];
    [cell.descriptionText setText:[dict objectForKey:@"description"]];
    [cell.imgView setImage:[UIImage imageWithContentsOfFile:[dict objectForKey:@"imagepath"]]];
    
    
    //Set accessibility to the image same as adding a tag to image
    NSString *imageName = [[dict objectForKey:@"imagepath"]lastPathComponent];
    [cell.imgView setAccessibilityIdentifier:imageName];
    
    
    //Add tap Gesture to show a fullscreen image.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showFullScreen:)];
    [cell.imgView addGestureRecognizer:tapGesture];
    cell.imgView.userInteractionEnabled = YES;
    
    
    
    //Allow cell to be selected
    cell.userInteractionEnabled = YES;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell Selected");
    ShowProductCell *cell = (ShowProductCell*)[tblView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"%@", cell.titleCell.text);
    selectedTitle = cell.titleCell.text;
}

@end
