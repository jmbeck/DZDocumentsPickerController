
//  Created by Ignacio Romero Zurbuchen on 10/14/11.
//  Copyright (c) 2011 DZen Interaktiv. All rights reserved.
//

#import "NSMutableArray+DZEN.h"

@implementation NSMutableArray (DZEN)

-(id)safeObjectAtIndex:(NSUInteger)index
{
    //DLog(@"safeObjectAtIndex: %d",index);
    
    if ([self count] > 0) return [self objectAtIndex:index];
    else return nil;
    
    /*
    @try {
        return [self objectAtIndex:index];
    } 
    @catch (id theException) {
        DLog(@"*** safeObjectAtIndex exception: %@", theException);
        return nil;
    }
     */
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if (to != from)
    {
        id obj = [self safeObjectAtIndex:from];
        [self removeObjectAtIndex:from];
        
        if (to >= [self count]) [self addObject:obj];
        else [self insertObject:obj atIndex:to];
    }
}

- (void)saveArrayToFile:(NSString *)filename;
{
    NSString *path = [NSString getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist",filename]];
    //DLog(@"saveArrayToFile : %@",path);
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (NSMutableArray *)loadArrayfromFile:(NSString *)fileName
{
    NSString *path = [NSString getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist",fileName]];
    //DLog(@"loadArrayfromFile : %@",path);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
