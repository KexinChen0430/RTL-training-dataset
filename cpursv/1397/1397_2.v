
module regfile(input  wire clock,
               input  wire enable,
               input  wire [4:0] rdaddress_a,
               input  wire [4:0] rdaddress_b,
               input  wire wren,
               input  wire [4:0] wraddress,
               input  wire [31:0] data,
               output reg [31:0] qa,
               output reg [31:0] qb);

  reg  [31:0] regs[31:0];

  
  always @(posedge clock)
      if (enable) 
        begin
          if (wren) regs[wraddress] <= data;
            
          qa <= regs[rdaddress_a];
          qb <= regs[rdaddress_b];
        end
        
  reg  [7:0] i;

  
  initial  
  begin
    i = 0;
    repeat (32)
      begin
        regs[i] = 0;
        i = 1+i;
      end
  end
endmodule

