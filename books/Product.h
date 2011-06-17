

@interface Product : NSObject {
	NSString *title;
	NSArray *author;
    NSString *publisher;
    NSString *url;
    NSString *identifier;
}

@property (nonatomic, copy) NSString *title, *publisher;
@property (nonatomic, copy) NSArray *author;
@property (nonatomic, copy) NSString *url, *identifier;

+ (id)productWithType:(NSString *)title author:(NSArray *)author publisher:(NSString *)publisher url:(NSString*)url identifier:(NSString*)identifier;

@end
