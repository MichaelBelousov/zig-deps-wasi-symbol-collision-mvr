const std = @import("std");
const binaryen = @import("binaryen");
const WebBackend = @import("WebBackend");
const dvui = @import("dvui");

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!

}

export fn app_init(platform_ptr: [*]const u8, platform_len: usize) i32 {
    _ = platform_ptr;
    _ = platform_len;
    return 0;
}

export fn app_deinit() void {}
export fn app_update() void {
    _ = dvui.FPS();
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
