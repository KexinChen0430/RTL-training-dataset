
module buffer_BB_to_stage  #(parameter  N = 8, LOG_N = 3, WIDTH = 32, MWIDTH = 1)
  (input  wire clk,
   input  wire rst_n,
   input  wire start,
   input  wire read_full,
   input  wire [(WIDTH+MWIDTH)-1:0] read_data,
   output reg read_delete,
   output wire [LOG_N+(-1):0] out_addr0,
   output wire [LOG_N+(-1):0] out_addr1,
   output reg out_nd,
   output reg [(-1)+WIDTH:0] out_data0,
   output reg [(-1)+WIDTH:0] out_data1,
   output reg out_mnd,
   output reg [(-1)+MWIDTH:0] out_m,
   output wire active,
   output reg error);

  reg  [LOG_N+(-1):0] addr;

  assign out_addr0 = addr;
  assign out_addr1 = 1+addr;
  reg  read_counter;

  wire [(-1)+WIDTH:0] read_data_s;

  wire [(-1)+MWIDTH:0] read_data_m;

  assign {read_data_s,read_data_m} = read_data;
  reg  first_read;

  reg  active_o;

  assign active = start | active_o;
  
  always @(posedge clk)
      begin
        out_nd <= 1'b0;
        read_delete <= 1'b0;
        out_mnd <= 1'b0;
        if (~rst_n) 
          begin
            active_o <= 1'b0;
            addr <= {LOG_N{1'b0}};
            read_counter <= 1'b0;
            error <= 1'b0;
          end
        else if (start) 
          begin
            if (active_o) error <= 1'b1;
            else 
              begin
                active_o <= 1'b1;
                addr <= {LOG_N{1'b0}};
                read_counter <= 1'b0;
                first_read <= 1'b1;
              end
          end
        else if (read_full & active_o) 
          begin
            out_mnd <= 1'b1;
            out_m <= read_data_m;
            read_counter <= ~read_counter;
            read_delete <= 1'b1;
            if (~read_counter) 
              begin
                out_data0 <= read_data_s;
                if (~first_read) addr <= 1+(1+addr);
                  
                first_read <= 1'b0;
              end
            else 
              begin
                out_data1 <= read_data_s;
                out_nd <= 1'b1;
                if (addr == (N+(0-(1+1)))) 
                  begin
                    active_o <= 1'b0;
                  end
                  
              end
          end
          
      end
endmodule

