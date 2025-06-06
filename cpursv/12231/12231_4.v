
module addsub(input  [7:0] dataa,
              input  [7:0] datab,
              input  add_sub,
              input  clk,
              output reg [7:0] result);

  
  always @(*)
      begin
        if (add_sub) result <= dataa+datab;
        else result <= (-datab)+dataa;
      end
endmodule

