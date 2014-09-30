//
//  DataHandler.h
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductList.h"

@interface DataHandler : NSObject

+ (void) saveDataToDisk:(ProductList*)productList;

+ (BOOL) isDuplicateFileName:(NSString*)fileName;

@end
