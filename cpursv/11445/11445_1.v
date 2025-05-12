
module gen_test7;

  reg  [2:0] out1;
  reg  [2:0] out2;
  wire [2:0] out3;

  
  generate
      begin : cond
        reg  [2:0] sub_out1;

        reg  [2:0] sub_out2;

        wire [2:0] sub_out3;

        
        initial  
        begin : init
          reg  signed  [31:0] x;

          x = 2**2;
          out1 = x;
          sub_out1 = x;
        end
        
        always @* 
            begin : proc
              reg  signed  [31:0] x;

              x = 2;
              out2 = x;
              sub_out2 = x;
            end
        genvar x;
        for (x = 0; x < 3; x = x+1)
            begin
              assign out3[x] = 1;
              assign sub_out3[x] = 1;
            end
      end
  endgenerate

endmodule

