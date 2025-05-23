module vga_controller(pixel_clock, reset, hsync, vsync, pixel_count, line_count);
    input pixel_clock;
    input reset;
    output hsync;
    output vsync;
    output [9:0] pixel_count;
    output [9:0] line_count;
    reg hsync, vsync;
    reg [9:0] pixel_count, line_count;
    wire [9:0] next_pixel, next_line;
    parameter NUM_LINES = 525;
    parameter NUM_PIXELS = 800;
    parameter WIDTH = 640;
    parameter HEIGHT = 480;
    parameter H_FRONT_PORCH = 16;
    parameter H_SYNC = 96;
    parameter H_BACK_PORCH = 48;
    parameter V_FRONT_PORCH = 11;
    parameter V_SYNC = 2;
    parameter V_BACK_PORCH = 32;
    always @(posedge pixel_clock) begin
        if(reset) begin
            pixel_count <= 10'b0;
            line_count <= 10'b0;
            hsync <= 1;
            vsync <= 1;
        end else begin
            pixel_count <= next_pixel;
            line_count <= next_line;
            hsync <= ~((next_pixel >= WIDTH + H_FRONT_PORCH) &
                          (next_pixel < WIDTH + H_FRONT_PORCH + H_SYNC));
            vsync <= ~((next_line >= HEIGHT + V_FRONT_PORCH) &
                          (next_line < HEIGHT + V_FRONT_PORCH + V_SYNC));
        end
    end
    assign next_pixel = (pixel_count >= NUM_PIXELS - 1) ? 1'b0 : pixel_count + 1'b1;
    assign next_line = (pixel_count >= NUM_PIXELS - 1) ?
                                ((line_count >= NUM_LINES - 1) ? 1'b0 : line_count + 1'b1) : line_count;
endmodule