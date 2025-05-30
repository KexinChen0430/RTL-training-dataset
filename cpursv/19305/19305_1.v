
module inferred_ram(clka,clkb,ena,enb,wea,addra,addrb,dia,doa,dob);

  input  clka,clkb;
  input  wea;
  input  ena,enb;
  input  [10:0] addra,addrb;
  input  [31:0] dia;
  output reg [31:0] doa,dob;
  reg  [31:0] RAM[2047:0];

  
  always @(posedge clka)
      begin
        if (ena) 
          begin
            if (wea) 
              begin
                RAM[addra] <= dia;
                $display("RAM: %x written to %x",dia,addra);
              end
              
            doa <= RAM[addra];
          end
          
      end
  
  always @(posedge clkb)
      begin
        if (enb) 
          begin
            dob <= RAM[addrb];
          end
          
      end
endmodule

