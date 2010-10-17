//
//  JSONCoder.m
//  WebCoder
//
//  Created by Sean Christmann on 10/11/10.
//  Copyright 2010 craftymind.com. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "JSONUnarchiver.h"

static NSString *ISO8601 = @"yyyy-MM-dd'T'HH:mm:ss";

@implementation JSONUnarchiver

-(id) initWithDictionary:(NSDictionary*)dict {
	if (self = [super init]){
		dictionary = [dict retain];
	}
	return self;
}
+(id) unarchiverWithDictionary:(NSDictionary*)dict {
	JSONUnarchiver *unarch = [[JSONUnarchiver alloc] initWithDictionary:dict];
	return [unarch autorelease];
}

- (BOOL) decodeBoolForKey:(NSString *)key {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return NO;
	}
	return [(NSNumber*)val boolValue];
}

- (NSInteger) decodeIntegerForKey:(NSString *)key {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return 0;
	}
	return [(NSNumber*)val integerValue];
}

- (double) decodeDoubleForKey:(NSString *)key {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return 0.00;
	}
	return [(NSNumber*)val doubleValue];
}

- (NSObject*) decodeObjectForKey:(NSString *)key {
	NSObject *val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return nil;
	}
	return val;
}

- (NSDate*) decodeDateForKey:(NSString *)key {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return nil;
	}
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:ISO8601];
    NSDate *date = [dateFormatter dateFromString:(NSString*)val];
	[dateFormatter release];
	return date;
}

- (NSDecimalNumber*) decodeNumberForKey:(NSString *)key {
	return [self decodeObjectForKey:key];
}

- (id) decodeObjectForKey:(NSString *)key ofType:(Class)clazz {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return nil;
	}
	JSONUnarchiver *unarch = [JSONUnarchiver unarchiverWithDictionary:(NSDictionary*)val];
	NSObject *obj = [(<NSCoding>)[clazz alloc] initWithCoder:unarch];
	return [obj autorelease];
}

- (NSArray*) decodeArrayForKey:(NSString *)key ofType:(Class)clazz {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return nil;
	}
	NSMutableArray* m_arr = [NSMutableArray array];	
	for (NSDictionary *dict in (NSArray*)val) {
		JSONUnarchiver *unarch = [JSONUnarchiver unarchiverWithDictionary:dict];
		NSObject *obj = [(<NSCoding>)[clazz alloc] initWithCoder:unarch];
		[m_arr addObject:obj];
		[obj release];
	}
	return m_arr;	
}

- (void) dealloc {
	[dictionary release];
	[super dealloc];
}

@end
