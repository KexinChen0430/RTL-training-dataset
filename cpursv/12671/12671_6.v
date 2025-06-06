
module stage_to_out  #(parameter  N = 8, LOG_N = 3, WIDTH = 32, MWIDTH = 1)
  (input  wire clk,
   input  wire rst_n,
   input  wire start,
   output reg [LOG_N-1:0] addr,
   input  wire [(-1)+WIDTH:0] in_data,
   output reg out_mread,
   input  wire in_mfull,
   input  wire [(-1)+MWIDTH:0] in_m,
   output reg out_nd,
   output reg [(-1)+WIDTH:0] out_data,
   output reg [(-1)+MWIDTH:0] out_m,
   output wire active,
   output reg error);

  reg  active_o;

  assign active = active_o | start;
  
  always @(posedge clk)
      begin
        out_nd <= 1'b0;
        out_mread <= 1'b0;
        if (~rst_n) 
          begin
            active_o <= 1'b0;
            addr <= {LOG_N{1'b0}};
            error <= 1'b0;
          end
        else if (start) 
          begin
            if (active_o) error <= 1'b1;
            else 
              begin
                active_o <= 1'b1;
                addr <= {LOG_N{1'b0}};
              end
          end
        else if (active_o) 
          begin
            out_mread <= 1'b1;
            out_nd <= 1'b1;
            out_data <= in_data;
            out_m <= in_m;
            if (~in_mfull) error <= 1'b1;
              
            if (addr == ((-1)+N)) 
              begin
                active_o <= 1'b0;
              end
            else addr <= addr+1;
          end
          
      end
endmodule

