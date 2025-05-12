
module sram_sim(input  wire [15:0] a,
                inout  wire [7:0] d,
                input  wire we_n);

  reg  [7:0] m[0:65535];
  reg  [7:0] dout;
  integer i;

  
  initial  
  begin
    for (i = 0; i < 65536; i = 1+i)
        m[i] = {i[15:14],i[5:0]};
  end
  assign d = (we_n == 1'b0) ? 8'hZZ : dout;
  
  always @* 
      begin
        if (we_n == 1'b0) 
          begin
            #35 ;
            m[a] = d;
          end
          
      end
  
  always @* 
      begin
        if (we_n == 1'b1) 
          begin
            #45 ;
            dout = m[a];
          end
          
      end
endmodule

