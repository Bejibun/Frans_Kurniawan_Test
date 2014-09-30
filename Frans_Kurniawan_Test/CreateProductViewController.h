//
//  CreateProductViewController.h
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHandler.h"

@interface CreateProductViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) NSString *initialPickerRow;

@property (strong, nonatomic) IBOutlet UITextField *productName;
@property (strong, nonatomic) IBOutlet UITextView *desctiptionText;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSMutableDictionary *tempDict;

- (IBAction)doneBtn:(id)sender;

@end
