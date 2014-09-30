//
//  ProductList.h
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductList : NSObject

@property (strong, nonatomic) NSString *productID;
@property (strong, nonatomic) NSString *productDescription;
@property (strong, nonatomic) NSString *productImage;

+ (NSDictionary*) createDictionaryFromProductList:(ProductList*)productList;

@end
