//
//  Account.m
//  WebCoder
//
//  Created by Sean Christmann on 10/11/10.
//

#import "Account.h"
#import "WebCoder.h"
#import "Transaction.h"

@implementation Account

@synthesize name = _name;
@synthesize index = _index;
@synthesize balance = _balance;
@synthesize active = _active;
@synthesize lastTransaction = _lastTransaction;

- (id)initWithCoder:(NSCoder<WebCoder>*)coder {
	if (self = [super init]) {
		self.name				= [coder decodeObjectForKey:@"name"];
		self.index				= [coder decodeIntegerForKey:@"index"];
		self.balance			= [coder decodeNumberForKey:@"balance"];
		self.active				= [coder decodeBoolForKey:@"active"];
		self.lastTransaction	= [coder decodeObjectForKey:@"lastTransaction" ofType:[Transaction class]];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
}

- (void) dealloc {
	self.name = nil;
	self.balance = nil;
	self.lastTransaction = nil;
	[super dealloc];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<Account: name = %@, index = %i, balance = %@, active = %i, lastTransaction = %@>",
			self.name,
			self.index,
			self.balance,
			self.active,
			self.lastTransaction
			];
}

@end
