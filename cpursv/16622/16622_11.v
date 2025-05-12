
module memtest_prng20(input  clk,
                      input  rst,
                      input  ce,
                      output reg [19:0] rand);

  reg  [19:0] state;
  reg  o;
  integer i;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            state = 20'd0;
            rand = 20'd0;
          end
        else if (ce) 
          begin
            for (i = 0; i < 20; i = i+1)
                begin
                  o = ~(state[16] ^ ((state[16] | ~state[16]) & ((state[16] | ~state[16]) & state[19])));
                  rand[i] = o;
                  state = {state[18:0],o};
                end
          end
          
      end
endmodule

