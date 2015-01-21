#import <AppKit/AppKit.h>

static NSString *g_text_uti = @"public.utf8-plain-text";

// Returns zero on success, non zero on failure.
int genieosMacosxNimRecycle(const char *filename)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSString *path = [[NSString alloc] initWithUTF8String:filename];
	NSString *folder = [path stringByDeletingLastPathComponent];
	NSArray *files = [NSArray arrayWithObject:[path lastPathComponent]];
	[path release];

	NSInteger tag = 0;
	const BOOL ret = [[NSWorkspace sharedWorkspace]
		performFileOperation:NSWorkspaceRecycleOperation
		source:folder destination:nil files:files tag:&tag];
	[pool release];

	if (tag < 0)
		return tag;
	else if (ret == NO)
		return 1;
	else
		return 0;
}

// Plays a standard error beep, the sound won't be heard if the process exits.
void genieosMacosxBeep()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSBeep(); // Seems to take 150ms to play fully.
	[pool release];
}

// Returns -1 on failure, or length of the sound which started to play.
double genieosMacosxPlayAif(const char *filename)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSString *path = [[NSString alloc] initWithUTF8String:filename];
	NSSound *sound = [[NSSound alloc]
		initWithContentsOfFile:path byReference:YES];
	[path release];

	if (!sound) {
		[pool release];
		return -1;
	}

	const double ret = [sound duration];
	[sound play];
	[sound autorelease];
	[pool release];
	return ret;
}


// Stores the global pateboard.
static NSPasteboard *g_pasteboard = nil;

/// Initializes the global pasteboard object if previously nil.
static void init_pasteboard()
{
	if (g_pasteboard)
		return;
	g_pasteboard = [[NSPasteboard pasteboardWithName:NSGeneralPboard] retain];
}

/** Gets the current string and strdups it.
 *
 * Future calls to the function will free the string and alloc a new one.
 */
char *genieosMacosxClipboardString(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	static char *ret = 0;

	free(ret);
	ret = 0;

	if (!g_pasteboard)
		init_pasteboard();
	if (!g_pasteboard) {
		//printf("Error getting pasteboard!");
		goto exit;
	}

	static NSDictionary *options = nil;
	if (!options)
		options = [[NSDictionary dictionaryWithObject:g_text_uti
			forKey:NSPasteboardURLReadingContentsConformToTypesKey] retain];
	if (!options) {
		//printf("Error allocating options dictionary!");
		goto exit;
	}

	NSArray *classes = [[NSArray alloc] initWithObjects:[NSString class], nil];
	NSArray *copiedItems = [g_pasteboard readObjectsForClasses:classes
		options:nil];

	if ([copiedItems count]) {
		NSString *text = [copiedItems objectAtIndex:0];
		const char *c_string = [text UTF8String];
		if (c_string)
			ret = strdup(c_string);
	}

exit:
	[pool release];
	return ret;
}

/// Returns the current clipboard change value.
int genieosMacosxClipboardChange(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	if (!g_pasteboard)
		init_pasteboard();

	int ret = -1;
	if (g_pasteboard)
		ret = [g_pasteboard changeCount];

	[pool release];
	return ret;
}

/// Replaces the current clipboard with the provided utf8 string.
void genieosMacosxSetClipboardString(const char *text)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	if (!g_pasteboard)
		init_pasteboard();
	if (!g_pasteboard) {
		//printf("Error getting pasteboard!");
		return;
	}

	NSString *data = [[NSString alloc] initWithUTF8String:text];
	[g_pasteboard clearContents];
	[g_pasteboard setString:data forType:g_text_uti];
	[data release];

exit:
	[pool release];
}
