//
//  AccountOverview.h
//  WebCoder
//
//  Created by Sean Christmann on 10/11/10.
//

#import <Foundation/Foundation.h>

@interface AccountOverview : NSObject<NSCoding> {
	NSString	*_accountHolder;
	NSArray		*_accounts;
	NSDate		*_timeStamp;
}
@property(nonatomic, copy) NSString *accountHolder;
@property(nonatomic, retain) NSArray *accounts;
@property(nonatomic, retain) NSDate *timeStamp;

@end
