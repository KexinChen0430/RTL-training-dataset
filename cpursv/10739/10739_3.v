
module cameraReader  #(parameter  x_size = 640, y_size = 480)
  (input  clk,
   input  reset_n,
   output refclk,
   input  pclk,
   input  [7:0] data,
   input  vsync,
   input  hsync,
   output reg [15:0]  data_out = 0,
   output wire wrreq,
   output wire wrclk);

  reg  [19:0]  pixel_counter = 0;

  assign refclk = (reset_n == 1) ? clk : 0;
  reg   vsync_passed = 0;

  reg   write_pixel = 0;

  reg   wrclk1 = 0;

  
  always @(posedge pclk)  wrclk1 <= ~wrclk1;
  
  always @(negedge wrclk1)
      begin
        if (hsync == 1) write_pixel <= 1;
        else write_pixel <= 0;
      end
  reg  [7:0] subpixel;

  reg  [15:0] current_pixel;

  
  always @(posedge wrreq)
      begin
        data_out <= current_pixel;
      end
  
  always @(posedge pclk)
      begin
        if (reset_n == 0) 
          begin
            pixel_counter <= 0;
            vsync_passed <= 0;
          end
        else 
          begin
            if (vsync == 1) 
              begin
                pixel_counter <= 0;
                vsync_passed <= 1;
              end
            else if ((vsync_passed == 1) && (hsync == 1)) 
              begin
                if (pixel_counter[0] == 0) 
                  begin
                    pixel_counter <= 1+pixel_counter;
                    subpixel <= data;
                  end
                else 
                  begin
                    current_pixel <= {subpixel,data};
                    pixel_counter <= 1+pixel_counter;
                  end
              end
            else 
              begin
                if (write_pixel == 1) pixel_counter <= 1+pixel_counter;
                else pixel_counter <= 0;
              end
          end
      end
  assign wrreq = ((pixel_counter > 2) && (write_pixel == 1)) ? wrclk1 : 0;
  assign wrclk = ~pclk;
endmodule

