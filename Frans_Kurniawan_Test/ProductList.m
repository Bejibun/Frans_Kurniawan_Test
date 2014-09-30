//
//  ProductList.m
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import "ProductList.h"

@implementation ProductList
@synthesize productDescription,productID,productImage;

+ (NSDictionary*) createDictionaryFromProductList:(ProductList*)productList
{
    //Create Dictionary for the product List
    NSLog(@"Create Dictionary from Produt List");
    NSString* ID = [NSString stringWithString:productList.productID];
    NSString* desc = [NSString stringWithString:productList.productDescription];
    NSString* imagePath = [[[NSBundle mainBundle]resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/Assets/%@",productList.productImage]];

    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:ID forKey:@"productid"];
    [dict setObject:desc forKey:@"description"];
    [dict setObject:imagePath forKey:@"imagepath"];
    
    return dict;
}

@end
