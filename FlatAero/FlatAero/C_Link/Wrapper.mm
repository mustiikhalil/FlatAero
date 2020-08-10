//
//  Wrapper.m
//  FlatAero
//
//  Created by Mustafa Khalil on 3/1/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

#import "Wrapper.h"
#import "flat.h"
#import <Foundation/Foundation.h>

@implementation Wrapper
- (NSString *) printJSONFromBuffer:(uint8_t [])buf from:(NSString *)table error:(NSError**)error {
    std::string _table = std::string([table UTF8String]);
    try {
        flat::JSON flat(_table);
        return [NSString stringWithCString: flat.parse(buf).c_str()
                                  encoding: [NSString defaultCStringEncoding]];
    } catch (const char* err) {
        NSString *errorMessage = [NSString stringWithCString:err
                                                    encoding:[NSString defaultCStringEncoding]];
        
        *error = [NSError errorWithDomain:errorMessage code:300 userInfo:NULL];
    }
    return @"";
}

- (NSString *) printFLATFromBuffer:(uint8_t [])buf from:(NSString *)table error:(NSError**)error {
    std::string _table = std::string([table UTF8String]);
    try {
        flat::FLAT flat(_table);
        return [NSString stringWithCString: flat.parse(buf).c_str()
                                  encoding: [NSString defaultCStringEncoding]];
    } catch (const char* err) {
        NSString *errorMessage = [NSString stringWithCString:err
                                                    encoding:[NSString defaultCStringEncoding]];
        
        *error = [NSError errorWithDomain:errorMessage code:300 userInfo:NULL];
    }
    return @"";
}
@end
