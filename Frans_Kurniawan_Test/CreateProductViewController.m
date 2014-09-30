//
//  CreateProductViewController.m
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import "CreateProductViewController.h"
#import "AppDelegate.h"
#define KEYBOARD_HEIGHT 216.0f

@interface CreateProductViewController ()
{
    NSInteger currentPicked;
    UIButton *doneBtn;
}
@end

@implementation CreateProductViewController
@synthesize pickerView,desctiptionText,productName,pickerArray,initialPickerRow,tempDict;

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
    
    //Setup Picker View
    [self populatePickerView];
}

- (void)populatePickerView
{
    NSLog(@"Populate Picker View");
    NSString *assetPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingString:@"/Assets"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    pickerArray = [fileManager contentsOfDirectoryAtPath:assetPath error:nil];
    
    
    //Load current Content if it's from update
    if (AppDel.fromUpdate) {
        [self loadCurrentContent];
        AppDel.fromUpdate = NO;
    }
}

-(void)loadCurrentContent
{
    //Load TextField Contents
    productName.text = [tempDict objectForKey:@"productid"];
    desctiptionText.text = [tempDict objectForKey:@"description"];
    
    //Load Picker View
    NSInteger pickerInit = [pickerArray indexOfObject:[tempDict objectForKey:@"imagepath"]];
    [pickerView selectRow:pickerInit inComponent:0 animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //Dismiss Keyboard
    [productName resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([DataHandler isDuplicateFileName:textField.text]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Found Duplication"
                                                          message:@"Change to other name or it will replace automatically"
                                                         delegate:nil
                                                cancelButtonTitle:@"Okay"
                                                otherButtonTitles:nil];
        
        [message show];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //Add Done Button if Text View begins editting
    NSLog(@"Show Done Button");
    doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-KEYBOARD_HEIGHT-50, self.view.frame.size.width, 50)];
    doneBtn.backgroundColor = [UIColor lightGrayColor];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [self.view addSubview:doneBtn];
    [doneBtn addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    
    //Remove Done Button after finish fill the description
    [doneBtn removeFromSuperview];
    return YES;
}

-(void)dismissKeyboard:(id)sender
{
    [sender removeFromSuperview];
    [desctiptionText resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma PickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //Show Content to Picker View
    NSString *title = @"";
    
    
    //Get the content for Picker View
    title = [pickerArray objectAtIndex:row];
    title = [title stringByDeletingPathExtension];
    
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    currentPicked = row;
}

- (IBAction)doneBtn:(id)sender
{
    //Done Creating Product List
    NSLog(@"Product list is created");
    
    ProductList *pL = [[ProductList alloc]init];
    pL.productID = productName.text;
    pL.productDescription = desctiptionText.text;
    pL.productImage = [pickerArray objectAtIndex:currentPicked];
    
    [DataHandler saveDataToDisk:pL];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
