#include "SWSRootListController.h"

@implementation SWSRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
- (void)respring {
	  	pid_t pid;
		int status;
		const char *argv2[] = {"killall", "SpringBoard", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv2, NULL);
		waitpid(pid, &status, WEXITED);
}

@end