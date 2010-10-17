//
//  Transaction.m
//  WebCoder
//
//  Created by Sean Christmann on 10/11/10.
//

#import "Transaction.h"
#import "WebCoder.h"

@implementation Transaction

@synthesize amount = _amount;
@synthesize date = _date;

- (id)initWithCoder:(NSCoder<WebCoder>*)coder {
	if (self = [super init]) {
		self.amount	= [coder decodeDoubleForKey:@"amount"];
		self.date	= [coder decodeDateForKey:@"date"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
}

- (void) dealloc {
	self.date = nil;
	[super dealloc];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<Transaction: amount = %f, date = %@>",
			self.amount,
			self.date
			];
}

@end
