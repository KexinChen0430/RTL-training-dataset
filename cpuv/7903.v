module VGAGenerator
#(
    parameter pixel_freq=25_000_000, 
    parameter clock_freq=150_000_000, 
    parameter VRAM_freq=50_000_000, 
    parameter line_front_porch=16, 
    parameter line_sync_pulse=96, 
    parameter line_active_video=640, 
    parameter line_back_porch=48, 
    parameter frame_front_porch=10, 
    parameter frame_sync_pulse=2, 
    parameter frame_active_video=480, 
    parameter frame_back_porch=33, 
    parameter VRAM_address_lines=18, 
    parameter vga_red_bits=3, 
    parameter vga_green_bits=3, 
    parameter vga_blue_bits=2, 
    parameter bus_device_id=1, 
    parameter bus_max_devices=16, 
    parameter bus_width=32 
)
(
    input clk, 
    input enable, 
    inout [bus_width-1:0] bus_data_lines, 
    inout [bus_max_devices-1:0] bus_receiver_device, 
    input [bus_max_devices-1:0] voice, 
    inout [bus_max_devices-1:0] buffer_full, 
    output bus_write_request, 
    output hsync, 
    output vsync, 
    output [vga_red_bits-1:0] red, 
    output [vga_green_bits-1:0] green, 
    output [vga_blue_bits-1:0] blue 
);
    specparam line_past_front_porch=line_front_porch;
    specparam line_past_sync_pulse=line_past_front_porch+line_sync_pulse;
    specparam line_past_back_porch=line_past_sync_pulse+line_back_porch;
    specparam line_past_active_video=line_past_back_porch+line_active_video;
    specparam frame_past_front_porch=frame_front_porch;
    specparam frame_past_sync_pulse=frame_past_front_porch+frame_sync_pulse;
    specparam frame_past_back_porch=frame_past_sync_pulse+frame_back_porch;
    specparam frame_past_active_video=frame_past_back_porch+frame_active_video;
    specparam pixels_per_line=line_past_active_video; 
    specparam lines_per_frame=frame_past_active_video; 
    specparam ticks_per_pixel=clock_freq/pixel_freq; 
    specparam pixel_bits=vga_red_bits+vga_green_bits+vga_blue_bits; 
    reg [15:0] current_line; 
    reg [15:0] current_pixel; 
    reg [VRAM_address_lines-1:0] next_read_address; 
    reg [pixel_bits-1:0] current_pixel_data; 
    reg [pixel_bits-1:0] next_pixel_data; 
    reg no_next_pixel_in_buffer; 
    reg [7:0] next_pixel_timer; 
    reg request_new_pixels; 
    assign bus_data_lines=voice ?   : 'bz; 
    assign bus_sender_device=voice ? bus_device_id : 'bz; 
    assign bus_receiver_device=voice ? VRAM_bus_id : 'bz; 
    assign bus_write_request=request_new_pixels; 
    assign bus_buffer_full=0; 
    wire active_video=current_line<frame_past_active_video && current_line>=frame_past_back_porch
        && current_pixel<line_past_active_video && current_pixel>=line_past_back_porch;
    assign vsync=~(current_line<frame_past_sync_pulse && current_line>=frame_past_front_porch); 
    assign hsync=~(current_pixel<line_past_sync_pulse && current_pixel>=line_past_front_porch); 
    wire [vga_red_bits-1:0] current_pixel_red=current_pixel_data[pixel_bits-1:pixel_bits-vga_red_bits];
    wire [vga_green_bits-1:0] current_pixel_green=current_pixel_data[pixel_bits-vga_red_bits-1:vga_blue_bits];
    wire [vga_blue_bits-1:0] current_pixel_blue=current_pixel_data[vga_blue_bits-1:0];
    assign red=active_video ? current_pixel_red : 0;
    assign green=active_video ? current_pixel_green : 0;
    assign blue=active_video ? current_pixel_blue : 0;
    always @(posedge clk) begin
        if (enable) begin 
            if (~next_pixel_timer) begin 
                if (current_pixel<pixels_per_line) begin 
                    current_pixel<=current_pixel+1; 
                end
                else begin 
                    if (current_line<lines_per_frame) 
                        current_line<=current_line+1; 
                    else
                        current_line<=1; 
                    current_pixel<=1; 
                end
                next_pixel_timer<=ticks_per_pixel-1; 
                if (~no_next_pixel_in_buffer) begin 
                    request_new_pixels<=1; 
                    next_read_address<=(pixels_per_line*current_line+current_pixel+1)/2; 
                end
                else begin 
                    current_pixel_data<=next_pixel_data; 
                    no_next_pixel_in_buffer<=1; 
                end
            end
            else begin 
                next_pixel_timer<=next_pixel_timer-1; 
                if (request_new_pixels) begin 
                end
            end
        end
    end
endmodule