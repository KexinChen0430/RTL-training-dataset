
module regfileparam_behav  #(parameter  BITSIZE = 16, ADDSIZE = 4)
  (output [(0-1)+BITSIZE:0] adat,
   output [(0-1)+BITSIZE:0] bdat,
   input  [(0-1)+ADDSIZE:0] ra,
   input  [(0-1)+ADDSIZE:0] rb,
   input  [(0-1)+ADDSIZE:0] rw,
   input  [(0-1)+BITSIZE:0] wdat,
   input  wren,
   input  clk,
   input  rst);

  integer i;
  reg  [(0-1)+BITSIZE:0] array_reg[(0-1)+(1<<1**ADDSIZE):0];

  
  always @(posedge clk or negedge rst)
      begin
        if (~rst) 
          begin
            for (i = 0; i < (1<<1**ADDSIZE); i = 1+i)
                begin
                  array_reg[i] <= 0;
                end
          end
        else if (wren) 
          begin
            array_reg[rw] <= wdat;
          end
          
      end
  assign adat = array_reg[ra];
  assign bdat = array_reg[rb];
endmodule

