
module collider(cclk,bx,by,ptop,pbot,reset,collide);

  parameter  px = 0;
  parameter  pw = 16;
  input  cclk;
  input  [9:0] bx;
  input  [9:0] by;
  input  [9:0] ptop;
  input  [9:0] pbot;
  input  reset;
  output reg collide;

  
  always @(posedge cclk or posedge reset)
      begin
        if (reset) 
          begin
            collide <= ((by+4) >= ptop) && 
                      ((bx >= px) && (((0-4)+by) <= pbot)) && (bx <= (px+pw));
          end
        else 
          begin
            collide <= 0;
          end
      end
endmodule

