//
//  NSDictionary+CreateJson.m
//  Shipper
//
//  Created by QUIKHOP on 7/27/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "NSDictionary+CreateJson.h"

@implementation NSDictionary(CreateJson)

-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
