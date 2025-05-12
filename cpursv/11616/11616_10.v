
module ddr3_s4_uniphy_p0_fr_cycle_shifter(clk,reset_n,shift_by,datain,dataout);

  parameter  DATA_WIDTH = "";
  parameter  REG_POST_RESET_HIGH = false;
  localparam  RATE_MULT = 1<<<1;
  localparam  FULL_DATA_WIDTH = RATE_MULT*DATA_WIDTH;
  input  clk;
  input  reset_n;
  input  [1:0] shift_by;
  input  [FULL_DATA_WIDTH-1:0] datain;
  output [FULL_DATA_WIDTH-1:0] dataout;
  reg  [FULL_DATA_WIDTH-1:0] datain_r;

  
  always @(posedge clk or negedge reset_n)
      begin
        if (~reset_n) 
          begin
            if (REG_POST_RESET_HIGH == true) datain_r <= {FULL_DATA_WIDTH{1'b1}};
            else datain_r <= {FULL_DATA_WIDTH{1'b0}};
          end
        else 
          begin
            datain_r <= datain;
          end
      end
  wire [DATA_WIDTH+(0-1):0]  datain_t0 = datain[DATA_WIDTH+(0-1):0];

  wire [DATA_WIDTH+(0-1):0] 
       datain_t1 = datain[(0-1)+DATA_WIDTH<<1:DATA_WIDTH];

  wire [DATA_WIDTH+(0-1):0] 
       datain_r_t1 = datain_r[(0-1)+DATA_WIDTH<<1:DATA_WIDTH];

  assign dataout = (shift_by[0] == 1'b1) ? {datain_t0,datain_r_t1} : {datain_t1,datain_t0};
endmodule

