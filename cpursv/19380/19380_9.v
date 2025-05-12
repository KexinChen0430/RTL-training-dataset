
module timer32(clk,reset,din,dout,wren,rden,addr);

  input  clk,reset,wren,rden;
  input  [31:0] din;
  output [31:0] dout;
  input  [1:0] addr;
  reg  [31:0] out,out2,timer,period;
  reg  [2:0] control;
  parameter  PERIOD = 32'h0000000F;
  parameter  ENBIT = 1'b0;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            timer <= 32'h00000000;
            period <= PERIOD;
            control[0] = ENBIT;
            control[1] = 0;
            control[2] = 0;
          end
        else 
          begin
            if (control[0]) 
              begin
                timer <= timer+1;
              end
              
            if ((control[1] & rden) & (addr == 2'b10)) control[1] = ~control[1];
              
            if (timer == period) 
              begin
                control[1] = 1;
                control[2] = ~control[2];
                timer <= 32'h00000000;
              end
              
            if ((addr == 2'b01) & wren) period <= din;
              
            if ((addr == 2'b10) & wren) 
              begin
                control[1] = ~control[1];
                control[0] = din[0];
                control[1] = din[1];
                control[2] = din[2];
              end
              
          end
      end
  
  always @* 
      begin
        out = 32'h00000000;
        case (addr)

          2'b00: out = timer;

          2'b01: out = period;

          2'b10: out[2:0] = control;

        endcase

      end
  
  always @* 
      begin
        out2 = 32'h00000000;
        case (rden)

          1'b1: out2 = out;

        endcase

      end
  assign dout = out2;
endmodule

