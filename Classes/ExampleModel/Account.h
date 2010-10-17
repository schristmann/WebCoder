//
//  Account.h
//  WebCoder
//
//  Created by Sean Christmann on 10/11/10.
//

#import <Foundation/Foundation.h>

@class Transaction;

@interface Account : NSObject<NSCoding> {
	NSString		*_name;
	NSInteger		_index;
	NSDecimalNumber	*_balance;
	BOOL			_active;
	Transaction		*_lastTransaction;
}
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, copy) NSDecimalNumber *balance;
@property(nonatomic, assign) BOOL active;
@property(nonatomic, retain) Transaction *lastTransaction;

@end
