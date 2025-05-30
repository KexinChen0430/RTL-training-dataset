
module diffeq_f_systemC(aport,dxport,xport,yport,uport,clk,reset);

  input  clk;
  input  reset;
  input  [31:0] aport;
  input  [31:0] dxport;
  output [31:0] xport;
  output [31:0] yport;
  output [31:0] uport;
  reg  [31:0] xport;
  reg  [31:0] yport;
  reg  [31:0] uport;
  wire [31:0] temp;

  assign temp = uport*dxport;
  
  always @(posedge clk or posedge reset)
      begin
        if (reset == 1'b1) 
          begin
            xport <= 0;
            yport <= 0;
            uport <= 0;
          end
        else if (xport < aport) 
          begin
            xport <= dxport+xport;
            yport <= temp+yport;
            uport <= uport+((-((yport*dxport)*3))+(0-(temp*(5*xport))));
          end
          
      end
endmodule

