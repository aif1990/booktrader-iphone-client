

#import "Product.h"

@implementation Product

@synthesize title, author, publisher, url, identifier;


+ (id)productWithType:(NSString *)title author:(NSArray *)author publisher:(NSString *)publisher url:(NSString *)url identifier:(NSString *)identifier
{
	Product *newProduct = [[[self alloc] init] autorelease];
	newProduct.title = title;
	newProduct.author = author;
    newProduct.publisher = publisher;
    newProduct.url = url;
    newProduct.identifier = identifier;
	return newProduct;
}


- (void)dealloc
{
	[title release];
	[author release];
    [publisher release];
    [url release];
    [identifier release];
	[super dealloc];
}

@end
