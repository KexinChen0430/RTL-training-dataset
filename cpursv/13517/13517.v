
module rand(input  clk,
            input  [31:0] seed,
            input  start,
            output [2:0] number);

  reg  [31:0] seed_reg;

  assign number = start ? seed[31:29] : seed_reg[31:29];
  
  always @(posedge clk)
      begin
        seed_reg <= seed_reg*1103515245;
        if (start) seed_reg <= seed;
          
      end
endmodule

