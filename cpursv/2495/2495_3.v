
module genframe(input  wire clk,
                input  wire mode,
                output reg [2:0] r,
                output reg [2:0] g,
                output reg [2:0] b,
                output reg csync);

  reg  [9:0]  hc = 10'd0;
  reg  [9:0]  vc = 10'd0;
  reg   intprog = 1'b0;

  
  always @(posedge clk)
      begin
        if (hc != 10'd639) 
          begin
            hc <= hc+10'd1;
          end
        else 
          begin
            hc <= 10'd0;
            if (intprog == 1'b0) 
              begin
                if (vc != 624) 
                  begin
                    vc <= 10'd1+vc;
                  end
                else 
                  begin
                    vc <= 10'd0;
                    intprog <= mode;
                  end
              end
            else 
              begin
                if (vc != 311) 
                  begin
                    vc <= 10'd1+vc;
                  end
                else 
                  begin
                    vc <= 10'd0;
                    intprog <= mode;
                  end
              end
          end
      end
  reg  videoen;

  
  always @* 
      begin
        csync = 1'b1;
        videoen = 1'b0;
      end
  
  always @* 
      begin
        r = 3'b000;
        g = 3'b000;
        b = 3'b000;
        if (videoen == 1'b1) 
          begin

          end
          
      end
endmodule

