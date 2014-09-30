//
//  DataHandler.m
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import "DataHandler.h"

@implementation DataHandler

+ (void)saveDataToDisk:(ProductList*)productList
{
    NSLog(@"Save Data to disk");
    
    //Save to disk locally
    NSDictionary* dict = [ProductList createDictionaryFromProductList:productList];
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];

    //Replace with layername
    [self writeJSONToFile:jsonData fileName:[NSString stringWithFormat:@"%@.json", productList.productID]];

    if (jsonData == nil)
    {
        if (error != nil)
        {
            NSLog(@"** Error: %@", [error localizedDescription]);
        }
    }
}

+ (void)writeJSONToFile:(NSData*)jsonData fileName:(NSString*)fileName
{
    
    NSError *error = nil;
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // Write to the file
    BOOL success = [jsonString writeToFile:filePath atomically:YES
                                  encoding:NSUTF8StringEncoding error:&error];
    
    if (!success)
    {
        if (error != nil)
        {
            NSLog(@"** Error writing file: %@", error);
            NSLog(@"** Error reason: %@", [error localizedFailureReason]);
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Save Error"
                                                              message:[error localizedDescription]
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [message show];
        }
    }
    else
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Created Successful"
                                                          message:@"Product is created"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
    }

}

+ (BOOL) isDuplicateFileName:(NSString*)fileName
{
    
    //Check if the name is duplicated
    NSLog(@"Check on duplication");
    
    NSError* error = nil;
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    fileName = [NSString stringWithFormat:@"%@%@",fileName, @".json"];
    
    
    
    for (int count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", count, [directoryContent objectAtIndex:count]);
        NSString* fName = (NSString*)[directoryContent objectAtIndex:count];
        
        
        
        if ([fileName isEqualToString:fName])
        {
            return YES;
        }
    }
    
    return NO;
}



@end
