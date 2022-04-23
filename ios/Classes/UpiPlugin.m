#import "UpiPlugin.h"
#if __has_include(<upi_plugin/upi_plugin-Swift.h>)
#import <upi_plugin/upi_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "upi_plugin-Swift.h"
#endif

@implementation UpiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUpiPlugin registerWithRegistrar:registrar];
}
@end
