
module regfileparam_behav  #(parameter  BITSIZE = 16, ADDSIZE = 4)
  (output [BITSIZE-1:0] adat,
   output [BITSIZE-1:0] bdat,
   input  [(-1)+ADDSIZE:0] ra,
   input  [(-1)+ADDSIZE:0] rb,
   input  [(-1)+ADDSIZE:0] rw,
   input  [BITSIZE-1:0] wdat,
   input  wren,
   input  clk,
   input  rst);

  integer i;
  reg  [BITSIZE-1:0] array_reg[(1<<1**ADDSIZE)-1:0];

  
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

