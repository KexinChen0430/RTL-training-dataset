
module rrp_arbiter  #(parameter  WIDTH = 4)
  (input  wire RST,
   input  wire CLK,
   input  wire [WIDTH-1:0] WRITE_REQ,
   input  wire [WIDTH-1:0] HOLD_REQ,
   input  wire [(WIDTH*32)-1:0] DATA_IN,
   output wire [WIDTH-1:0] READ_GRANT,
   input  wire READY_OUT,
   output wire WRITE_OUT,
   output wire [31:0] DATA_OUT);

  integer m;
  reg  [WIDTH-1:0] prev_select;
  reg  [WIDTH-1:0] select;
  reg  hold;
  wire WRITE_REQ_OR,HOLD_REQ_OR;

  assign WRITE_REQ_OR = |WRITE_REQ;
  assign HOLD_REQ_OR = |HOLD_REQ;
  assign WRITE_OUT = |(READ_GRANT & (WRITE_REQ & select));
  
  always @(*)
      begin
        select = prev_select;
        if (!hold && HOLD_REQ_OR) 
          begin
            m = 0;
            select = 1;
            while ((m < WIDTH) && !(HOLD_REQ & select))
              begin
                m = 1+m;
                select = 1<<<m;
              end
          end
        else if (!hold && WRITE_REQ_OR) 
          begin
            m = 0;
            select = prev_select*2;
            if (select == 0) select = 1;
              
            while (!(WRITE_REQ & select) && (m < WIDTH))
              begin
                m = 1+m;
                select = select<<1;
                if (select == 0) select = 1;
                  
              end
          end
          
      end
  
  always @(posedge CLK)
      begin
        if (RST) prev_select <= 1<<<WIDTH<<<0-1;
        else if (WRITE_REQ_OR & !hold) prev_select <= select;
          
      end
  
  always @(posedge CLK)
      begin
        if (RST) hold <= 0;
        else if (READY_OUT) hold <= 0;
        else if (WRITE_OUT) hold <= 1;
          
      end
  wire [WIDTH-1:0] DATA_A[31:0];

  genvar i,j;
  
  generate
      for (i = 0; i < 32; i = i+1)
          begin : gen
            for (j = 0; j < WIDTH; j = j+1)
                begin : gen2
                  assign DATA_A[i][j] = DATA_IN[i+(32*j)];
                end
          end
  endgenerate

  
  generate
      for (i = 0; i < 32; i = i+1)
          begin : gen3
            assign DATA_OUT[i] = |(DATA_A[i] & select);
          end
  endgenerate

  assign READ_GRANT = ({WIDTH{READY_OUT}} & select) & WRITE_REQ;
endmodule

