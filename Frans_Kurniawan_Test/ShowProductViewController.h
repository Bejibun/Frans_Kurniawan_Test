//
//  ShowProductViewController.h
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowProductCell.h"

@interface ShowProductViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *productListColletions;
@property (strong, nonatomic) NSDictionary *productDict;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) UIViewController *fullScreenVC;
@property (strong, nonatomic) NSString *selectedTitle;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)deleteClicked:(id)sender;
- (IBAction)updateClicked:(id)sender;

@end
