
module preamble(reset,clk,m,trext,out,violation,done);

  input  clk,reset,trext;
  input  [1:0] m;
  output out,violation,done;
  reg  out,done,violation;
  reg  [5:0] clkcount;
  wire [5:0] bitcount,next_count;

  assign bitcount = (trext == 6'd1) ? clkcount : (6'd12+clkcount);
  assign next_count = (bitcount > 6'd25) ? clkcount : (6'd1+clkcount);
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            clkcount <= 0;
            done <= 0;
            out <= 0;
            violation <= 0;
          end
        else 
          begin
            if (m > 0) 
              begin

              end
            else 
              begin

              end
            clkcount <= next_count;
          end
      end
endmodule

