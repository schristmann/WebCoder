//
//  AccountOverview.m
//  WebCoder
//
//  Created by Sean Christmann on 10/11/10.
//

#import "AccountOverview.h"
#import "WebCoder.h"
#import "Account.h"

@implementation AccountOverview

@synthesize accountHolder = _accountHolder;
@synthesize accounts = _accounts;
@synthesize timeStamp = _timeStamp;

- (id)initWithCoder:(NSCoder<WebCoder>*)coder {
	if (self = [super init]) {
		self.accountHolder	= [coder decodeObjectForKey:@"accountHolder"];
		self.accounts		= [coder decodeArrayForKey:@"accounts" ofType:[Account class]];
		self.timeStamp		= [coder decodeDateForKey:@"timeStamp"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
}

- (void) dealloc {
	self.accountHolder = nil;
	self.accounts = nil;
	self.timeStamp = nil;
	[super dealloc];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<AccountOverview: accountHolder = %@, accounts = %@, timeStamp = %@>",
			self.accountHolder,
			self.accounts,
			self.timeStamp
			];
}

@end
