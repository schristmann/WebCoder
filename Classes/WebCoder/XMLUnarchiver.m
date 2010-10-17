//
//  XMLUnarchiver.m
//  WebCoder
//
//  Created by Sean Christmann on 10/14/10.
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

#import "XMLUnarchiver.h"
#import "CXMLNode.h"
#import "CXMLElement.h"

static NSString *ISO8601 = @"yyyy-MM-dd'T'HH:mm:ss";

@implementation XMLUnarchiver

-(id) initWithNode:(CXMLNode*)xmlNode {
	if (self = [super init]){
		node = [xmlNode retain];
	}
	return self;
}
+(id) unarchiverWithNode:(CXMLNode*)xmlNode {
	XMLUnarchiver *unarch = [[XMLUnarchiver alloc] initWithNode:xmlNode];
	return [unarch autorelease];
}

- (BOOL) decodeBoolForKey:(NSString *)key {
	CXMLNode *child = [self nodeForKey:key];
	if (child == nil) {
		return NO;
	}
	NSString *val = [child stringValue];
	if ([val isEqualToString:@"true"] || [val isEqualToString:@"TRUE"]) {
		return YES;
	}
	return NO;
}

- (NSInteger) decodeIntegerForKey:(NSString *)key {
	NSDecimalNumber *num = [self decodeNumberForKey:key];
	if (num == nil) {
		return 0;
	}
	return [num integerValue];
}

- (double) decodeDoubleForKey:(NSString *)key {
	NSDecimalNumber *num = [self decodeNumberForKey:key];
	if (num == nil) {
		return 0;
	}
	return [num doubleValue];
}

- (NSObject*) decodeObjectForKey:(NSString *)key {
	CXMLNode *child = [self nodeForKey:key];
	if (child == nil) {
		return nil;
	}
	return [child stringValue];
}

- (NSDate*) decodeDateForKey:(NSString *)key {
	CXMLNode *child = [self nodeForKey:key];
	if (child == nil) {
		return 0;
	}
	NSString *val = [child stringValue];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:ISO8601];
    NSDate *date = [dateFormatter dateFromString:val];
	[dateFormatter release];
	return date;
}

- (NSDecimalNumber*) decodeNumberForKey:(NSString *)key {
	CXMLNode *child = [self nodeForKey:key];
	if (child == nil) {
		return nil;
	}
	NSString *val = [child stringValue];
	return [NSDecimalNumber decimalNumberWithString:val];
}

- (id) decodeObjectForKey:(NSString *)key ofType:(Class)clazz {
	CXMLNode *child = [self nodeForKey:key];
	if (child == nil) {
		return nil;
	}
	XMLUnarchiver *unarch = [XMLUnarchiver unarchiverWithNode:child];
	NSObject *obj = [(<NSCoding>)[clazz alloc] initWithCoder:unarch];
	return [obj autorelease];
}

- (NSArray*) decodeArrayForKey:(NSString *)key ofType:(Class)clazz {
	CXMLNode *child = [self nodeForKey:key];
	if (child == nil) {
		return nil;
	}
	NSMutableArray* m_arr = [NSMutableArray array];
	NSArray *children = [child children];
	for (int i=1; i<children.count; i+=2) {
		CXMLNode *innerChild = [children objectAtIndex:i];
		XMLUnarchiver *unarch = [XMLUnarchiver unarchiverWithNode:innerChild];
		NSObject *obj = [(<NSCoding>)[clazz alloc] initWithCoder:unarch];
		[m_arr addObject:obj];
		[obj release];
	}
	return m_arr;	
}




// Gets the child attribute or node
- (CXMLNode*) nodeForKey:(NSString*) key {
	CXMLNode* child = nil;
	if([node isKindOfClass: [CXMLElement class]]) {
		child = [(CXMLElement*)node attributeForName: key];
		if(child != nil) {
			return child;
		}
	}
	for(child in [node children]) {
		NSString *lname = [child name];
		if([lname isEqualToString:key]){
			return child;
		}
	}
	return nil;
}

@end
