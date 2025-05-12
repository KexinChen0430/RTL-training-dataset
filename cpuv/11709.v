module sirv_sim_ram 
#(parameter DP = 512, 
  parameter FORCE_X2ZERO = 0, 
  parameter DW = 32, 
  parameter MW = 4, 
  parameter AW = 32 
)
(
  input             clk, 
  input  [DW-1  :0] din, 
  input  [AW-1  :0] addr, 
  input             cs, 
  input             we, 
  input  [MW-1:0]   wem, 
  output [DW-1:0]   dout 
);
    reg [DW-1:0] mem_r [0:DP-1]; 
    reg [AW-1:0] addr_r; 
    wire [MW-1:0] wen; 
    wire ren; 
    assign ren = cs & (~we); 
    assign wen = ({MW{cs & we}} & wem); 
    genvar i; 
    always @(posedge clk) 
    begin
        if (ren) begin 
            addr_r <= addr; 
        end
    end
    generate 
      for (i = 0; i < MW; i = i+1) begin :mem 
        if((8*i+8) > DW ) begin: last 
          always @(posedge clk) begin 
            if (wen[i]) begin 
               mem_r[addr][DW-1:8*i] <= din[DW-1:8*i]; 
            end
          end
        end
        else begin: non_last 
          always @(posedge clk) begin 
            if (wen[i]) begin 
               mem_r[addr][8*i+7:8*i] <= din[8*i+7:8*i]; 
            end
          end
        end
      end
    endgenerate 
  wire [DW-1:0] dout_pre; 
  assign dout_pre = mem_r[addr_r]; 
  generate 
   if(FORCE_X2ZERO == 1) begin: force_x_to_zero 
      for (i = 0; i < DW; i = i+1) begin:force_x_gen 
          `ifndef SYNTHESIS
         assign dout[i] = (dout_pre[i] === 1'bx) ? 1'b0 : dout_pre[i]; 
          `else
         assign dout[i] = dout_pre[i]; 
          `endif
      end
   end
   else begin:no_force_x_to_zero 
     assign dout = dout_pre; 
   end
  endgenerate 
endmodule 